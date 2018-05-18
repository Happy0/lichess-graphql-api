{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Lichess.GraphQL.Model.Tournament (Tournaments, Tournament) where

  import Data.Text
  import GraphQL.API (Field, List, Object, Union, Argument, (:>))
  import Data.Int

  type Tournaments = Object "Tournaments" '[] '[ Argument "limit" Int32 :> Field "current" (List Tournament)]

  type Tournament = Object "Tournament" '[] '[Field "id" Text ]
