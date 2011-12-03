{-# LANGUAGE OverloadedStrings #-}

module Directory.Views where

import Control.Monad (forM)

import Text.Blaze.Html5 hiding (map, address) 
import Text.Blaze.Html5.Attributes hiding (title, form)

import Prelude hiding (head, div)

import Directory.Data

mainForm :: Html
mainForm = docTypeHtml $ do
    head $ do
        title "Directory Creator"
        link ! href "/css/style.css" ! media "screen" ! rel "stylesheet" ! type_ "text/css"
    body $ do
        h1 "Paste TSV Below"
        form ! action "/" ! method "POST" ! enctype "multipart/form-data" $ do
            div $ input ! type_ "file" ! name "file"
            div $ input ! type_ "submit"
        

directory :: [Person] -> Html
directory people = docTypeHtml $ do
    head $ do
        title "Directory"
        link ! href "/css/style.css" ! media "screen" ! rel "stylesheet" ! type_ "text/css"
    body $ do
        h1 "Directory"
        each people renderPerson
        
renderPerson :: Person -> Html 
renderPerson person = do
    div ! class_ "person" $ do
        div ! class_ "image" $ img ! src (toValue (imageUrl person))
        div ! class_ "name" $ b $ toHtml $ fullName person
        each (fields person) $ \s -> do
            div ! class_ "field" $ toHtml s

-- does this function already exist? I couldn't seem to find it in blaze
-- how do they recommend that you render lists?
each :: [a] -> (a -> Html) -> Html
each list f = foldr (>>) "" $ map f list
