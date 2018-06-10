{-# LANGUAGE OverloadedStrings, GADTs, DeriveDataTypeable, StandaloneDeriving, RecordWildCards, TypeFamilies, FlexibleInstances, MultiParamTypeClasses #-}

module Lichess.DataSource.LichessReq (LichessReq(GetUser, GetUserGames, GetCurrentTournaments), initGlobalState) where

  import Lichess.DataSource.Model.LichessUser (LichessUser)
  import Lichess.DataSource.Model.LichessGame (LichessGame)
  import Lichess.DataSource.Model.LichessTournament (LichessTournament)
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
      GetCurrentTournaments :: LichessReq [LichessTournament]
      deriving Typeable

  deriving instance Eq (LichessReq a)
  deriving instance Show (LichessReq a)

  instance ShowP LichessReq where showp = show

  instance Hashable (LichessReq a) where
    hashWithSalt s (GetUser userId) = hashWithSalt s (0::Int,userId)
    hashWithSalt s (GetUserGames userId start end after) = hashWithSalt s (1::Int,userId)
    hashWithSalt s (GetCurrentTournaments) = hashWithSalt s (2::Int)

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

  initGlobalState :: UserAccessToken -> IO (State LichessReq)

  initGlobalState token = do
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
    -> PerformFetch LichessReq

  lichessFetch ( LichessState token httpManager ) _flags _user = BackgroundFetch $ \bfs -> do
    putStrLn (show (Prelude.length bfs))
    mapM_ showRequest bfs
    undefined

    where
      showRequest :: BlockedFetch LichessReq -> IO ()
      showRequest (BlockedFetch req res) = putStrLn (show req)
