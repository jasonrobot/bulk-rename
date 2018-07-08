;;; bulk-rename-test
;; Tests for bulk-rename

(in-package :cl-user)
(defpackage :bulk-rename-test
  (:use :cl
        :bulk-rename
        :fiveam))
(in-package :bulk-rename-test)

(defmacro do-list-destructure (list-of-lists lambda-list &rest forms)
  "Combine a dolist and a destructuring-bind."
  (let ((temp-item (gensym)))
    `(dolist (,temp-item ,list-of-lists)
       (destructuring-bind ,lambda-list ,temp-item
         ,@forms))))

(def-suite bulk-rename/main-test
    :description "Test suite for the functions that handle the CLI tool.")
(in-suite bulk-rename/main-test)

;; (test parse-mode
;;   (do-list-destructure
;;       '(())))

(def-suite bulk-rename/rename-test
    :description "Test suite for the functions that do the renaming work.")
(in-suite bulk-rename/rename-test)

(test insert-chars
  (let ((start-str "123456")
        (insert-str "foo"))
    (do-list-destructure
        '((3 "123foo456")
          (-1 "123456")
          (0 "foo123456")
          (6 "123456foo"))
      (position expected)
      (is (string= expected (insert-chars start-str insert-str position))))))

(test insert-datetime
  )

(test overwrite-chars
  (let ((start-str "1234"))
    (do-list-destructure
        '(("foo" 0 "foo4")
          ("foo" 3 "123foo")
          ("foobar" 0 "foobar")
          ("foo" 4 "1234foo"))
      (over-str position expected)
      (is (string= expected (overwrite-chars start-str over-str position))))))

(test numbering
  (let ((start-str '("foo" "bar" "baz")))
    ;;test that the first chars of each of the results is correct
    (is (= 1 1))))

(test remove-chars
  (let ((start-str "123456"))
    (do-list-destructure
        '((2 4 "1256")
          ;;should clamp to-pos to the length of the string
          (5 10 "12345")
          ;;should clamp from-pos to the beginning of the string
          (-10 1 "23456"))
      (from to expected)
      (is (string= expected (remove-chars start-str from to))))))

(test replace-plain
  )

(test replace-regexp
  )
                       
(test change-case-upper
  (do-list-destructure
      '(("foo" "FOO")
        ("FOO" "FOO"))
    (input expected)
    (is (string= expected (change-case input "up")))
    (is (string= expected (change-case input "upper")))))

;; (test change-case-camel
  ;; (let ((test-cases '(("FooBar" "FooBar")
                      ;; ("fooBar" "fooBar")
                      ;; ("foo_bar" "fooBar")
                      ;; ("foo-bar" "fooBar"))))
    ;; (dolist (test-case test-cases)
      ;; (destructuring-bind (input expected) test-case
          ;; (is (string= expected (change-case input "camel")))))))

;;; testing stuff from main
(test get-string-after-match
  ;; test-cases :: (input) argument expected-result
  (do-list-destructure
      '((("foo" "bar") "foo" "bar")
        (("foo") "foo" nil)
        (("foo" "bar") "bar" nil)
        (("foo" "bar" "baz") "bar" "baz"))
  (input arg expected)
  (if expected
      (is (string= expected (get-string-after-match arg input))
          (format nil "input: ~A ~A expected: ~A" input arg expected))
      (is (null (get-string-after-match arg input))
          (format nil "input: ~A ~A expected: ~A" input arg expected)))))

(test get-names
  (do-list-destructure
      '((("foo") "insert" '())
        ("foo" "bar")
    (names delim expected)
    (is (string= (elt (get-names names delim) 0) expected))))
