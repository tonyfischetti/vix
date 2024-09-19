-- arrays, lists, types, cycle, repeat, replicate, concat, concatMap

-- makes an infinite list
take 3 $ repeat 5       -- [5, 5, 5]

-- makes an infinite list of lists
take 3 $ repeat [1..3]  -- [[1,2,3],[1,2,3],[1,2,3]]

-- easier way to do the same thing
replicate 3 [1..3]      -- [[1,2,3],[1,2,3],[1,2,3]]

concat $ replicate 3 [1..3]     -- [1,2,3,1,2,3,1,2,3]

take 9 $ cycle [1..3]           -- [1,2,3,1,2,3,1,2,3]

concatMap (replicate 3) [1..3]  -- [1,1,1,2,2,2,3,3,3]
