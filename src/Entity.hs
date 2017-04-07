module Entity ( Entity
              , EntityField
              , FieldType
              , entity
              , entityName
              ) where

import qualified Data.Text as T

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

entity :: T.Text -> Entity
entity name = Entity { entityName = name
                     , entityFields = []
                     }
