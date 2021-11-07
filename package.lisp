(in-package :cl-user)

(defpackage #:http-string
    (:use :cl :cl-user)
    (:documentation "https://github.com/other-otter/http-string/blob/main/README.md")
    (:export split-string
             read-input-string
             function-map
             get-field
             add-app
             rem-app
             user-function-map
             err-map
             print-http-field
             make-http-string
             add-err
             make-output-string
             *server-address*
             *erver-port*
             main
             run-main))
