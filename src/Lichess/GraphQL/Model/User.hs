{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Lichess.GraphQL.Model.User (User) where

  import Data.Text
  import GraphQL.API (Argument, (:>), Field, List, Object, Union)
  import Lichess.GraphQL.Model.Game (GameConnection)

  -- Todo: there are more fields, obviously :P
  type User = Object "User" '[]
              '[ Field "id" Text,
                 Argument "first" Int :> Argument "last" Int :> Argument "after" Text :> Field "games" [GameConnection]
               ]
