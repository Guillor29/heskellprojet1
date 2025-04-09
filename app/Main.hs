{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib
import qualified Data.ByteString.Lazy as BL

main :: IO ()
main = do
    csvData <- BL.readFile "students.csv"
    case decodeStudents csvData of
        Left err -> putStrLn ("Erreur de décodage : " ++ err)
        Right students -> print students
