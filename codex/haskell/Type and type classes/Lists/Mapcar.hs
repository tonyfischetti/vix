-- arrays, lists, types, mapcar, map, fmap, flat map, concat, monadic bind, >>=


map  (+1) [1..3]    -- [2, 3, 4]
fmap (+1) [1..3]    -- [2, 3, 4]


map (*10) $ map (+1) [1..3]
-- [20, 30, 40]


map (\x -> [x, x^2]) [1..3]
[[1, 1], [2, 4], [3, 9]]

-- "flat map"
concat $ map (\x -> [x, x^2]) [1..3]
-- [1, 1, 2, 4, 3, 9]
-- same as
concatMap (\x -> [x, x^2]) [1..3]

-- "flat map" using monadic bind and a lambda
[1..3] >>= (\x -> [x, x^2])
-- [1, 1, 2, 4, 3, 9]

