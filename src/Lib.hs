{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc,
        encodeStudents,
        decodeStudents
    ) where

import Data.Text (Text)
import Data.Csv
import Data.Vector (Vector)
import Data.ByteString.Lazy

someFunc :: IO ()
someFunc = putStrLn "someFunc"

--textEncode = encode [("John" :: Text, 27 :: Int), ("Jane", 28)]
--textDecode = decode NoHeader "John,27\r\nJane,28\r\n" :: Either String (Vector (Text, Int))

type Surname = String
type GivenName = String
type Email = String
type Student = (Surname, GivenName, Email)

encodeStudents :: [Student] -> ByteString
encodeStudents s = encode s

decodeStudents :: ByteString -> Either String (Vector Student)
decodeStudents str = decode HasHeader str
