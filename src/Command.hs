module Command ( CommandProcessor(..)
               , Command(..)
               , Selector(..)
               ) where

import qualified Data.Text as T

import Entity
import Record

class CommandProcessor cp where
    applyCommand :: cp -> Command -> Either T.Text cp
    selectRecords :: cp -> Selector -> [Record]

data Selector = EntityIs T.Text deriving Show

data Command = AddEntity T.Text
             | AddEntityField T.Text T.Text FieldType
             | AddRecord T.Text [Field]
             | RemoveRecords Selector
               deriving Show
