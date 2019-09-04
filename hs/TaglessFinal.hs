{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module TaglessFinal where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.Trans

type Name = String

data User = User { name :: Name, age :: Int }

class Monad m => MonadDB m where
  getUser    :: Name -> m User
  deleteUser :: User -> m ()

test :: MonadDB m => m ()
test = do
  user <- getUser "Foo"
  when (age user < 18) (deleteUser user)

data DBConfig = DBConfig { dbName :: Name }

newtype AppM a = AppM { unAppM :: ReaderT DBConfig IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader DBConfig)

instance MonadDB AppM where
  getUser name = do
    return $ User name 10

  deleteUser _ = do
    return ()

runAppM :: AppM a -> DBConfig -> IO a
runAppM app cfg = runReaderT (unAppM app) cfg

main ::IO ()
main = runAppM test (DBConfig "db")
