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
        foldr (>>) "" $ map renderPerson people
        

renderPerson :: Person -> Html 
renderPerson person = do
    div ! class_ "person" $ do
        div ! class_ "image" $ img ! src (toValue (image person))
        div ! class_ "name" $ b $ toHtml $ fullName person
        div ! class_ "birthday" $ toHtml $ birthday person
        div ! class_ "email" $ toHtml $ email person
        div ! class_ "cell" $ toHtml $ cell person
        div ! class_ "home" $ toHtml $ home person
        div ! class_ "address" $ toHtml $ address person


woot :: String
woot = "woot"

