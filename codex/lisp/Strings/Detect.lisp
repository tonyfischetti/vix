; lisp, strings, cl-ppcre, regex, match, detect, case-insensitive regex, str-detect

(ql:quickload :cl-ppcre)

(defvar /str/ "Hello")

(if (cl-ppcre:scan "Hel{2}" /str/) t nil)  ; T

; or

(str-detect /str/ "Hel{2}")
(str-detect /str/ "(?i)hel{2}") ; case insensitive
