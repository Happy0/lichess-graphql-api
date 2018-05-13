{-# LANGUAGE DataKinds #-}
module Lichess.GraphQL.Lib
    ( queryHandler,
      Query
    ) where

  import Data.Text
  import GraphQL.Resolver (Handler, (:<>)(..))
  import Lichess.GraphQL.Api (Query, User, GameConnection)

  gameConnectionHandler :: Int -> Int -> Text -> Handler IO [GameConnection]
  gameConnectionHandler first _ after = undefined

  userHandler :: Text -> Handler IO User
  userHandler userId = pure ( pure userId :<> gameConnectionHandler )

  queryHandler :: Handler IO Query
  queryHandler = pure userHandler
