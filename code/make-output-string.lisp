(in-package :http-string)

(setf err-map (make-hash-table))

(defun print-http-field (the-list)
    (if the-list
        (with-output-to-string (*standard-output*)
            (mapcar (lambda (the-field) 
                (format t "~A~c~c" the-field #\return #\newline)) the-list))
        (format nil "X-Power-by: common-lisp~c~c" #\return #\newline)))

(defun make-http-string (&key   (http-hair-code 500) 
                                (http-face-list nil) 
                                (http-body-utf8 "something-wrong"))
    (format nil 
"HTTP/1.1 ~A~c~cContent-length: ~A~c~c~A~c~c~A" 
http-hair-code                      #\return #\newline 
(length http-body-utf8)             #\return #\newline 
(print-http-field http-face-list)   #\return #\newline 
http-body-utf8))

(defun add-err (the-number the-string)
    (setf (gethash the-number err-map) 
        (make-http-string   :http-hair-code the-number 
                            :http-body-utf8 the-string)))

(add-err 404 "page-not-found")
(add-err 501 "input-or-output-error")
(add-err 555 "unknow-user-error")

(defun make-output-string (the-list)
    (let ((http-status-number (getf the-list :http-hair-code)))
        (if http-status-number
            (if (<= 100 http-status-number 300)
                (apply #'make-http-string the-list)
                (let ((error-string (gethash http-status-number err-map)))
                    (if error-string
                        error-string
                        (gethash 555 err-map))))
            (gethash 501 err-map))))
