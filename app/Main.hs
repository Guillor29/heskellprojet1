{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Lib
import qualified Data.ByteString.Lazy as BL
import System.Environment (getArgs)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified Data.Vector as V
import Database.SQLite.Simple
import Control.Monad (forM_)
import System.IO (hSetEncoding, stdout, utf8)


-- Insertion dans SQLite
insertStudentsSQLite :: V.Vector Student -> IO ()
insertStudentsSQLite students = do
    conn <- open "students.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prénom TEXT, email TEXT UNIQUE)"

    let studentList = map normalizeStudent (V.toList students)

    forM_ studentList $ \student -> do
        execute conn
            "INSERT OR IGNORE INTO students (nom, prénom, email) VALUES (?, ?, ?)"
            (nom student, prénom student, email student)

    putStrLn "Étudiants insérés dans SQLite avec succès."
    close conn

-- Programme principal
main :: IO ()
main = do
    args <- getArgs
    hSetEncoding stdout utf8
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
                    putStrLn "📁 Fichier JSON généré avec succès."
                    insertStudentsSQLite students
