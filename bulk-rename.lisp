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
           :start))

(in-package :bulk-rename)

;; (defun my-command-line ()
;;   "Reads command line args."
;;   (or 
;;    #+CLISP *args*
;;    #+SBCL *posix-argv*  
;;    #+LISPWORKS system:*line-arguments-list*
;;    #+CMU extensions:*command-line-words*
;;    nil))

(defun start () (main (uiop:command-line-arguments)))

(defun main (argv)
  (format t "Starting up!")
  ;; (write argv))
  (write (insert-chars (elt argv 0) (elt argv 1) (parse-integer (elt argv 2)))))
