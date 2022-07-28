{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE ScopedTypeVariables #-}
module ForeignLib () where

import Prelude hiding (init)
import Control.Monad
import Data.IORef
import Foreign.C
import Foreign.Ptr
import Foreign.StablePtr

import Lib (someFunc)

foreign export ccall "example_hs_init" init :: IO (Ptr ())

init :: IO (Ptr ())
init = do
  ref <- newIORef (0 :: Integer)
  sptr <- newStablePtr ref
  return (castStablePtrToPtr sptr)

foreign export ccall "example_hs_release" release :: Ptr () -> IO ()

release :: Ptr () -> IO ()
release ptr = do
  let sptr :: StablePtr (IORef Integer)
      sptr = castPtrToStablePtr ptr
  freeStablePtr sptr

foreign export ccall "example_count" count :: Ptr () -> CInt -> IO CInt

count :: Ptr () -> CInt -> IO CInt
count ptr n = do
  let sptr :: StablePtr (IORef Integer)
      sptr = castPtrToStablePtr ptr
  ref <- deRefStablePtr sptr
  modifyIORef' ref (\x -> someFunc x (fromIntegral n))
  liftM fromIntegral $ readIORef ref
