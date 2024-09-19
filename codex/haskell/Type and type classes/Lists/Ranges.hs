-- arrays, lists, types, ranges, iota, ..

[1..10]     -- [1,2,3,4,5,6,7,8,9,10]

-- can be infinite
take 3 [1..]    -- [1, 2, 3]

-- NO
[5..1]      -- []
-- YES
[5,4..1]    -- [5, 4, 3, 2, 1]

[1,3..10]   -- [1, 3, 5, 7, 9]

['a'..'z']  -- "abcdefghijklmnopqrstuvwxyz"


