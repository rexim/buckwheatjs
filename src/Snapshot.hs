module Snapshot ( Snapshot
                , emptySnapshot
                , findEntity
                , addEntity
                ) where

import Data.List
import qualified Data.Text as T

import Entity
import Record

data Snapshot = Snapshot { snapshotEntities :: [Entity]
                         , snapshotRecords :: [Record]
                         } deriving Show

emptySnapshot = Snapshot { snapshotEntities = []
                         , snapshotRecords = []
                         }

findEntity :: Snapshot -> T.Text -> Maybe Entity
findEntity snapshot name = find ((==name) . entityName) entities
    where entities = snapshotEntities snapshot

addEntity :: Snapshot -> T.Text -> Either T.Text Snapshot
addEntity snapshot entityName =
    case findEntity snapshot entityName of
      Just _ -> Left $ T.concat [ T.pack "Entity '"
                                , entityName
                                , T.pack "' already exists"
                                ]
      Nothing -> Right $ snapshot { snapshotEntities = entity entityName : entities }
    where entities = snapshotEntities snapshot
