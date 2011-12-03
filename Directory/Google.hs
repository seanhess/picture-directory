
-- downloads a google doc
module Directory.Google (readGoogle) where

import Network.Curl
import Network.URI
import Data.Maybe

readGoogle :: String -> IO String
readGoogle docId = do
    let url = ("https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key="++docId++"&output=txt")
    (code, contents) <- curlGetString url []
    return contents

-- downloadURL url =
--     do resp <- simpleHTTP request
--        case resp of
--          Left x -> error ("Error connecting: " ++ show x)
--          Right r -> 
--              case rspCode r of
--                (2,_,_) -> return (rspBody r)
--                (3,_,_) -> -- A HTTP redirect
--                  case findHeader HdrLocation r of
--                    Nothing -> error (show r)
--                    Just url -> downloadURL url
--                _ -> error (show r)
--     where request = Request {rqURI = uri,
--                              rqMethod = GET,
--                              rqHeaders = [],
--                              rqBody = ""}
--           uri = fromJust $ parseURI url
-- 
    
