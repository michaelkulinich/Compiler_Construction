{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_CPPTypeChecker (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/bin"
libdir     = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/lib/x86_64-linux-ghc-8.6.4/CPPTypeChecker-0.1.0.0-8lfUuoIxnXUEVSoeee2QnT"
dynlibdir  = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/lib/x86_64-linux-ghc-8.6.4"
datadir    = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/share/x86_64-linux-ghc-8.6.4/CPPTypeChecker-0.1.0.0"
libexecdir = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/libexec/x86_64-linux-ghc-8.6.4/CPPTypeChecker-0.1.0.0"
sysconfdir = "/root/home/Typechecker/.stack-work/install/x86_64-linux-tinfo6/4074e6032e2ea93e96f87c21fc108f22b2482e841a7e588c1bb2b59d2b1338ac/8.6.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "CPPTypeChecker_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "CPPTypeChecker_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "CPPTypeChecker_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "CPPTypeChecker_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "CPPTypeChecker_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "CPPTypeChecker_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
