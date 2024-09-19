-- functions, fold, reduce, higher order functions, delete, combining partially applied functions, reducing functions, folding functions

foldl (\acc x -> acc - x) 0 [1..5]      -- -15
-- (- (- (- (- (- 0 1) 2) 3) 4) 5)
-- folds from left

foldr (\x acc -> acc - x) 0 [1..5]      -- -15
-- folds from right

-- both of these are the same as
foldl1 (\acc x -> acc -x) [0..5]
foldr1 (\x acc -> acc - x) [5,4..0]

--  NOTE  that the order of arguments in the lambda are reversed

cons = (:)
foldl (\acc x -> cons x acc) [] [1..3]  -- [3, 2, 1]
-- (cons 3 (cons 2 (cons 1 nil)))

foldr (\x acc -> cons x acc) [] [1..3]  -- [1, 2, 3]
-- (cons 1 (cons 2 (cons 3 nil)))

-- foldr is better at construcing lists
foldr (:) [] [1..5]         -- [1, 2, 3, 4, 5]


minMaxReducer (min, max) x = (if x < min then x else min, if x > max then x else max)
foldl minMaxReducer (1/0, -(1/0)) [1..5]    -- (1, 5)


upTo10      = [1..10]
evensUpTo10 = [1,3..10]

-- ¿how do we use delete to remove all elements of evensUpTo10 from upTo10?

import Data.List (delete)

delete 1 [1..3] -- [2, 3]

fns = map delete evensUpTo10 -- List of partially applied delete fns
bigfn = foldl1 (.) fns       -- combining into one function
bigfn upTo10                 -- [2, 4, 6, 8, 10]

-- same as

bigfn = foldl1 (.) $ map delete evensUpTo10
bigfn upTo10

-- same as 

foldl (\acc x -> delete x acc) upTo10 evensUpTo10

-- same as

foldr delete upTo10 evensUpTo10

-- same as

delete' = flip delete
foldl delete' upTo10 evensUpTo10


-- scanl/scanr shows the intermediate values

minimizer x y = if x > y then y else x

scanl minimizer 100 [8, 6, 7, 5, 3, 0, 9]
-- [100,8,6,6,5,3,0,0]

scanr minimizer 100 [8, 6, 7, 5, 3, 0, 9]
-- [0,0,0,0,0,0,9,100]

scanl1 (\acc x -> acc+x) [1..5]
-- [1, 3,   6,     10,      15]
-- [1, 1+2, 1+2+3, 1+2+3+4, 1+2+3+4+5]

scanr1 (\x acc -> acc+x) [1..5]
-- [15,        14,      12,    9,   5]
-- [5+4+3+2+1, 5+4+3+2, 5+4+3, 5+4, 5]

