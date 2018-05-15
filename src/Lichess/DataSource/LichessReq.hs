{-# LANGUAGE OverloadedStrings, GADTs, DeriveDataTypeable, StandaloneDeriving, RecordWildCards, TypeFamilies, FlexibleInstances, MultiParamTypeClasses #-}

module Lichess.DataSource.LichessReq (LichessReq, initGlobalState) where

  import Lichess.DataSource.Model.LichessUser (LichessUser)
  import Lichess.DataSource.Model.LichessGame (LichessGame)
  import Data.Text
  import Data.Typeable
  import Network.HTTP.Client.TLS (tlsManagerSettings)
  import Network.HTTP.Conduit (newManager, Manager)
  import Haxl.Core
  import Data.Hashable

  type UserId = Text
  type UserAccessToken = Text

  type Start = Int
  type End = Int
  type After = Text

  data LichessReq a where
      GetUser :: UserId -> LichessReq LichessUser
      GetUserGames :: UserId -> Start -> End -> After -> LichessReq [LichessGame]
      deriving Typeable

  deriving instance Eq (LichessReq a)
  deriving instance Show (LichessReq a)

  instance ShowP LichessReq where showp = show

  instance Hashable (LichessReq a) where
    hashWithSalt s (GetUser userId) = hashWithSalt s (0::Int,userId)
    hashWithSalt s (GetUserGames userId start end after) = hashWithSalt s (1::Int,userId)

  instance StateKey LichessReq where
    data State LichessReq =
      LichessState
         { userAccessToken :: UserAccessToken
         , manager :: Manager
  }

  instance DataSourceName LichessReq where
    dataSourceName _ = "Lichess"

  instance DataSource u LichessReq where
    fetch = lichessFetch

  initGlobalState
    :: Int
    -> UserAccessToken
    -> IO (State LichessReq)

  initGlobalState threads token = do
    manager <- newManager tlsManagerSettings
    return LichessState
      {
        manager = manager
      , userAccessToken = token
      }

  lichessFetch
    :: State LichessReq
    -> Flags
    -> u
    -> [BlockedFetch LichessReq]
    -> PerformFetch

  lichessFetch ( LichessState token httpManager ) _flags _user bfs = undefined
