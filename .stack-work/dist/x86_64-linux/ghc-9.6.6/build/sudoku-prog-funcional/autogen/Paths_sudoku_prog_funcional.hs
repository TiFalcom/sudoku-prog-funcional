{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_sudoku_prog_funcional (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
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

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/bin"
libdir     = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/lib/x86_64-linux-ghc-9.6.6/sudoku-prog-funcional-0.1.0.0-4LbtrTgl6dqEfBtnroJYVG-sudoku-prog-funcional"
dynlibdir  = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/lib/x86_64-linux-ghc-9.6.6"
datadir    = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/share/x86_64-linux-ghc-9.6.6/sudoku-prog-funcional-0.1.0.0"
libexecdir = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/libexec/x86_64-linux-ghc-9.6.6/sudoku-prog-funcional-0.1.0.0"
sysconfdir = "/home/diego/sudoku-prog-funcional/.stack-work/install/x86_64-linux/73c32d515a0cfcaf006fff2722c85648a07938667969e8f25f12d0f3fcdde9ce/9.6.6/etc"

getBinDir     = catchIO (getEnv "sudoku_prog_funcional_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "sudoku_prog_funcional_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "sudoku_prog_funcional_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "sudoku_prog_funcional_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "sudoku_prog_funcional_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "sudoku_prog_funcional_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
