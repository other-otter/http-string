(in-package :http-string)

(defparameter *http-string::the-server-address* "::1")
(defparameter *http-string::the-server-port* 5000)

(defun string-server ()
    (as:tcp-server the-server-address the-server-port
        (lambda (the-socket the-data) 
            (format t "(~A) [->] ~a~%" (local-time:now) the-socket) (finish-output)
            (let ((the-string (make-output-string (ignore-errors (user-function-map (read-input-string (babel:octets-to-string the-data)))))))
                (as:write-socket-data the-socket the-string
                    :write-cb (lambda (the-socket)
                        (format t "(~A) [<-] ~a~%" (local-time:now) the-socket) 
                        (finish-output)))))
        :connect-cb
        (lambda (connection)
            (format t "(~A) [--] ~a~%" (local-time:now) connection) 
            (finish-output))
        :event-cb 
        (lambda (error) 
            (format t "(~A) [__] ~a~%" (local-time:now) error) 
            (finish-output)))
    (as:signal-handler 2 (lambda (sig)
                         (declare (ignore sig))
                         (as:exit-event-loop))))

(defun main ()
    (as:start-event-loop #'string-server))

(defun run-main ()
    (bordeaux-threads:make-thread (lambda ()
        (as:start-event-loop #'string-server))))
