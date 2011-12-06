

module Directory.Data (Person(..), parsePeople) where

import Data.List.Split (splitOn)
import Data.List (isPrefixOf)
import Text.Regex.Posix

data Person = Person { imageUrl :: String       -- the first http:// field
                     , fullName :: String       -- the first field
                     , fields :: [String]
                     } deriving (Show, Eq)

parsePeople :: String -> [Person]
parsePeople contents = map toPerson $ lines contents
    where toPerson line = makePerson $ splitOn "\t" line

makePerson :: [String] -> Person
makePerson fields = foldl parseField (Person "" "" []) fields 

parseField :: Person -> String -> Person
parseField p s
    | "http://" `isPrefixOf` s = p { imageUrl = s }
    | null $ fullName p = p { fullName = s }
    | otherwise = p { fields = (fields p) ++ [cleanField s] }

cleanField :: String -> String
cleanField (' ':'-':'-':cs) = cs -- my wife's spreadsheet has some weird stuff in it
cleanField s = s

    

