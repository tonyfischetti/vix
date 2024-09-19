-- arrays, lists, types, array predicates, null, elem, element in array, any, all, some, every

ex = [1, 2, 3, 4]

null ex             -- False
null []             -- True

2 `elem` ex         -- True
elem 2 ex           -- True
(flip elem) ex 2    -- True


any (==2) ex        -- True
all (==2) ex        -- False

-- same as
or  $ map (==2) ex  -- True
and $ map (==2) ex  -- False
