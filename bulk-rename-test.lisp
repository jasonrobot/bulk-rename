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
  (let ((start-str "123456")
        (insert-str "foo"))
    ;;normal usage
    (is (string= "123foo456" (insert-chars start-str insert-str 3)))
    ;;should reject negative position
    (is (string= "123456" (insert-chars start-str insert-str -1)))
    ))

(test insert-datetime
  )

(test overwrite-chars
  (let ((start-str "1234")
        (over-str "foo"))
    (is (string= "foo4" (overwrite-chars start-str over-str 0)))
    (is (string= "123foo" (overwrite-chars start-str over-str 3)))))

(test numbering
  (let ((start-str '("foo" "bar" "baz")))
    ;;test that the first chars of each of the results is correct
    (is (= 1 1))))

(test remove-chars
  (let ((start-str "123456"))
    ;; should remove the right number of chars
    (is (string= "1256" (remove-chars start-str 2 4)))
    ;;should clamp from-pos to the beginning of the string
    (is (string= "12345" (remove-chars start-str 5 10)))
    ;;should clamp to-pos to the length of the string
    (is (string= "23456" (remove-chars start-str -10 1)))))
    

(test replace-plain
  )

(test replace-regexp
  )

(test change-case
  (let ((upper-string "QWE")
        (lower-string "qwe"))
    (is (string= lower-string (change-case upper-string "lower")))
    (is (string= upper-string (change-case lower-string "upper"))))
  (is (string= "123" (change-case "123" "up")))
  ;; camel
  
  ;;FIXME iterate over test cases
  ;; (let ((test-cases '(("FooBar" "FooBar")
  ;;                     ("fooBar" "fooBar")
  ;;                     ("foo_bar" "fooBar")
  ;;                     ("foo-bar" "fooBar"))))
  ;;   (mapcar test-cases
  ;;           (lambda (tc)
  ;;             (let ((in-str (car tc))
  ;;                   (expected (
  ;;             (is (string= expected (change-case input-str "camel"))))
  
  ;; (is (string= "FooBar" (change-case "FooBar" "camel")))
  ;; (is (string= "fooBar" (change-case "fooBar" "camel")))
  ;;snake
  )


;;; testing stuff from main
(test get-string-after-match
  (is (string= "baz" (get-string-after-match "bar" '("foo" "bar" "baz")))))
