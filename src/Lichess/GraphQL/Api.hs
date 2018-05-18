{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Lichess.GraphQL.Api (Query, User, Game, GameConnection, GameEdge, Tournaments, Tournament) where

  import Data.Text
  import GraphQL.API (Argument, (:>), Field, List, Object, Union)
  import Lichess.GraphQL.Model.Game (GameConnection, Game, GameEdge)
  import Lichess.GraphQL.Model.User (User)
  import Lichess.GraphQL.Model.Tournament (Tournaments, Tournament)
  import Data.Int

  type Query = Object "query" '[] '[Argument "id" Text :> Field "user" User, Field "tournaments" Tournaments]
