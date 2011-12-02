{-# LANGUAGE ScopedTypeVariables #-}

-- OverloadedStrings, 

module Main where

import Control.Applicative ((<$>), optional)
import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Happstack.Lite
-- import qualified Happstack.Server

import qualified Directory.Views as View

-- import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label)
-- import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)
-- import qualified Text.Blaze.Html5 as H
-- import qualified Text.Blaze.Html5.Attributes as A

main :: IO ()
main = serve Nothing app

app :: ServerPart Response
app = msum
    [ nullDir >>     form
    , serveDirectory DisableBrowsing [] "./public"
    , dir "hello"    hello
    ]


form :: ServerPart Response
form = ok $ toResponse $ View.mainForm

-- directory :: ServerPart Response
-- directory = do
--     body <- env.inputs -- or input_bytestring 
--     let (Just csvData) = body.lookup "data"
--     -- I want to issue an error if csvData is Nothing
--     let response = Response 200 [ ("Content-Type", "text/html") ] def
--     return - set_body_bytestring (L.fromChunks [csvData]) response

hello :: ServerPart Response
hello = ok $ toResponse "Hello"

-- import Text.Blaze.Html5 (Html, (!), a, form, input, p, toHtml, label)
-- import Text.Blaze.Html5.Attributes (action, enctype, href, name, size, type_, value)
-- import qualified Text.Blaze.Html5 as H
-- import qualified Text.Blaze.Html5.Attributes as A

-- import Hack2
-- import Hack2.Handler.SnapServer (run)
-- import Hack2.Contrib.Response (set_body_bytestring)
-- import Hack2.Contrib.Request (input_bytestring, inputs)
-- import Hack2.Contrib.Utils (empty_app, use)
-- import Hack2.Contrib.Middleware.Static (static)
-- import Hack2.Contrib.Middleware.File (file)
-- import Hack2.Contrib.Middleware.URLMap (url_map)
-- import Hack2.Contrib.Middleware.NotFound (not_found)
--     
-- import Data.Default (def)
-- 
-- import qualified Data.ByteString as B
-- import qualified Data.ByteString.Lazy as L
-- 
-- import Air.Light
-- import Prelude hiding ((^), (-), (.))
-- 
-- 
-- main = run app
-- 
-- app :: Application
-- app env = do
--     let matched = route - env.pathInfo
--     use [ logPath
--         , static (Just "./public") ["/test.txt", "/style.css"]
--         ] matched env
-- 
-- route :: B.ByteString -> Application
-- route "/hello" = \env -> text "Hello World"
-- route "/directory" = directory
-- route "/" = \env -> sendFile "./public/index.html" env
-- route _ = not_found - \_ -> def
-- 
-- logPath :: Middleware
-- logPath app = \env -> do 
--     print - env.pathInfo
--     app env
-- 
-- text :: L.ByteString -> IO Response
-- text message = do
--     let response = Response 200 [ ("Content-Type", "text/plain") ] def
--     return - set_body_bytestring message response 
-- 
-- sendFile :: B.ByteString -> Env -> IO Response
-- sendFile path env = file Nothing def (env { pathInfo = path })
-- 
-- directory :: Application
-- directory env = do 
--     body <- env.inputs -- or input_bytestring 
--     let (Just csvData) = body.lookup "data"
--     -- I want to issue an error if csvData is Nothing
--     let response = Response 200 [ ("Content-Type", "text/html") ] def
--     return - set_body_bytestring (L.fromChunks [csvData]) response

-- hack2         - https://github.com/nfjinjing/hack2
-- hack2-contrib - https://github.com/nfjinjing/hack2-contrib/tree/master/src/Hack2/Contrib
-- URLMap        - https://github.com/nfjinjing/hack2-contrib/blob/master/src/Hack2/Contrib/Middleware/URLMap.hs

-- I won't use file uploads. Just paste the contents into the field

