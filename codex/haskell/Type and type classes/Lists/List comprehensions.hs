-- arrays, lists, types, list comprehensions, cartesian join

[ x | x <- [1..5] ]         -- [1, 2, 3, 4, 5]

[ x*2 | x <- [1..5] ]       -- [2, 4, 6, 8, 10]

[ x/2 | x <- [1..5] ]       -- [0.5, 1.0, 1.5, 2.0, 2.5]

-- adding predicate
[ x | x <- [1..5], mod x 2 == 0 ]
-- [2, 4]

-- "and"
[ x | x <- [1..20], mod x 2 == 0, x >= 10 ]
-- [10, 12, 14, 16, 18, 20]

-- "or"
[ x | x <- [1..20], mod x 2 == 0 || x >= 10 ]
-- [2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

-- cartesian join
[ (x, y) | x <- ['a'..'c'], y <- [1..3] ]
-- [('a',1),('a',2),('a',3),('b',1),('b',2),('b',3),('c',1),('c',2),('c',3)]

-- this will "recycle" the smaller list
[ (x, y) | x <- ['a'..'z'], y <- [1..3] ]

