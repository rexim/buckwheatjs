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

-- TODO(968c6262-aec5-4bf1-8bf8-957efcb74c90): rename module Buckwheat -> Database

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
