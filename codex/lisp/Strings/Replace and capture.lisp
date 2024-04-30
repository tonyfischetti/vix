(ql:quickload :cl-ppcre)
(defvar /str/ "Hello")
(cl-ppcre:regex-replace "^(.{4}).+" /str/ "\1")  ; Hell
; or
(str-replace /str/ "(.{4}).+$" "\1")

(cl-ppcre:regex-replace "l" /str/ "L")      ; HeLlo
(cl-ppcre:regex-replace-all "l" /str/ "L")  ; HeLLo
; or
(str-replace /str/ "l" "L")
(str-replace-all /str/ "l" "L")
(str-replace-all /str/ "(?i)L" "*")   ; He**o