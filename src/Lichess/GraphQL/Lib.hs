{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Lichess.GraphQL.Lib
    ( queryHandler,
      Query
    ) where

  import Data.Text
  import GraphQL.Resolver (Handler, (:<>)(..))
  import Lichess.GraphQL.Api (Query, User, GameConnection, Game)
  import GraphQL.API (Argument, (:>), Field, List, Object, Union)
  import Lichess.DataSource.LichessReq
  import Lichess.DataSource.Model.LichessUser
  import Lichess.DataSource.Model.LichessGame


  import Data.Int
  import Haxl.Core
  import Control.Applicative

  gameConnectionHandler :: Text -> Int32 -> Int32 -> Text -> Handler (GenHaxl u) GameConnection
  gameConnectionHandler userId first end after =
    dataFetch (GetUserGames userId (fromIntegral first) (fromIntegral end) after) >>= toGraphModel
    where
      toGraphModel games = pure (pure (fmap toGameModel games) :<> pure [])
      toGameModel (LichessGame gameId rated) = pure (pure gameId :<> pure rated)

  userHandler :: Text -> Handler (GenHaxl u) User
  userHandler userId = dataFetch (GetUser userId) >>= toGraphModel
    where
      toGraphModel (LichessUser userId isOnline) = pure ( pure userId :<> pure isOnline :<> gameConnsForUser)
      gameConnsForUser first end after = gameConnectionHandler userId first end after

  queryHandler :: Handler (GenHaxl u) Query
  queryHandler = pure userHandler
