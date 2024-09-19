-- arrays, lists, types, mappend, ++, <>, cons, head, tail, init, last, drop, take, car, cdr

ex = [1, 2, 3, 4]

head ex     -- 1            (this will break on an empty list)
tail ex     -- [2, 3, 4]
init ex     -- [1, 2, 3]
last ex     -- 4

take 2 ex   -- [1, 2]
drop 2 ex   -- [3, 4]

Data.List.splitAt 2 ex    -- ([1, 2], [3, 4])
Data.List.splitAt 3 [1..10]

