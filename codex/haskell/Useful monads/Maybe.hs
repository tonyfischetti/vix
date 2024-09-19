-- haskell, monads, maybe, TODO

safeDivide :: Double -> Maybe Double
safeDivide x y = if y==0 then Nothing else Just $ x / y

safeDivide 4 2  -- Just 0
safeDivide 4 0  -- Nothing


