-- arrays, lists, array destructuring, list destructuring

let (car:cadr:cddr) = [1..5] in [car, cadr]
-- [1, 2]

ex = [(0, 0), (1, 1), (2, 2)]

-- nested destructuring
let ((xcoord, ycoord):xs) = ex in [xcoord, ycoord]
-- [0, 0]

let ((x1, y1):(x2, y2):xs) = ex in [x2, y2]
-- [1, 1]

length' :: [a] -> Int
length' []      = 0
length' (_:xs)  = (+1) $ length' xs

length' [1..5]  -- 5
