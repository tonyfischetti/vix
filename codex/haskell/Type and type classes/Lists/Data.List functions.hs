-- arrays, lists, types, Data.List, intercalate, take, concatMap, splitAt, takeWhile, dropWhile, span, group, sort, words, unwords, reverse, inits, tails, nub, partition, find, findIndex, findIndices, elemIndex, elemIndices, \\, set difference, union, intersect, as patterns, @, association lists, lookup

import qualified Data.List

intercalate "\t" ["white", "blanco", "ασπρος", "hvítur"]
-- white   blanco  άσπρος  hvítur

take 10 $ iterate (*2) 1
-- [1,2,4,8,16,32,64,128,256,512]
-- (iterate returns an infinite list)

concatMap (\x -> [x, x^2]) [1..3]

splitAt 2 [1..5]
-- ([1,2],[3,4,5])

takeWhile (/=' ') "This is a sentence"
-- "This"

dropWhile (/=' ') "This is a sentence"
-- " is a sentence"

span (/=' ') "This is a sentence"
-- ("This"," is a sentence")
-- `break` is the opposite

group . sort $ [1, 7, 1, 8, 7, 7, 3]
-- [[1, 1], [3], [7, 7, 7], [8]]

ex = "Somebody gotta be all that Somebody don't even known that Somebody gotta come right here Somebody else gotta go back Somebody gotta be scheming Somebody gotta be a witness Somebody gotta be seeing in the meaning is different"

words ex
-- ["Somebody","gotta","be","all",...]

(unwords . words $ ex) == ex    -- True

sort $ words ex
-- ["Somebody","Somebody","Somebody",...]

group . sort . words $ ex
-- ["Somebody","Somebody","Somebody",...]

reverse $ sort $ map (\l@(x:xs) -> (length l, x)) . group . sort . words $ ex
-- [(7,"Somebody"),
--  (6,"gotta"),
--  (4,"be"),
--  (2,"that"),
--  (1,"witness"),
--  (1,"the"), etc...]

inits [1..5]
-- [[],[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

tails [1..5]
-- [[1,2,3,4,5],[2,3,4,5],[3,4,5],[4,5],[5],[]]

length . tails $ [1..5]
-- 6

ex = [8, 6, 7, 5, 3, 0, 9]
ex2 = concat $ replicate 2 ex   -- [8,6,7,5,3,0,9,8,6,7,5,3,0,9]

-- deduplicate
nub ex2     -- [8,6,7,5,3,0,9]

partition (>5) ex
-- ([8,6,7,9],[5,3,0])

find (==5) ex       -- Just 5
find (==4) ex       -- Nothing

findIndex (==5) ex2     -- Just 3 (the index)
findIndex (==4) ex2     -- Nothing

findIndices (==5) ex2   -- [3, 10]
findIndices (==4) ex2   -- []

elemIndex 5 ex       -- Just 3 (the index)
elemIndex 4 ex       -- Nothing

elemIndices ' ' "somebody gotta be..."
-- [8, 14]

-- "set" difference (includes duplicates)
[8, 8, 6, 7, 5, 3, 0, 9] \\ [3, 0, 9]
-- [8,8,6,7,5]

[8, 8, 6, 7, 5, 3, 0, 9] \\ [3, 0, 9, 8]
-- [8,6,7,5]

[0..9] \\ [8, 6, 7, 5, 3, 0, 9]
-- [1, 2, 4]

[8, 6, 7, 5, 3, 0, 9] \\ [0..9]
-- []

union [8, 6, 7, 5, 3, 0, 9] [0..9]
-- [8,6,7,5,3,0,9,1,2,4]

intersect [8, 6, 7, 5, 3, 0, 9] [0..9]
-- [8,6,7,5,3,0,9]

colors = [
  ("green", ["viridian", "hookers", "sap"]),
  ("blue",  ["cerulean", "phthalo", "cobalt", "process"]),
  ("red",   ["cadmium"]),
  ("red",   ["vermilion"])]

-- Data.List's `lookup` function
lookup "red" colors     -- Just ["cadmium"]
