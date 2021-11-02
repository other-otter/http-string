(in-package :http-string)

(setf function-map (make-hash-table :test #'equal))

;https://github.com/spratt/cl-websocket/blob/b27f36fbeda7e71e2f304630861740f0320ba83e/cl-websocket.lisp#L67
(defun get-field (fields fieldname)
    (dolist (field fields)
        (when (string= fieldname (subseq (car field) 0 (length (car field))))
            (return (cadr field)))))

(defun add-app (the-path the-function)
    (when (stringp the-path)
        (setf (gethash the-path function-map) the-function)));

(defun rem-app (the-path)
    (when (stringp the-path)
        (remhash the-path function-map)))

(defun user-function-map (the-list)
    (if (listp the-list)
        (let* ( (the-path (getf the-list :http-path-string))
                (the-function (gethash the-path function-map)) )
            (if the-function
                (funcall the-function the-list)
                (list :http-hair-code 404)))
        (if (numberp the-list)
            (list :http-hair-code the-list)
            (list :http-hair-code 501))));
