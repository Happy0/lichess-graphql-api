{-# LANGUAGE DataKinds #-}
module Main where

import Lichess.GraphQL.Lib
import GraphQL
import Data.Aeson
import Data.Text as T

import Haxl.Core
import Lichess.DataSource.LichessReq

main :: IO ()
main =
  do
   lichiggidyState <- initGlobalState ""
   env <- initEnv (stateSet lichiggidyState stateEmpty) ()
   mantis <- runHaxl env $ interpretAnonymousQuery @Query queryHandler "query { user (id: \"happy0\") { games (first: 0, last: 0, after: \"\") { nodes { id } }  }, tournaments { current(limit: 20) }     }"
   putStrLn $ show $ encode mantis
