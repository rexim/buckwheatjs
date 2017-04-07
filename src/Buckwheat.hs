module Buckwheat ( emptyDatabase
                 , applyCommand
                 , loadDatabaseFromFile
                 , saveDatabaseToFile
                 , selectRecords
                 ) where

import Data.List
import qualified Data.Text as T

-- TODO(b1e870ef-f947-4ac5-827d-426c80b8d67a): extract entity related
-- stuff to Entity module
--
-- This includes:
-- - Entity
-- - EntityField
-- - FieldType
-- - entity
data Entity = Entity { entityName :: T.Text
                     , entityFields :: [EntityField]
                     } deriving Show

data EntityField = EntityField { entityFieldName :: T.Text
                               , entityFieldType :: FieldType
                               } deriving Show

data FieldType = IntField
               | StringField
               | RefField T.Text
                 deriving Show

-- TODO(0083f2aa-8591-4a06-b7da-53dc82ee3b7a): extract record related
-- stuff to Record module
--
-- This includes:
-- - Record
-- - Field
-- - FieldValue
--
-- Record module will depend on Entity module.
data Record = Record { id :: T.Text
                     , recordEntityName :: T.Text
                     , recordFields :: [Field]
                     } deriving Show

data Field = Field { fieldName :: T.Text
                   , fieldValue :: FieldValue
                   } deriving Show

data FieldValue = IntFieldValue Int
                | StringFieldValue T.Text
                | RefFieldValue T.Text
                  deriving Show

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

data Snapshot = Snapshot { snapshotEntities :: [Entity]
                         , snapshotRecords :: [Record]
                         } deriving Show

entity :: T.Text -> Entity
entity name = Entity { entityName = name
                     , entityFields = []
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

data Database = Database { databaseLog :: [Command]
                         , databaseSnapshot :: Snapshot
                         } deriving Show

emptySnapshot = Snapshot { snapshotEntities = []
                         , snapshotRecords = []
                         }

emptyDatabase :: Database
emptyDatabase = Database { databaseLog = []
                         , databaseSnapshot = emptySnapshot
                         }

-- TODO(5f2e0285-6ebc-4687-94f4-288222cb57ac): implement all the commands
applyCommand :: Database -> Command -> Either T.Text Database

applyCommand database command@(AddEntity entityName) =
    do nextSnapshot <- addEntity snapshot entityName
       return $ database { databaseLog = command:log
                         , databaseSnapshot = nextSnapshot
                         }
    where snapshot = databaseSnapshot database
          log = databaseLog database

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
