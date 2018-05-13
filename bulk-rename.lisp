;;; Bulk rename
;; rename a bunch of files!

(defpackage :bulk-rename
  (:use :cl)
  (:export :insert-chars
           :remove-chars
           :overwrite-chars))

(in-package :bulk-rename)

(defun my-command-line ()
  "Reads command line args."
  (or 
   #+CLISP *args*
   #+SBCL *posix-argv*  
   #+LISPWORKS system:*line-arguments-list*
   #+CMU extensions:*command-line-words*
   nil))

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

(defun insert-chars (base-string new-string position)
  (concatenate 'string
               (subseq base-string 0 position)
               new-string
               (subseq base-string position (length base-string))))

(defun overwrite-chars (base-string new-string position)
  ;; if position + length of new string is greater than length of base string
  (if (< (length base-string) (+ position (length new-string)))
      ;; over the end
      (concatenate 'string
                   (subseq base-string 0 position)
                   new-string)
      ;; in the middle
      (concatenate 'string
                   (subseq base-string 0 position)
                   new-string
                   (subseq base-string
                           (+ position (length new-string))))))

(defun remove-chars (base-string from-position to-position)
  (concatenate 'string
               (subseq base-string 0 from-position)
               (subseq base-string to-position (length base-string))))
