module Lichess.DataSource.Model.LichessUser (LichessUser) where

  import Data.Text

  data LichessUser = LichessUser { id :: Text, online :: Bool }
