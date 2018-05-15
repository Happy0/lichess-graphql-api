module Lichess.DataSource.Model.LichessGame (LichessGame) where

  import Data.Text

  data LichessGame = LichessGame { id :: Text, rated :: Bool }
