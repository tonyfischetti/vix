; lisp, strings, padding strings, format

(defvar /str/ "Hello")
(format nil "~7A" /str/)        ; "Hello  "
(format nil "~7@A" /str/)       ; "  Hello"
(format nil "~11:@<~A~>" /str/) ; "   Hello   "
