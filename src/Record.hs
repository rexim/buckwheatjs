module Record ( Record
              , Field
              , FieldValue
              ) where

import qualified Data.Text as T
import Entity


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
