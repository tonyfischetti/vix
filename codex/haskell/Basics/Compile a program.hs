-- basics, ghc, compile, flush stdout, getLine, hFlush, putStr, do

-----------------------------------------------
-- SINGLE FILE (scroll down for multi-file)

-- Main.hs

import System.IO

makeGreeting name = "Hi " ++ name

main = do
    putStr "Enter your name: "
    hFlush stdout
    name <- getLine
    putStrLn $ makeGreeting name


-- $ ghc --make Main -o Main
-- # same as
-- $ ghc Main.hs
-- $ ghc Main

-- # or you can run it without compilation...
-- $ ghc --run Main

-- # with optimization
-- $ ghc -O Main

-- # with warnings
-- $ ghc -O -Wall Main.hs -odir build/ -hidir build -o dist/Main

-- # with dist and build directories
-- $ ghc -O -Wall Main.hs -odir build/ -hidir build/ -o dist/Main

-----------------------------------------------
-- MULTI FILE

-- Main.hs
import Utils

main :: IO ()
main = do
    putStrLn $ show $ fact 5

-- Utils.hs
module Utils (fact) where

fact :: Integer -> Integer
fact 0 = 1
fact x = x * (fact $ x-1)

-- $ ghc -O -Wall Main.hs -odir build/ -hidir build/ -o dist/Main

