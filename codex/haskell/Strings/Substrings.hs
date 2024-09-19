-- strings, substring, take, drop

substr str start end = drop start $ take end str

substr "Hello" 1 4  -- "ell"
