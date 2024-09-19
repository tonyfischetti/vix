-- basics, data types, integer, float, double, tuple, character, string

-- Int is bounded whereas Integer is unbounded
-- Float:  single precision
-- Double: double precision

-- :t 'a'  
'a' :: Char  

-- :t True  
True :: Bool  

-- :t "HELLO!"  
"HELLO!" :: [Char]  

-- :t (True, 'a')  
(True, 'a') :: (Bool, Char)     -- tuple

-- :t 4 == 5  
4 == 5 :: Bool  

-- :t head
head :: [a] -> a

-- :t fst
fst :: (a, b) -> a  

-- :t (==)  
(==) :: (Eq a) => a -> a -> Bool  
