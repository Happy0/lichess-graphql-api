{-# LANGUAGE DataKinds #-}
module Lichess.GraphQL.Lib
    ( queryHandler,
      Query
    ) where

  import Data.Text
  import GraphQL.Resolver (Handler, (:<>)(..))
  import Lichess.GraphQL.Api (Query, User, GameConnection)
  import GraphQL.API (Argument, (:>), Field, List, Object, Union)

  import Data.Int

  gameConnectionHandler :: Int32 -> Int32 -> Text -> Handler IO (List GameConnection)
  gameConnectionHandler first _ after = pure undefined

  userHandler :: Text -> Handler IO User
  userHandler userId = pure ( pure userId :<> gameConnectionHandler )

  queryHandler :: Handler IO Query
  queryHandler = pure userHandler
