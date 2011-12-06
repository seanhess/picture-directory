

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
    | "http" `isPrefixOf` s = p { imageUrl = s }
    | null $ fullName p = p { fullName = s }
    | otherwise = p { fields = (fields p) ++ [cleanField s] }

cleanField :: String -> String
cleanField (' ':'-':'-':cs) = cleanBirthday cs -- my wife's spreadsheet has some weird stuff in it for birthdays
cleanField s = s

cleanBirthday :: String -> String
cleanBirthday s
    | "01-" `isPrefixOf` s = "Jan " ++ day
    | "02-" `isPrefixOf` s = "Feb " ++ day
    | "03-" `isPrefixOf` s = "Mar " ++ day
    | "04-" `isPrefixOf` s = "Apr " ++ day
    | "05-" `isPrefixOf` s = "May " ++ day
    | "06-" `isPrefixOf` s = "Jun " ++ day
    | "07-" `isPrefixOf` s = "Jul " ++ day
    | "08-" `isPrefixOf` s = "Aug " ++ day
    | "09-" `isPrefixOf` s = "Sep " ++ day
    | "10-" `isPrefixOf` s = "Oct " ++ day
    | "11-" `isPrefixOf` s = "Nov " ++ day
    | "12-" `isPrefixOf` s = "Dec " ++ day
    | otherwise = s
    where day = drop 3 s

    

