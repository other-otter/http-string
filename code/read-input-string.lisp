(in-package :http-string)

;https://github.com/spratt/cl-websocket/blob/b27f36fbeda7e71e2f304630861740f0320ba83e/cl-websocket.lisp#L40
(defun split-string (string &key (delimiter (string #\space)) (max -1))
    (let ((pos (search delimiter string)))
        (if (or (= max 0) (eq nil pos))
            (list string)
            (cons
                (subseq string 0 pos)
                (split-string (subseq string (+ pos (length delimiter)))
                    :delimiter delimiter
                    :max (if (= max -1) -1 (- max 1)))))))

(defun read-input-string (the-string)
	(if (stringp the-string) 
		(let* (	(http-list (split-string the-string :delimiter #(#\return #\newline #\return #\newline) :max 1))
				(http-head (car  http-list))
				(http-body (cadr http-list))
				(head-list (split-string http-head :delimiter #(#\return #\newline) :max 20))
				(http-hair (car head-list))
				(http-face (cdr head-list))
				(face-list (loop for string in http-face collect (split-string string :max 1)))
				(hair-list (split-string http-hair :delimiter #(#\space) :max 3))
				(http-meth (car hair-list))
				(http-url  (cadr hair-list))
				(url-list  (split-string http-url :delimiter #(#\?) :max 1))
				(url-path  (car  url-list))
				(url-vars  (cadr url-list))
				(var-list  (split-string url-vars :delimiter #(#\&) :max 20))
				(the-vars  (remove-if (lambda (var) (equal var "")) var-list)) 
				(url-args  (loop for string in the-vars collect (split-string string :delimiter #(#\=) :max 1))))
			(list 	:http-method-string http-meth 
				:http-path-string   url-path
				:http-var-list      url-args
				:http-field-list    face-list
				:http-body-string   http-body))
		501))
