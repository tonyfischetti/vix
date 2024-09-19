-- types, sets, set union, set intersection, set difference, Set.fromList, Set.toList, Set.null, Set.insert, Set.delete, Set.map, Set.filter

import qualified Data.Set as Set

ex = concat $ replicate 3 [1, 2, 3]      -- [1,2,3,1,2,3,1,2,3]

Set.fromList ex         -- fromList [1, 2, 3]

ex = [8, 8, 6, 7, 5, 3, 0, 9]
setex = Set.fromList ex         -- Set.toList is inverse operation

Set.difference (Set.fromList [0..9]) (Set.fromList ex)
-- [1, 2, 3]

Set.union (Set.fromList [0..9]) (Set.fromList ex)
-- [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

Set.intersection (Set.fromList [0..9]) (Set.fromList ex)
-- [0, 3, 5, 6, 7, 8, 9]

Set.null $ Set.fromList []  -- True

Set.size setex              -- 7
Set.size $ Set.singleton 0  -- 1

Set.insert 0 setex      -- unchanged
Set.insert 1 setex      -- adds 1

Set.delete 9 setex      -- [0, 3, 5, 6, 7, 8]
Set.delete 1 setex      -- unchanged

Set.map (+1) setex
Set.filter (< 5) setex     -- [0, 3]

