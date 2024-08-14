; lisp, strings, cl-ppcre, regex, string splitting, split, case-insensitive regex, str-split

(ql:quickload :cl-ppcre)

(defvar /str/ "Hello")
(cl-ppcre:split "l+" /str/) ; ("He" "o")

; or

(str-split /str/ "l+")
(str-split /str/ "(?i)L+")  ; case insensitive
