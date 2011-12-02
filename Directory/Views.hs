{-# LANGUAGE OverloadedStrings #-}

module Directory.Views where

import Text.Blaze.Html5 
import Text.Blaze.Html5.Attributes hiding (title, form)

import Prelude hiding (head, div)

mainForm :: Html
mainForm = docTypeHtml $ do
    head $ do
        title "Directory Creator"
        link ! href "/style.css" ! media "screen" ! rel "stylesheet" ! type_ "text/css"
    body $ do
        h1 "Paste CSV Below"
        form ! action "/directory" ! method "POST" ! enctype "multipart/mime" $ do
            div $ input ! type_ "file" ! name "file"
            div $ input ! type_ "submit"
        
        
        
        
-- 
-- 
-- 
-- <!DOCTYPE html>
-- <html>
-- <head>
--     <link href="/style.css" media="screen" rel="stylesheet" type="text/css" />
-- </head>
-- <body class="create">
-- 
-- <h1>Paste CSV Below</h1>
-- <form action="/directory" method="POST">
--     <textarea name="data"></textarea>
--     <input type="submit">
-- </form>
-- 
-- </body>
-- </html>
