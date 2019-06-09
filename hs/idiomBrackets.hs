{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{-# LANGUAGE UndecidableInstances   #-}

import           Control.Applicative
import           Control.Monad

class Applicative i => Idiomatic i f g | g -> f i where
  idiomatic :: i f ->g

iI :: Idiomatic i f g => f -> g
iI = idiomatic . pure

data Ii = Ii

instance Applicative i => Idiomatic i x (Ii -> i x) where
  idiomatic xi Ii = xi

instance Idiomatic i f g => Idiomatic i (s -> f) (i s -> g) where
  idiomatic sfi si = idiomatic (sfi <*> si)

m :: Maybe String
m = iI (++) (Just "Hello,") (Just " world!") Ii

main :: IO ()
main = do
  print m
