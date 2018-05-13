;;; bulk-rename-test
;; Tests for bulk-rename

(in-package :cl-user)
(defpackage :bulk-rename-test
  (:use :cl
        :bulk-rename
        :fiveam))
(in-package :bulk-rename-test)

(defun add-2 (x)
  (+ 2 x))

;; (format t "testing ~D" (add-2 10))

(def-suite bulk-rename/test
    :description "The main suite for bulk-rename")
(in-suite bulk-rename/test)

(test insert-chars
  ;;normal usage
  (is (string= "123foo456" (insert-chars "123456" "foo" 3)))
  ;;should reject negative position
  (is (string= "123456" (insert-chars "123456" "foo" -1)))
  )

(test insert-datetime
  )

(test overwrite-chars
  (let ((start-str "1234")
        (over-str "foo"))
    (is (string= "foo4" (overwrite-chars start-str over-str 0)))
    (is (string= "123foo" (overwrite-chars start-str over-str 3)))))

(test numbering
  )

(test remove-chars
  )

(test replace-plain
  )

(test replace-regexp
  )

(test change-case
  )
