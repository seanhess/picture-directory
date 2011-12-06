{-# LANGUAGE OverloadedStrings #-}

module Directory.Views where

import Control.Monad (forM)

import Text.Blaze.Html5 hiding (map, address) 
import Text.Blaze.Html5.Attributes hiding (title, form)

import Prelude hiding (head, div)

import Directory.Data
import Data.List.Split (splitEvery)

mainForm :: Html
mainForm = docTypeHtml $ do
    head $ do
        title "Directory Creator"
        link ! href "/css/style.css" ! media "screen" ! rel "stylesheet" ! type_ "text/css"
    body $ do
        h1 "Upload TSV Below"
        instructions
        form ! action "/upload" ! method "POST" ! enctype "multipart/form-data" $ do
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
        -- need to split them into pages of 9
        div ! class_ "people" $ do
            each pages $ \people -> do
                div ! class_ "page" $ each people renderPerson
    where pages = splitEvery 9 people
        
renderPerson :: Person -> Html 
renderPerson person = do
    div ! class_ "person" $ do
        div ! class_ "image" $ img ! src (toValue ("http://src.sencha.io/250/" ++ (imageUrl person)))
        div ! class_ "name" $ b $ toHtml $ fullName person
        each (fields person) $ \s -> do
            div ! class_ "field" $ toHtml s


googleForm :: Html
googleForm = docTypeHtml $ do
    head $ do
        title $ "Directory Creator (Google)"
        script ! src "http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" $ ""
        script ! src "/js/googleForm.js" $ ""
        link ! href "/css/style.css" ! rel "stylesheet" ! type_ "text/css"
    body ! class_ "google" $ do
        h1 "Enter Google Doc URL"
        instructions
        div $ input ! class_ "url" ! type_ "text" ! placeholder "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Av8U7ClGoQIndDlvRXRSWm5oQmoxNldPVUZ4LWtiZHc&output=html"
        div $ input ! class_ "submit" ! type_ "submit"


root :: Html
root = docTypeHtml $ do
    head $ do
        title $ "Directory Creator"
    body $ do
        h1 "Options"
        div $ a ! href "/google" $ "Google Doc (Better)"
        div $ a ! href "/upload" $ "Upload File"

instructions :: Html
instructions = p ! class_ "instructions" $ "The directory will print the fields of your document in order, except for the image url, which it will use for the image. For example: 'name', 'birthday', 'phone', 'email', 'url'. Don't put headers in the doc."

-- does this function already exist? I couldn't seem to find it in blaze
-- how do they recommend that you render lists?
each :: [a] -> (a -> Html) -> Html
each list f = foldr (>>) "" $ map f list
