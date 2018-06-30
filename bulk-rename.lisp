;;; Bulk rename
;; rename a bunch of files!

;;; Commentary:

;; operations:
;; insert
;; insert datetime
;; overwrite
;; numbering
;; remove characters
;; search and replace (regex or plaintext)
;; upcase/downcase

;; functions to use
;; rename-file http://www.lispworks.com/documentation/HyperSpec/Body/f_rn_fil.htm#rename-file
;; that'll probably do most of the heavy lifting

;; http://www.lispworks.com/documentation/HyperSpec/Body/f_namest.htm
;; file-namestring will get the name part without directory

;; http://www.lispworks.com/documentation/HyperSpec/Body/f_stg_up.htm
;; lots of good string functions, could even add capitalize in there

;; http://www.lispworks.com/documentation/HyperSpec/Body/f_stg_tr.htm
;; there's a trim from start and trim from end

;; for the rest, since strings can work like arrays,
;; I think most of the rest will have to be array functions

(defpackage :bulk-rename
  (:use :cl)
  (:export :start
           :insert-chars
           :remove-chars
           :overwrite-chars
           :change-case
           :get-string-after-match
           :parse-keywords))

(in-package :bulk-rename)

(defun print-help ()
  (format t "Help:
Insertion:
bulk-rename insert STRING at POSITION FILES

Overwrite:
bulk-rename overwrite STRING at POSITION FILES

Numbering:
bulk-rename numbering from START separator STRING FILES

Removal:
bulk-rename remove from START to END FILES

Replace:
bulk-rename replace STRING with STRING FILES

Regexp:
bulk-rename regex STRING replace STRING FILES

Change Case:
bulk-rename case (UPPER|UP|LOWER|DOWN|CAMEL|SNAKE|LISP|KEBAB) FILES
"))

;;; Functions that are associated with unpacking the command line args

(defun get-string-after-match (item source-sequence)
  "Get the string after a match in a list of strings. NIL if no match or no next string after match."
  (let ((item-pos (position-if #'(lambda (x) (string= x item))
                               source-sequence)))
    (when (and item-pos
               (< (+ item-pos 1) (length source-sequence)))
      (elt source-sequence (+ 1 item-pos)))))

(defun parse-keywords (args &rest keywords)
  "Grabs data out of the args list."
  (mapcar #'(lambda (kw) (get-string-after-match kw args)) keywords))

(defun get-names (args number-of-keyword-args)
  (subseq args (* number-of-keyword-args 2)))

(defun do-insert-chars (args)
  (let ((real-args (parse-keywords args "insert" "at"))
        (names (get-names args 2)))
    (mapcar (lambda (name)
              (insert-chars name (elt real-args 0) (parse-integer (elt real-args 1))))
            names)))

(defun do-remove-chars (args)
  (let* ((real-args (parse-keywords args "from" "to"))
         (names (get-names args (length real-args))))
    (mapcar (lambda (name)
              (apply #'remove-chars '(name . real-args)))
            names)))

(defun do-rename (args rename-function keywords)
  (let* ((real-args (apply #'parse-keywords '(args . keywords)))
         (names (get-names args (length keywords))))
    (mapcar (lambda (name)
              (apply rename-function '(name . real-args)))
            names)))

;; (defun do-rename (args)
;;     "ARGS is a list of strings."
;;   (let* ((names (get-names args))
;;          (operation (get-operation args))
;;          (op-args (get-operation-args operation args)))
;;     (mapcar (lambda (name)
;;               (apply operation op-args name)))))

(defun start () (main (uiop:command-line-arguments)))

(defun main (argv)
  (write (do-insert-chars argv)))

