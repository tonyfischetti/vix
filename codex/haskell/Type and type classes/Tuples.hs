-- types, tuples, zip, pairs, unzip, zipWith, apply list of functions to list of values pairwise, $

-- Unlike lists, tuples can be heterogenous
(1, "hi") :: Num a => (a, String)
(1::Int, "hi") :: (Int, String)

("Tony", "Fischetti", 34)

fst ("Tony", "Fischetti")   -- Tony
snd ("Tony", "Fischetti")   -- Fischetti

zip ["Tony", "Fischetti"] ["Andromahi", "Kontos"]
-- [("Tony","Andromahi"),("Fischetti","Kontos")]

zip ['a'..'c'] [1..3]
-- [('a',1),('b',2),('c',3)]

unzip $ zip ['a'..'c'] [1..3]
-- ("abc",[1,2,3])

zipWith (+) [1,2,3] [3,2,1]
-- [4,4,4]

-- You can pairwise apply a list functions to a list of
-- values using the `$` function application operator
zipWith ($) [(+1), (+2), (+3)] [3, 2, 1]
-- [4,4,4]


