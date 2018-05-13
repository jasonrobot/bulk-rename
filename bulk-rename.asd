;;; bulk-rename-system

(in-package :cl-user)
(defpackage :bulk-rename-system
  (:use :asdf))
(in-package :bulk-rename-system)

(defsystem "bulk-rename"
  :version "0.1.0"
  :author "Jason Howell"
  :license "LLGPL"
  :description "Rename lots of files at once."
  ;;end docs
  :depends-on ()
  :components ((:file "bulk-rename"))
  :perform (test-op (o c)
                    (uiop:symbol-call :fiveam '#:run!
                                      (uiop:find-symbol* '#:bulk-rename/test
                                                         :bulk-rename-test))))
