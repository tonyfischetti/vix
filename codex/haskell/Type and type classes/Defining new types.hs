-- types, defining new types, algebraic data types, data, type, newtype, deriving, type classes, sum types, product types, data constructors, value constructors, show, read, ord, absolute value, abs, records, fields, case of

-- An _algebraic data type_, hereafter ADT, is type formed by
-- combining other types.
-- Two common classes are
--   - sum types (aka enum, variant, or union types)
--   - product types (aka tuples, records, etc...)

-- The following "sum type" has a number of values that it can
-- hold that is the sum of the variants
data Bool = True | False        -- (types must start with a capital letter)

-- This "product type" can take on 4 values (the product of the
-- number of values each "field" can take
data PairOfBools = PairOfBools Bool Bool

-- The definition of Bool, above, is a special case of a sum type
-- called an enum type. This is because True and False (which
-- are data constructors!) don't take any arguments. We'll see
-- examples of ones that take arguments later

-- Some nomenclature, before we continue...

--   [1]    [2]    [2]
data Bool = True | False

--   [1]           [2]        [3]  [3]
data PairOfBools = PairOfBools Bool Bool

-- [1] Type constructor (must be capitalized) [or "type name"]
-- [2] Data constructor (must be capitalized) [or "value constructor"]
-- [3] Wrapped types

data Suit = Club | Diamond | Heart | Spade
data CardValue = Two | Three | Four
    | Five | Six | Seven | Eight | Nine | Ten 
    | Jack | Queen | King | Ace
data Card = Card CardValue Suit

-- Suit can take on 4 values
-- CardValue can take on 13
-- Card (the product type) can take on 52 (13*4)

-- None of these types can be printed (or read, or compared, etc...)
-- but, if the internal types can be, we can fix this by making
-- our new types "derive" from some type classes!

data Point = Point Int Int deriving (Show)

l1Distance :: Point -> Point -> Int
l1Distance (Point x1 y1) (Point x2 y2) = (abs $ x1-x2) + (abs $ y1-y2)

a = Point 0 0
b = Point 2 1
l1Distance a b      -- 3

-- how about allowing for 3D points, too

data Point = Point2D Int Int | Point3D Int Int Int deriving (Show)

a = Point2D 0 0
b = Point2D 2 1
c = Point3D 0 0 0
d = Point3D 1 2 1

l1Distance :: Point -> Point -> Int
l1Distance (Point2D x1 y1) (Point2D x2 y2) = (abs $ x1-x2) + (abs $ y1-y2)
l1Distance (Point3D x1 y1 z1 ) (Point3D x2 y2 z2) = (abs $ x1-x2) + (abs $ y1-y2) + (abs $ z1-z2)


l1Distance a b  -- 3
l1Distance c d  -- 4
l1Distance a d  -- Error! (non-exhaustive patterns in fn l1Distance


---------------------------
----        TYPE PARAMETERS
-- (polymorphic data types)

-- What is we want to be able to use any numeric type as
-- each part of a point...

data Point a = Point a a deriving (Show)

(Point 0 0)                     -- :: Num a => Point a
(Point 1.1 0)                   -- :: Num a => Point a
(Point 0 0) :: Point Int        -- :: Point Int
(Point 1.1 0) :: Point Double   -- :: Num a => Point a

-- In this instance, `Point` is more like a function
-- that returns a concrete type

-- Instead of putting type constraints in the type definition,
-- there's a "strong convention" not to since the functions
-- that operate on them will have to have them, anyway

l1Distance :: (Num a) => Point a -> Point a -> Int
l1Distance (Point x1 y1) (Point x2 y2) = (abs $ x1-x2) + (abs $ y1-y2)

l1Distance (Point 0.0 0.0) (Point 1 2)  -- 3.0


-- Maybe, another polymorphic data type, can be defined like so...
data Maybe a = Nothing | Just a  


----------------
----     RECORDS

-- In all the examples above, we have to remember the order of the
-- type arguments. Not so with records

data Point = Point {
    x :: Int,
    y :: Int
} deriving (Show, Eq)

Point {x=0, y=0}
Point 0 0       -- Point {x=0, y=0}

Point {x=0, y=0} == Point 0 0       -- True

a = Point {x=0, y=0}

-- Records automatically add "getter" functions
x a

-- You have the option of only updating one field
b = a {y=1}
b               -- Point {x = 0, y = 1}


--   ────────────────────────────────────────────────────────
-- Let's use all of this to demonstrate how to import/export
-- data types

--------------
-- Point.hs --
--------------
module Point (
    Point(..),          -- (..) exports all data constructors of Point
    Direction(..),      -- same as Direction(L, R, U, D)
    move
) where

data Point = Point {
  x :: Int,
  y :: Int
} deriving (Show, Eq)

data Direction = L | R | U | D

move :: Direction -> Point -> Point
move L point = point { x = (x point)-1 }
move R point = point { x = (x point)+1 }
move D point = point { y = (y point)-1 }
move U point = point { y = (y point)+1 }
-------------------------------------------

-------------
-- Main.hs --
-------------
import Point

a = Point 0 0

main :: IO ()
main = do
    putStrLn $ show $ move U $ move U $ move R a
-- Point {x = 1, y = 2}
-------------------------------------------


--------------------------
-- "Smart" constructors --
--------------------------

-- If we, for some reason, had the restriction that all coordinates
-- should be positive, we can hide the Point constructor and
-- export, instead, a "smart" constructor that will give a
-- runtime error if there's an attempt to use a negative coordinate

-- (in Point.hs)
module Point (
    -- Point(..), GETTING RID OF THIS
    posPoint,       -- adding this
    Direction(..),
    move
) where
...
posPoint :: Int -> Int -> Point
posPoint x y
    | x < 0     = error "no negative coords allowed"
    | y < 0     = error "no negative coords allowed"
    | otherwise = Point x y


-- We could have also defined `move` using `case of` and 
-- pattern matching...
move :: Direction -> Point -> Point
move direction (Point x y) = case direction of
    L -> Point (x-1) y
    R -> Point (x+1) y
    D -> Point x (y-1)
    U -> Point x (y+1)






-- TYPE SYNONYMS

