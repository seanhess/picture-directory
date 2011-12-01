{-# LANGUAGE OverloadedStrings #-}

import Hack2
import Hack2.Handler.SnapServer (run)
import Hack2.Contrib.Response (set_body_bytestring)
import Hack2.Contrib.Utils (empty_app, use)
import Hack2.Contrib.Middleware.Static (static)
import Hack2.Contrib.Middleware.URLMap (url_map)
    
import Data.Default (def)

import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as L

import Air.Light
import Prelude hiding ((^), (-), (.))





main = run app

app :: Application
app env = do
    let matched = (route - env.pathInfo)
    use [ logPath
        , static (Just "./public") ["/test.txt"]
        ] matched env

route :: B.ByteString -> Application
route "/hello" = \env -> text "Hello World"
route _ = \env -> text "EMPTY"

logPath :: Middleware
logPath app = \env -> do 
    print - env.pathInfo
    app env

text :: L.ByteString -> IO Response
text message = do
    let response = Response 200 [ ("Content-Type", "text/plain") ] def
    return - set_body_bytestring message response 

-- hack2         - https://github.com/nfjinjing/hack2
-- hack2-contrib - https://github.com/nfjinjing/hack2-contrib/tree/master/src/Hack2/Contrib
-- URLMap        - https://github.com/nfjinjing/hack2-contrib/blob/master/src/Hack2/Contrib/Middleware/URLMap.hs

