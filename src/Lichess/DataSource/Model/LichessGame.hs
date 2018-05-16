module Lichess.DataSource.Model.LichessGame (LichessGame(LichessGame)) where

  import Data.Text

  data LichessGame = LichessGame { id :: Text, rated :: Bool } deriving Show
