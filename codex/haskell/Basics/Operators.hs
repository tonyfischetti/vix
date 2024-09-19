-- operators, $, ., composisiton, precedence, <>, mappend, >>=, monadic bind

import Data.Maybe

ex = [0..9]

-- . (function composition)
cadr = head . tail
cadr ex             -- 1

-- $ (function application)
-- (used to avoid parentheses because it has low precedence)
head $ tail ex      -- 1
-- same as
(head (tail ex))    -- 1

-- <> (mappend)
[1, 2, 3] <> [1, 2, 3]          -- [1, 2, 3, 1, 2, 3]
-- same as
mappend [1, 2, 3] [1, 2, 3]

--------------------------------------
-- >>= (monadic bind)

-- will let you take a monad and apply a function
-- to the "wrapped" value

[1, 2, 3] >>= (\x -> [x, x^2])
-- [1, 1, 2, 4, 3, 9]

-- note that maybeNumber _has_ to return a Maybe

maybeNumber = Just 3 >>= (\x -> Just (x+1))
-- λ> :t maybeNumber
-- maybeNumber :: Num b => Maybe b

-- this will error if it's "Nothing"
fromJust maybeNumber        -- 4
-- fromJust Nothing         -- ERROR

-- this will use second argument if it's "Nothing"
fromMaybe 0 maybeNumber     -- 4
fromMaybe 0 Nothing         -- 0

--------------------------------------
