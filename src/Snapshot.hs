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

findEntity :: T.Text -> Snapshot -> Maybe Entity
findEntity name snapshot = find ((==name) . entityName) entities
    where entities = snapshotEntities snapshot

addEntity :: T.Text -> Snapshot -> Either T.Text Snapshot
addEntity name snapshot =
    case findEntity name snapshot of
      Just _ -> Left $ T.concat [ T.pack "Entity '"
                                , name
                                , T.pack "' already exists"
                                ]
      Nothing -> Right $ snapshot { snapshotEntities = entity name : entities }
    where entities = snapshotEntities snapshot
