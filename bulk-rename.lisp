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
  (:export :insert-chars
           :remove-chars
           :overwrite-chars
           :change-case
           :start
           :get-string-after-match))

(in-package :bulk-rename)

;; (defun my-command-line ()
;;   "Reads command line args."
;;   (or 
;;    #+CLISP *args*
;;    #+SBCL *posix-argv*  
;;    #+LISPWORKS system:*line-arguments-list*
;;    #+CMU extensions:*command-line-words*
;;    nil))

(defun print-help ()
  (format t "Help:
Insertion:
bulk-rename FILES insert STRING at POSITION

Overwrite:
bulk-rename FILES overwrite STRING at POSITION

Numbering:
bulk-rename FILES numbering from START separator STRING

Removal:
bulk-rename FILES remove from START to END

Replace:
bulk-rename FILES replace STRING with STRING

Regexp:
bulk-rename FILES regex STRING replace STRING

Change Case:
bulk-rename FILES case (UPPER|UP|LOWER|DOWN|CAMEL|SNAKE|LISP|KEBAB)
"))

;; (defun parse-mode-args (&rest keywords)
  ;; "Return a function that parses arg lists.

;; The function returned will return a list of whatever appears after its keywords.
;; So something like (string) => (lambda (string) (object)

;; The function will make some assumptions about types. Keywords like 'from' or 'at'
;; will be parsed to integers, the rest will be left as strings."
  ;; #'(lambda (args)
      ;; (let ((

(defun get-string-after-match (item source-sequence)
  (let ((item-pos (position-if #'(lambda (x) (string= x item))
                               source-sequence)))
    (when item-pos
      (let* ((target-pos (+ 1 item-pos))
             (space-in-seq (< target-pos (length source-sequence))))
        (when space-in-seq
          (elt source-sequence target-pos))))))

(defun parse-keywords (args &rest keywords)
  (mapcar keywords #'(lambda (kw) (get-string-after-match kw args))))

;; (defun insert-chars-parser (args)
;;   (let ((insert-pos (position-if #'(lambda (x) (string= x "insert"))
;;                                  args))
;;         (at-pos (position-if #'(lambda (x) (string= x "at"))
;;                              args)))
;;     (if (or (= NIL insert-pos)
;;             (= NIL at-pos))
;;         "return some error"
;;         ;;else
;;         (list (insert-arg (elt args (+ 1 insert-pos)))
;;               (at-arg (elt args (+ 1 at-pos)))))))

(defun parse-mode (mode-arg)
  "Returns the function to use for the given mode"
  (case mode-arg
    ("insert" 'insert-chars-parser)
    ("overwrite" 'overwrite-chars-parser)
    ("numbering" 'numbering-parser)
    ("remove" 'remove-chars-parser)
    ("replace" 'replace-plain-parser)
    ("regex" 'replace-regexp-parser)
    ("case" 'change-case-parser)))

(defun start () (main (uiop:command-line-arguments)))

(defun main (argv)
  ;; (format t "Starting up!")
  ;; (write argv))
  (write (insert-chars (elt argv 0) (elt argv 1) (parse-integer (elt argv 2)))))
  ;; (let ((action (parse-mode (elt argv 0))))
    ;; (action (cddr argv))))
