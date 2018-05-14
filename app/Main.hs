{-# LANGUAGE DataKinds #-}
module Main where

import Lichess.GraphQL.Lib
import GraphQL
import Data.Aeson
import Data.Text as T

main :: IO ()
main =
  do
   testResult <- interpretAnonymousQuery @Query queryHandler "query { user (id: \"happy0\") { id } }"
   putStrLn $ show $ encode testResult
