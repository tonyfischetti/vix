-- arrays, lists, types, combine two arrays, mappend, ++, <>, cons, concat

ex = [1, 2, 3, 4]

-- cons
0:ex    -- [0, 1, 2, 3, 4]

-- concatenate
ex ++ ex    -- [1, 2, 3, 4, 1, 2, 3, 4]

-- `concat` must take a list
concat [ex, ex]

-- mappend (smashes two monoidal values together)
ex <> ex        -- [1, 2, 3, 4, 1, 2, 3, 4]
mappend ex ex   -- "
