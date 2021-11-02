# http-string

## description

the string is transmitted through the http protocol, 
based on the package cl-async (libuv)

## require

sbcl quicklisp libuv

## load

```bash
cd ~/quicklisp/local-projects

git clone https://github.com/other-otter/http-string.git

rlwrap sbcl
```

```common-lisp
(load "~/quicklisp/setup.lisp")

(ql:quickload :http-string)

```

## setup

```common-lisp
(setf http-string::the-server-address "127.0.0.1"
      http-string::the-server-port 8080)
      
```
```common-lisp
(defun app-index (the-list)
    (let (  (return-hair-number 200)
            (return-face-list   '("server: cl-async"))
            (return-body-string (format nil "~S" the-list)))
        (list   :http-hair-code return-hair-number
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))

(http-string::add-app "/" #'app-index)

#|
(defun page-funtion (the-list)
  (list :http-hair-code 200
        :http-face-list '()
        :http-body-utf8 " "))

(http-string::add-app "/the-page" #'page-function)

|#
```

## process

```common-lisp
#|
input-list-->your-function-->output-list

what in input-list
  :http-method-string 
  :http-path-string
  :http-var-list
  :http-field-list
  :http-body-string
  
what in output-list
  :http-hair-code
  :http-face-list
  :http-body-utf8
  
|#
```

## start

```common-lisp
(http-string::run-main)

```

## redefine 

```common-lisp
(defun app-index (the-list)
    (let (  (return-hair-number 200)
            (return-face-list   '("server: cl-async"))
            (return-body-string (format nil "~S" (getf the-list :http-var-list))))
        (list   :http-hair-code return-hair-number
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))

(http-string::add-app "/" #'app-index)

```

## functions

```common-lisp
;http-string::main
;http-string::run-main
;http-string::add-app path-string function-symbal
;http-string::rem-app path-string
;http-string::get-field field-key-val-list field-key-string
;http-string::add-err error-number error-string

```

## more

### tutorials link
