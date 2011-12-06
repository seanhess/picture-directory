{-# LANGUAGE ScopedTypeVariables #-}

-- OverloadedStrings, 

module Main where

import Control.Applicative ((<$>), optional)
import Control.Monad (liftM)
import Control.Monad.IO.Class (liftIO)

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import Data.Text.Lazy (unpack)
import Happstack.Lite
-- import qualified Happstack.Server

import Directory.Data
import Directory.Google

import qualified Directory.Views as View

main :: IO ()
main = serve Nothing app

app :: ServerPart Response
app = msum
    [ method GET  >> dir "upload"    form
    , method POST >> dir "upload"    create
    , method GET  >> dir "directory" google
    , method GET  >> dir "google"    googleForm
    , method GET  >> dir "hello"     hello
    , method GET  >> nullDir >>      root
    , serveDirectory DisableBrowsing [] "./public"
    ]

form :: ServerPart Response
form = ok $ toResponse $ View.mainForm

create :: ServerPart Response
create = do
    (tmpFile, uploadName, contentType) <- lookFile "file"
    contents <- liftIO $ readFile tmpFile
    let people = parsePeople contents
    ok $ toResponse $ View.directory people

googleForm :: ServerPart Response
googleForm = ok $ toResponse $ View.googleForm

google :: ServerPart Response
google = path $ \(docId :: String) -> do
    contents <- liftIO $ readGoogle docId
    let people = parsePeople contents
    ok $ toResponse $ View.directory people

root :: ServerPart Response
root = ok $ toResponse $ View.root

hello :: ServerPart Response
hello = ok $ toResponse "Hello"


    

