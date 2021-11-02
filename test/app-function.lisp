; (ql:quickload :http-string)

(defun app-helper (the-list)
    (let (  (return-hair-number 200)
            (return-face-list   '("server: cl-async"))
            (return-body-string (format nil "[~A]" (getf the-list :http-method-string))))
        (list   :http-hair-code return-hair-number
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))

(defun app-test (the-list)
    (let (  (return-hair-number 200)
            (return-face-list   (list "Content-Type: text/html"
                                      (format nil "X-node: ~A" http-string::the-server-address) 
                                      "X-power: common-lisp"
                                      (format nil "X-local-time: ~A" (local-time:now))))
            (return-body-string (format nil 
"<!DOCTYPE html><html><head><title>app-test-page</title></head>
<body><h1>app-test</h1><p>var-a: ~A</p><tr><p>host: ~S</p></body></html>"
                    (http-string::get-field (getf the-list :http-var-list) "a")
                    (http-string::get-field (getf the-list :http-field-list) "Host:"))))
        (list   :http-hair-code return-hair-number
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))

(http-string::add-app "/test" #'app-test)
(http-string::add-app "/help" #'app-helper)

;http://[::1]:5000/test?a=1&aa=2

(defun app-test (the-list)
    (let (  (input-method-string (getf the-list :http-method-string))
            (input-path-string (getf the-list :http-path-string))
            (input-var-list (getf the-list :http-var-list))
            (input-field-list (getf the-list :http-field-list))
            (input-body-string (getf the-list :http-body-string)))
        (let (  (user-var-a (http-string::get-field input-var-list "a"))
                (user-host (http-string::get-field input-field-list "Host:")))
            (let ( (return-face-list (list  "Content-Type: text/html"
                                            (format nil "X-node: ~A" http-string::the-server-address) 
                                            "X-power: common-lisp with libuv"
                                            (format nil "X-local-time: ~A" (local-time:now))))
                    (return-body-string (format nil 
"<!DOCTYPE html><html><head><title>app-test-page</title></head>
<body><h1>app-test</h1><p>var-a: ~A</p><tr><p>host: ~S</p></body></html>" user-var-a user-host)))
        (list   :http-hair-code 200
                :http-face-list return-face-list
                :http-body-utf8 return-body-string)))))

(http-string::add-app "/test" #'app-test)

(http-string::run-main)
