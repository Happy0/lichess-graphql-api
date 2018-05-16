{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Lichess.GraphQL.Model.User (User) where

  import Data.Text
  import GraphQL.API (Argument, (:>), Field, List, Object, Union)
  import Lichess.GraphQL.Model.Game (GameConnection)
  import Data.Int

  -- Todo: there are more fields, obviously :P
  type User = Object "User" '[]
              '[ Field "id" Text,
                 Field "online" Bool,
                 Argument "first" Int32 :> Argument "last" Int32 :> Argument "after" Text :> Field "games" GameConnection
               ]
