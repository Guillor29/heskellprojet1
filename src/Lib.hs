{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    (
      encodeStudents,
      decodeStudents,
      studentsToJSON,
      Student(..)
    ) where

import qualified Data.Csv as Csv
import GHC.Generics (Generic)
import qualified Data.Aeson as Aeson
import Data.Aeson (ToJSON)
import qualified Data.ByteString.Lazy as BL
import Data.Vector (Vector)
import qualified Data.Vector as V

-- Définition de Student comme record
data Student = Student
    { nom     :: String
    , prénom  :: String
    , email   :: String
    } deriving (Show, Generic)

instance Csv.FromRecord Student
instance Csv.ToRecord Student
instance ToJSON Student


-- Encodage CSV
encodeStudents :: [Student] -> BL.ByteString
encodeStudents s = Csv.encode s

-- Décodage CSV
decodeStudents :: BL.ByteString -> Either String (Vector Student)
decodeStudents str = Csv.decode Csv.HasHeader str

-- Conversion vers JSON
studentsToJSON :: Vector Student -> BL.ByteString
studentsToJSON = Aeson.encode . V.toList
