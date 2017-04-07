module Snapshot ( Snapshot
                , Selector
                , emptySnapshot
                , addEntity
                , addEntityField
                , addRecord
                , removeRecords
                ) where

import Data.List
import qualified Data.Text as T

import Entity
import Record

data Selector = EntityIs T.Text deriving Show

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

-- TODO(b81cdba4-e866-45f4-98f5-3730dbb62f48): implement Snapshot.addEntityField
addEntityField :: T.Text -> T.Text -> FieldType -> Snapshot -> Either T.Text Snapshot
addEntityField = undefined

-- TODO(f1cbc01a-a494-4a89-a2a0-b38237ebd98a): implement Snapshot.addRecord
addRecord :: T.Text -> [Field] -> Snapshot -> Either T.Text Snapshot
addRecord = undefined

-- TODO(1e7ff184-6fdf-4eaa-8dc0-44d693102b3a): implement Snapshot.removeRecords
removeRecords :: Selector -> Snapshot -> Either T.Text Snapshot
removeRecords = undefined
