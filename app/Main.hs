{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Lib
import qualified Data.ByteString.Lazy as BL
import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    if null args
        then putStrLn "Veuillez fournir le nom du fichier CSV."
        else do
            let csvFile = head args
            csvData <- BL.readFile csvFile
            case decodeStudents csvData of
                Left err -> putStrLn ("Erreur de décodage : " ++ err)
                Right students -> do
                    print students
                    let jsonOutput = studentsToJSON students
                    BL.writeFile "students.json" jsonOutput
                    putStrLn "Fichier json généré avec succès."
