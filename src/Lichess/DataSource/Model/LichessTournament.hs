module Lichess.DataSource.Model.LichessTournament (LichessTournament(LichessTournament)) where

  import Data.Text

  data LichessTournament = LichessTournament { id :: Text } deriving Show
