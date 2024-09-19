-- basics, booleans, boolean operators


True && False	    -- False  
True && True        -- True  
False || True       -- True  
not False           -- True  
not (True && True)  -- False

and $ map (==3) [1, 2, 3]   -- False
or  $ map (==3) [1, 2, 3]   -- True
