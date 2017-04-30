module Main where

import qualified Data.Text as T
import Buckwheat
import Command

main :: IO ()
main = putStrLn $ show $ applyCommand emptyDatabase (AddEntity $ T.pack "Hello")
