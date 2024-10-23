
import Text.Pandoc.JSON
-- import Data.Char (toUpper)
import Data.Text (toUpper)

main :: IO ()
main = toJSONFilter cap
-- main = toJSONFilter behead

-- behead :: Block -> Block
-- behead (Header n _ xs) | n >= 1 = Para [Emph xs]
-- behead x = x

cap :: Inline -> Inline
-- cap :: Data.Text.Internal.Text -> Data.Text.Internal.Text
cap (Str s) = Str $ toUpper s
-- cap (Str s) = Str s
cap x = x
