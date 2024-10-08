module Base.IO.read-file where

open import Base.String.Type
open import Base.IO.Type

postulate
  read-file    : String → IO String

{-# FOREIGN GHC import qualified Data.Text    as T   #-}
{-# FOREIGN GHC import qualified Data.Text.IO as TIO #-}
{-# FOREIGN GHC import qualified System.IO           #-}
{-# FOREIGN GHC import qualified Control.Exception   #-}
{-# FOREIGN GHC

  -- Reads a finite file. Raises an exception if the file path refers
  -- to a non-physical file (like "/dev/zero").
  readFiniteFile :: T.Text -> IO T.Text
  readFiniteFile f = do
    h <- System.IO.openFile (T.unpack f) System.IO.ReadMode
    Control.Exception.bracketOnError (return ()) (\_ -> System.IO.hClose h)
                                                 (\_ -> System.IO.hFileSize h)
    TIO.hGetContents h
#-}
{-# COMPILE GHC read-file   = readFiniteFile            #-}

{-# COMPILE JS read-file = function(path) { 
  return function() { 
    return new Promise(function(resolve, reject) { 
      require('fs').readFile(path, 'utf8', function(err, data) { 
        if (err) reject(err); 
        else resolve(data); 
      }); 
    }); 
  }; 
} #-}