

module Directory.Data (Person(..), parsePeople) where

import Data.List.Split (splitOn)
import Safe (atDef)

data Person = Person { fullName :: String
                     , birthday :: String
                     , email :: String
                     , cell :: String
                     , home :: String
                     , address :: String
                     , image :: String
                     } deriving (Show, Eq)

parsePeople :: String -> [Person]
parsePeople contents = map toPerson $ lines contents
    where toPerson line = makePerson $ splitOn "\t" line
         

makePerson :: [String] -> Person
makePerson parts = Person { fullName = parts `get` 0
                          , birthday = parts `get` 1
                          , email = parts `get` 2
                          , cell = parts `get` 3
                          , home = parts `get` 4
                          , address = parts `get` 5 
                          , image = parts `get` 6}

get :: [String] -> Int -> String
get = atDef " "

