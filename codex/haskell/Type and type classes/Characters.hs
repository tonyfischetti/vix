-- types, characters, unicode, latin1, digitToInt, intToDigit, ord, chr, toUpper, toLower

import Data.Char

isControl 'a'   -- False
isControl '\t'  -- True

isSpace 'a'     -- False
isSpace ' '     -- True
isSpace '\t'    -- True

isLower 'x'

isUpper 'X'

isAlpha '1'     -- False
isAlpha 'x'     -- True

isAlphaNum

isPrint '\n'    -- False (non-printable character)

isDigit '1'
isOctDigit '1'
isHexDigit 'f'

isLetter 'a'

nfd = "άνθρωποι" -- NFD
nfc = "άνθρωποι" -- NFC
or $ map isMark nfd     -- True
or $ map isMark nfc     -- False
Data.List.findIndex isMark nfd -- Just 1

isNumber '0'

isPunctuation ','

isSymbol 'p'    -- False
isSymbol '$'    -- True
isSymbol '∅'    -- True
isSymbol 'φ'    -- False (!!!???)

-- isSeparator (checks for Unicode spaces and separators)

isAscii 'a'     -- True
isAscii 'ά'     -- False

isLatin1 
isLatin1 'a'    -- True
isLatin1 'ø'    -- True
isLatin1 'á'    -- True
isLatin1 'ά'    -- False

map (\x -> (x, generalCategory x)) ['a', 'á', 'ά', '\t', ' ', 'ø', '∅', 'φ', '$']
-- [('a',LowercaseLetter),
--  ('\225',LowercaseLetter),
--  ('\940',LowercaseLetter),
--  ('\t',Control),
--  (' ',Space),
--  ('\248',LowercaseLetter),
--  ('\8709',MathSymbol),
--  ('\966',LowercaseLetter),
--  ('$',CurrencySymbol)]

map toUpper "shout"     -- SHOUT
map toLower "QUIET"     -- quiet

digitToInt '1'               -- 1
map digitToInt "8675309"     -- [8,6,7,5,3,0,9]
map digitToInt "01af"        -- [0, 1, 10, 15]
-- map digitToInt "867-5309" EXCEPTION

digitToInt 'f'  -- 15
intToDigit 15   -- f

map ord " !\"#$%"   -- [32..37]
ord '\0'            -- 0
ord '\t'            -- 9

map ord ['ø', 'á', 'α', 'β', 'ά', 'Я']   -- [248,225,945,946,940,1071]

ord '🗿'    -- 128511
ord '🝤'     -- 128868

map chr [128508..128515]    -- "🗼🗽🗾🗿😀😁😂😃"

