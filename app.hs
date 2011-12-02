{-# LANGUAGE OverloadedStrings #-}

import Hack2
import Hack2.Handler.SnapServer (run)
import Hack2.Contrib.Response (set_body_bytestring)
import Hack2.Contrib.Request (input_bytestring, inputs)
import Hack2.Contrib.Utils (empty_app, use)
import Hack2.Contrib.Middleware.Static (static)
import Hack2.Contrib.Middleware.File (file)
import Hack2.Contrib.Middleware.URLMap (url_map)
import Hack2.Contrib.Middleware.NotFound (not_found)
    
import Data.Default (def)

import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as L

import Air.Light
import Prelude hiding ((^), (-), (.))


main = run app

app :: Application
app env = do
    let matched = route - env.pathInfo
    use [ logPath
        , static (Just "./public") ["/test.txt", "/style.css"]
        ] matched env

route :: B.ByteString -> Application
route "/hello" = \env -> text "Hello World"
route "/directory" = directory
route "/" = \env -> sendFile "./public/index.html" env
route _ = not_found - \_ -> def

logPath :: Middleware
logPath app = \env -> do 
    print - env.pathInfo
    app env

text :: L.ByteString -> IO Response
text message = do
    let response = Response 200 [ ("Content-Type", "text/plain") ] def
    return - set_body_bytestring message response 

sendFile :: B.ByteString -> Env -> IO Response
sendFile path env = file Nothing def (env { pathInfo = path })

directory :: Application
directory env = do 
    -- body <- env.inputs -- or input_bytestring 
    -- let (Just csvData) = body.lookup "data"
    -- I want to issue an error if csvData is Nothing

    body <- env.input_bytestring
    print "HI"
    let response = Response 200 [ ("Content-Type", "text/html") ] def
    return - set_body_bytestring "Directory" response

-- hack2         - https://github.com/nfjinjing/hack2
-- hack2-contrib - https://github.com/nfjinjing/hack2-contrib/tree/master/src/Hack2/Contrib
-- URLMap        - https://github.com/nfjinjing/hack2-contrib/blob/master/src/Hack2/Contrib/Middleware/URLMap.hs

-- I won't use file uploads. Just paste the contents into the field

