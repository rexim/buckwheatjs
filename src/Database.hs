module Database ( emptyDatabase
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

-- TODO(212b6432-4e00-4667-85c7-fc4e064698a3): Buckwheat prefix for all modules
--
-- I kinda plan this to be a library as well. And I think it's a good
-- idea for a library to have such unique prefix for submodules.

data Database = Database { databaseLog :: [Command]
                         , databaseSnapshot :: Snapshot
                         } deriving Show

instance CommandProcessor Database where
    applyCommand database command =
        do nextSnapshot <- applyCommand snapshot command
           return $ database { databaseLog = command:log
                             , databaseSnapshot = nextSnapshot
                             }
        where snapshot = databaseSnapshot database
              log = databaseLog database

emptyDatabase :: Database
emptyDatabase = Database { databaseLog = []
                         , databaseSnapshot = emptySnapshot
                         }

-- TODO(13b72fe4-dec4-48b8-ac4c-34d978450ae1): implement loadDatabaseFromFile
loadDatabaseFromFile :: FilePath -> IO Database
loadDatabaseFromFile = undefined

-- TODO(bb6f89fa-37a3-403c-82ff-32dd39985423): implement saveDatabaseToFile
saveDatabaseToFile :: FilePath -> Database -> IO ()
saveDatabaseToFile = undefined

-- TODO(5390068b-51f5-4c56-9d97-a8ae1be62721): implement selectRecords
selectRecords :: Database -> Selector -> [Record]
selectRecords = undefined
