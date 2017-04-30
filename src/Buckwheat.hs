module Buckwheat ( emptyDatabase
                 , loadDatabaseFromFile
                 , saveDatabaseToFile
                 , selectRecords
                 , applyCommand
                 ) where

import qualified Data.Text as T

import Entity
import Record
import Snapshot
import Command

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

-- TODO(6cde2176-acbf-4238-905c-d56c577c451f): implement Database applyCommand in terms of Snapshot's one
--
-- Requires 504793dd-de6c-444f-a28e-c825e76ba376
instance CommandProcessor Database where
    applyCommand database command@(AddEntity name) =
        performCommand database command (addEntity name)
    applyCommand database command@(AddEntityField entity field fieldType) =
        performCommand database command (addEntityField entity field fieldType)
    applyCommand database command@(AddRecord entity fields) =
        performCommand database command (addRecord entity fields)
    applyCommand database command@(RemoveRecords selector) =
        performCommand database command (removeRecords selector)

-- TODO(13b72fe4-dec4-48b8-ac4c-34d978450ae1): implement loadDatabaseFromFile
loadDatabaseFromFile :: FilePath -> IO Database
loadDatabaseFromFile = undefined

-- TODO(bb6f89fa-37a3-403c-82ff-32dd39985423): implement saveDatabaseToFile
saveDatabaseToFile :: FilePath -> Database -> IO ()
saveDatabaseToFile = undefined

-- TODO(5390068b-51f5-4c56-9d97-a8ae1be62721): implement selectRecords
selectRecords :: Database -> Selector -> [Record]
selectRecords = undefined
