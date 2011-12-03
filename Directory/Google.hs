
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
