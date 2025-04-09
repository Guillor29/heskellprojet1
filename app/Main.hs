module Main (main) where

import Lib

main :: IO ()
main = print (decodeStudents lecsv)

lecsv = "nom,prénom,email\n\
          \herve,guillaume,guillaume.herve@viacesi.fr\n\
          \roger,elodie,elodie.roger@viacesi.fr\n\
          \lemoing,pauline,pauline.lemoing@viacesi.fr\n\
          \alves,charles,charles.alves@viacesi.fr\n\
          \levassort,jules,jules.levassort@viacesi.fr\n\
          \prigent,jeremy,jeremy.prigent@viacesi.fr"
