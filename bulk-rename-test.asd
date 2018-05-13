;;; bulk-rename-test-system

(in-package :cl-user)
(defpackage :bulk-rename-test-system
  (:use :asdf
        :uiop))
(in-package :bulk-rename-test-system)

(defsystem "bulk-rename-test"
  :depends-on ("fiveam" "bulk-rename")
  ;; :pathname "test/"
  :components ((:file "bulk-rename-test")))
