module Lichess.DataSource.Model.LichessUser (LichessUser(LichessUser)) where

  import Data.Text

  data LichessUser = LichessUser { id :: Text, online :: Bool } deriving Show
