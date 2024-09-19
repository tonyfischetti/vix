-- functions, higher order functions, filter, remove-if, remove-if-not

filter (>3) [1..5]      -- [4, 5]
-- equivalent to (remove-if-not (lambda (x) (> x 3)) '(1 2 3 4 5))

