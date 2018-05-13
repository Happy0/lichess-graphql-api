
{-# LANGUAGE DataKinds #-}
module Lichess.GraphQL.Model.Game (Game, GameConnection, GameEdge) where

  import Data.Text
  import GraphQL.API (Field, List, Object, Union)

  type GameEdge = Object "GameEdge" '[] '[Field "cursor" Text, Field "node" Game ]

  type GameConnection = Object "GameConnection" '[] '[Field "nodes" [Game], Field "edges" [GameEdge] ]

  -- Todo: there are more fields, obviously :P
  type Game = Object "Game" '[] '[Field "id" Text, Field "rated" Bool ]
