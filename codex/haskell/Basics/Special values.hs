-- basics, null, bottom values, infinity, INCOMPLETE, undefined, halting problem

1/0     --  Infinity
-1/0    -- -Infinity

-- Haskell doesn't really have a bottom value
--
-- you can use `null` to test if an array is empty
-- but "null" is not a type (good thing)
--
-- the closest thing to "null" is Nothing (of the `Maybe` monad)
-- or (by convention) the left side of the `Either` monad

null [] -- True


-- There _is_ a data type called Data.Void that I don't completely
-- understand yet

-- Last, there _is_ technically a bottom type...
-- if there weren't, it would imply that the compiler could
-- solve the halting problem
-- This "bottom" is a member of every type

-- Prelude exports the following
undefined = error "Prelude.undefined"

-- :t undefined
undefined :: GHC.Internal.Stack.Types.HasCallStack => a

-- and you can use it to leave a  TODO  in your program
-- It'll compile, but using it will throw a runtime error


