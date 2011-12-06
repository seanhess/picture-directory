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
        link ! href "/css/style.css" ! rel "stylesheet" ! type_ "text/css"
        link ! href "/css/print.css" ! media "print"  ! rel "stylesheet" ! type_ "text/css"
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


googleForm :: Html
googleForm = docTypeHtml $ do
    head $ do
        title $ "Directory Creator (Google)"
        script ! src "http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" $ ""
    body $ do
        h1 "Enter Google Doc URL"
        input ! class_ "text" ! type_ "text"
        input ! class_ "submit" ! type_ "submit"


root :: Html
root = docTypeHtml $ do
    head $ do
        title $ "Directory Creator"
    body $ do
        h1 "Options"
        div $ a ! href "/google" $ "Google Doc (Better)"
        div $ a ! href "/upload" $ "Upload File"

-- does this function already exist? I couldn't seem to find it in blaze
-- how do they recommend that you render lists?
each :: [a] -> (a -> Html) -> Html
each list f = foldr (>>) "" $ map f list
