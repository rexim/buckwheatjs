module Buckwheat ( emptyDatabase
                 , applyCommand
                 , loadDatabaseFromFile
                 , saveDatabaseToFile
                 , selectRecords
                 , Command(AddEntity)
                 ) where

import qualified Data.Text as T

import Entity
import Record
import Snapshot

data Selector = EntityIs T.Text deriving Show

data Command = AddEntity T.Text
             | AddEntityField T.Text T.Text FieldType

             | RenameEntity T.Text T.Text
             | RenameEntityField T.Text T.Text T.Text

             | RemoveEntity T.Text
             | RemoveEntityField T.Text

             | AddRecord T.Text [Field]
             | RemoveRecords Selector
               deriving Show

data Database = Database { databaseLog :: [Command]
                         , databaseSnapshot :: Snapshot
                         } deriving Show


emptyDatabase :: Database
emptyDatabase = Database { databaseLog = []
                         , databaseSnapshot = emptySnapshot
                         }

performCommand :: Database -> Command -> (Snapshot -> Either T.Text Snapshot) -> Either T.Text Database
performCommand database command transformSnapshot =
    do nextSnapshot <- transformSnapshot snapshot
       return $ database { databaseLog = command:log
                         , databaseSnapshot = nextSnapshot
                         }
    where snapshot = databaseSnapshot database
          log = databaseLog database

-- TODO(5f2e0285-6ebc-4687-94f4-288222cb57ac): implement all the commands
applyCommand :: Database -> Command -> Either T.Text Database
applyCommand database command@(AddEntity name) = performCommand database command (addEntity name)
applyCommand database _ = Left $ T.pack "Unimplemented command applied"

-- TODO(13b72fe4-dec4-48b8-ac4c-34d978450ae1): implement loadDatabaseFromFile
loadDatabaseFromFile :: FilePath -> IO Database
loadDatabaseFromFile = undefined

-- TODO(bb6f89fa-37a3-403c-82ff-32dd39985423): implement saveDatabaseToFile
saveDatabaseToFile :: FilePath -> Database -> IO ()
saveDatabaseToFile = undefined

-- TODO(5390068b-51f5-4c56-9d97-a8ae1be62721): implement selectRecords
selectRecords :: Database -> Selector -> [Record]
selectRecords = undefined
