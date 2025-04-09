{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( someFunc,
        textEncode,
        textDecode,
        lecsvdecode,
        encodeStudents,
        decodeStudents
    ) where

import Data.Text (Text)
import Data.Csv
import Data.Vector (Vector)
import Data.ByteString.Lazy
--import GHC.Generics (Generic)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

textEncode = encode [("John" :: Text, 27 :: Int), ("Jane", 28)]
textDecode = decode NoHeader "John,27\r\nJane,28\r\n" :: Either String (Vector (Text, Int))

--lecsvdecode = decode NoHeader lecsv :: Either String (Vector (String, String, String))
--lecsv = "nom,prénom,email\n\
--          \herve,guillaume,guillaume.herve@viacesi.fr\n\
--          \roger,elodie,elodie.roger@viacesi.fr\n\
--          \lemoing,pauline,pauline.lemoing@viacesi.fr\n\
--          \alves,charles,charles.alves@viacesi.fr\n\
--          \levassort,jules,jules.levassort@viacesi.fr\n\
--          \prigent,jeremy,jeremy.prigent@viacesi.fr"

--data etudiant = etudiant
--    { nom :: !String
--    , prenom :: !String
--    , email :: !String
--    }
--    deriving (Show)

--instance FromNamedRecord etudiant where
--    parseNamedRecord r = etudiant <$> r .: "nom" <*> r .: "prénom" <*> r .: "email"
--instance ToNamedRecord etudiant where
--    toNamedRecord (etudiant nom prenom email) = namedRecord
--        [ "nom" .= nom
--        , "prénom" .= prenom
--        , "email" .= email
--        ]
--instance DefaultOrdered etudiant where
--    headerOrder _ = header ["nom", "prénom", "email"]


--data Person = Person { name :: !Text , salary :: !Int }
--    deriving (Generic, Show)
--
--instance FromRecord Person
--instance ToRecord Person


type Surname = String
type GivenName = String
type Email = String
type Student = (Surname, GivenName, Email)

encodeStudents :: [Student] -> ByteString
encodeStudents s = encode s

decodeStudents :: ByteString -> Either String (Vector student)
decodeStudents str = decode HasHeader str
