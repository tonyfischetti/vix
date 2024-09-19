-- basics, modules, import, qualified

import Data.List                -- imports the whole thing (unqualified)
import Data.List (nub, sort)    -- only imports `nub` and `sort`

-- import everything _but_ `nub` and `sort`
import Data.List hiding (nub, sort)     

import qualified Data.Map       -- let's you use Data.Map.nub
import qualified Data.Map as M  -- let's you use M.nub

-- in GHCi you can import like so
:m + Data.List  

-----------------------
-- Creating your own --
-----------------------
--
-- Utils.hs
module Utils (
  fact,
  triple
) where

fact :: Int -> Int
fact 0 = 1
fact x = x * (fact $ x-1)

triple :: Int -> Int
triple = (*3)
------------------------------------

------------------------------------
-- Main.hs
import Utils

main :: IO ()
main = do
    putStrLn $ show $ fact 5
    putStrLn $ show $ triple 3
------------------------------------

-- You can also do
import qualified Utils as U
-- and
main :: IO ()
main = do
    putStrLn $ show $ U.fact 5
    putStrLn $ show $ U.triple 3

-- You can also separate them into
-- Utils/Fact.hs and Utils/Triple.hs
-- and `import Utils.Fact` and `import Utils.Triple`
--
-- One of them can even import the other using
-- `import Utils.<theother>`

-- Using -v on the compile line will tell you what
-- paths are searche because it has low precedence)
