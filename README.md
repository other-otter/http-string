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

;http://127.0.0.1:8080/
```
```common-lisp
(defun app-index (the-list)
    (let (  (return-hair-number 200)
            (return-face-list   (list "server: cl-async" "Content-type: text/plain")
            (return-body-string (format nil "~S" the-list)))
        (list   :http-hair-code return-hair-number
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))

(http-string::add-app "/" #'app-index)

#|
(defun page-funtion (input-list)
  (list :http-hair-code 200
        :http-face-list '()
        :http-body-utf8 " "))

(http-string::add-app "/the-page" #'page-function)

|#
```

## process

```text
#|
lisp = list-process

input-list-->your-function-->output-list

what in input-list
  :http-method-string 
      type: string
      example: "GET" "POST"
  :http-path-string
      type: string
      example: "/abc/def"
  :http-var-list
      type: list
      example: '(("a" "1") ("aa" "2"))
  :http-field-list
      type: list
      example: '(("Token:" "123") ("X-note:" "the-note"))
  :http-body-string
      type: string
      example: "[1,2,3]"
  
what in output-list
  :http-hair-code
      type: number 
      example: 200 301 404 
  :http-face-list
      type: list 
      example: '("X-lib: libuv" "X-sys: ubuntu" "X-timezone: UTC+8")
  :http-body-utf8
      type: string 
      example: "say hi in http protocol"
  
|#
```

## start

```common-lisp
(http-string::run-main)
;http-string::main is start in main thread
;http-string::run-main is start in other thread
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

[install-lisp](https://other-otter.app/2021/11/install-the-development-environment-of-lisp/)
[install-package](https://other-otter.app/2021/11/load-and-use-lisp-package/)
[cl-async-example](http://orthecreedence.github.io/cl-async/examples)
[string-handle](https://github.com/spratt/cl-websocket/blob/master/cl-websocket.lisp)
