{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    (
      encodeStudents,
      decodeStudents,
      studentsToJSON,
      normalizeStudent,
      Student(..)
    ) where

import qualified Data.Csv as Csv
import GHC.Generics (Generic)
import qualified Data.Aeson as Aeson
import Data.Aeson.Encode.Pretty (encodePretty)
import Data.Aeson (ToJSON)
import qualified Data.ByteString.Lazy as BL
import Data.Vector (Vector)
import qualified Data.Vector as V
import Data.Char (toUpper, toLower)

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

-- Mise en forme du prénom, première lettre en majuscule et le reste en minuscules
toUpperandLower :: String -> String
toUpperandLower [] = []
toUpperandLower (x:xs) = toUpper x : map toLower xs

-- Mise en forme du nom de famille en majuscule
toUpperAll :: String -> String
toUpperAll = map toUpper

-- Appliquer la mise en forme aux éléments du json
normalizeStudent :: Student -> Student
normalizeStudent s = s { nom = toUpperAll (nom s), prénom = toUpperandLower (prénom s) }

-- Conversion vers JSON avec les noms et prénoms normalisés
studentsToJSON :: Vector Student -> BL.ByteString
studentsToJSON = encodePretty . map normalizeStudent . V.toList
