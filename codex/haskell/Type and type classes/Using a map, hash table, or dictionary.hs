-- types, maps, hash table, dictionary, create a map, create a hash table, create a dictionary, association lists, Map.lookup, Map.toList, Map.fromListWith, Map.insert, Map.singleton, Map.size, null, Map.member, Map.map, Map.filter, Map.keys, Map.elems

import qualified Data.Map as Map  

colors = [
  ("green", ["viridian", "hookers", "sap"]),
  ("blue",  ["cerulean", "phthalo", "cobalt", "process"]),
  ("red",   ["cadmium"]),
  ("red",   ["vermilion"])]

-- Data.List's `lookup` function
lookup "red" colors     -- Just ["cadmium"]

map = Map.fromList colors       -- removes the first red :(
Map.toList map                  -- inverse operation

map = Map.fromListWith (++) colors
-- doens't remove the first red
-- since it takes a function that will operate on
-- duplicate keys

Map.empty           -- empty map

Map.insert "blue"  ["cerulean", "phthalo", "cobalt", "process"] $
  Map.insert "green" ["viridian", "hookers", "sap"] $ Map.empty
-- fromList [("blue",["cerulean","phthalo","cobalt","process"]),("green",["viridian","hookers","sap"])]
-- (same as)
Map.insert "blue"  ["cerulean", "phthalo", "cobalt", "process"] $
  Map.singleton "green" ["viridian", "hookers", "sap"]

null Map.empty      -- True

Map.size map    -- 3 (number of keys)

Map.member "red" map    -- True
Map.member "grey" map   -- False

Map.lookup "red" map    -- Just ["vermillion", "cadmium"]
Map.lookup "grey" map   -- Nothing

Map.map length map
-- fromList [("blue",4),("green",3),("red",2)]

Map.filter (\x -> length x == 2) map    -- fromList [("red",["vermilion","cadmium"])]
Map.filter ((==2) . length) map         -- ""

Map.keys map    -- ["blue","green","red"]
Map.elems map   -- [["cerulean","phthalo","cobalt","process"],["viridian","hookers","sap"],["vermilion","cadmium"]]

zip (Map.keys map) (Map.elems map)  -- the starting association list
