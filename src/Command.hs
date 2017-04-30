module Command ( CommandProcessor
               , applyCommand
               , Command(..)
               ) where

import qualified Data.Text as T

import Entity
import Record
import Snapshot

class CommandProcessor cp where
    applyCommand :: cp -> Command -> Either T.Text cp

data Command = AddEntity T.Text
             | AddEntityField T.Text T.Text FieldType

             | AddRecord T.Text [Field]
             | RemoveRecords Selector
               deriving Show
