import Control.Monad.Reader
    ( ReaderT
    , ask
    , liftIO
    , runReaderT
    )

import Control.Exception
    ( finally
    , try
    , ErrorCall
    )

-- | Signature of ReaderT:
-- class Monad m => ReaderT r m | m -> r

finallyReaderT
    :: ReaderT r IO a
    -> ReaderT r IO b
    -> ReaderT r IO a
finallyReaderT a sequel = do
    r <- ask
    liftIO $ runReaderT a r `finally` runReaderT sequel r

main :: IO ()
main = do
    res <- try $ runReaderT
        (oops `finallyReaderT` okay)
        42
    -- ErrorCall contains the error and location message
    print (res :: Either ErrorCall ())
    where
        oops = do
            r <- ask
            liftIO $ putStrLn $ "Acquring resource: " ++ show r
            error "Oops it drops"
        okay = do
            r <- ask
            liftIO $ putStrLn $ "Releasing resource: " ++ show r
