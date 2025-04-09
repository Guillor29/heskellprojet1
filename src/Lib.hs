{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc,
        textEncode,
    ) where

import Data.Text (Text)
import Data.Csv

someFunc :: IO ()
someFunc = putStrLn "someFunc"

textEncode = encode [("John" :: Text, 27 :: Int), ("Jane", 28)]

--import Data.Text    (Text)
--import GHC.Generics (Generic)
--import Data.Csv
--
--data Person = Person { name :: !Text , salary :: !Int }
--    deriving (Generic, Show)
--
--instance FromRecord Person
--instance ToRecord Person

--{-# LANGUAGE OverloadedStrings #-}
--
--import Data.Aeson (encode, ToJSON, toJSON, object, (.=))
--import Data.Text (Text)
--import qualified Data.ByteString.Lazy.Char8 as BL
--
--people :: [(Text, Int)]
--people = [("John", 27), ("Jane", 28)]
--
--peopleToJSON :: [(Text, Int)] -> BL.ByteString
--peopleToJSON xs = encode $ map (\(name, age) -> object ["name" .= name, "age" .= age]) xs
--
--main :: IO ()
--main = BL.putStrLn $ peopleToJSON people
