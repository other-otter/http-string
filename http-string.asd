(asdf:defsystem :http-string
     :description "http api with cl-async"
     :version "0.0.1"
     :author "@other-otter"
     :depends-on (:babel
                  :bordeaux-threads
                  :cl-async
                  :local-time
                  :log4cl)
     :components ((:file "package")
                  (:module code
                   :serial t
                   :components((:file "read-input-string")
                               (:file "user-function-map")
                               (:file "make-output-string")
                               (:file "http-string-server")))))
                               
;pathname
