-- arrays, lists, intercalate, join, split, let in, tuple destructuring

import Data.List

intercalate "," ["this", "and", "that"]
-- "this,and,that"

split :: Char -> String -> [String]
split delim str
    | not $ elem delim str  = [str]
    | otherwise             = let (car, cdr) = span (/=delim) str
        in car:(split delim (drop 1 cdr))

split ',' "this,and,that"
-- ["this", "and", "that"]
