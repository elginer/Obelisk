module Paths_Obelisk (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import Data.Version (Version(..))
import System.Environment (getEnv)

version :: Version
version = Version {versionBranch = [0,0,1], versionTags = []}

bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/spoon/.cabal/bin"
libdir     = "/home/spoon/.cabal/lib/Obelisk-0.0.1/ghc-6.10.4"
datadir    = "/home/spoon/.cabal/share/Obelisk-0.0.1"
libexecdir = "/home/spoon/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catch (getEnv "Obelisk_bindir") (\_ -> return bindir)
getLibDir = catch (getEnv "Obelisk_libdir") (\_ -> return libdir)
getDataDir = catch (getEnv "Obelisk_datadir") (\_ -> return datadir)
getLibexecDir = catch (getEnv "Obelisk_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
