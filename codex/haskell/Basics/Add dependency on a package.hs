-- basics, cabal, packages, hackage, dependencies, projects, project setup, ghcup, compiling, ghc, executable, library

-- Assuming ghcup is installed, the there are a few not-discouraged
-- ways to add an external package as a dependency
-- These are presented in order of how substantial the project is

------------------------------------------------------------------
-- In the most simple case (like single files, etc...) that are to
-- be interpreted without compilation, or executables build without
-- cabal, start the file like in this example
#!/usr/bin/env runhaskell

import HaskellSay
import System.IO

main :: IO ()
main = do
    putStr "haskell say what?: "
    hFlush stdout
    sayWhat <- getLine
    haskellSay sayWhat
-- In the directory, run
-- `$ cabal install --lib --package-env=. haskell-say`
-- Now it'll compile and execute


------------------------------------------------------------------
-- SINGLE FILE USING CABAL
-- A better way to do that might be to run it using cabal.
-- You can put build dependencies directly into the .hs file
#!/usr/bin/env cabal

{- cabal:
build-depends:
  base,
  haskell-say
-}

import HaskellSay
import System.IO

main :: IO ()
main = do
    putStr "haskell say what?: "
    hFlush stdout
    sayWhat <- getLine
    haskellSay sayWhat
-- chmod +x example && ./example


------------------------------------------------------------------
-- MINIMAL CABAL SETUP
--
-- This is an example of a minimal .cabal file
-- but refer to "Minimal cabal file.cabal" codex
-- nameofproject.cabal
    -- cabal-version: 3.0
    -- name: nameofproject
    -- version: 0.0.0.0
    -- executable nameofproject
    --   main-is: ENTRYPOINT.hs
    --   build-depends:
    --     base >= 4.15,
    --     haskell-say
    --   default-language: Haskell2010
--
-- Then you can use `cabal build`, `cabal run`, etc...


------------------------------------------------------------------
-- FOR SUBSTANTIAL PROJECTS
--
-- use `cabal init`

