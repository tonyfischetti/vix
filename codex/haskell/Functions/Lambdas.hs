-- functions, lambdas, anonymous functions, destructuring

add1 = (\x -> x+1)
add1 1  -- 2

addAPair = (\(x, y) -> x+y)
addAPair (2, 1) -- 3
map addAPair $ zip [0..3] [3,2..0]  -- [3, 3, 3, 3]

(\x y -> x+y) 1 2   -- 3

(\z (xcoord, ycoord) -> (z + xcoord, z + ycoord)) 1 (0,0)
-- (1,1)

