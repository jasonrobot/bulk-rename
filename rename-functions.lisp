(in-package :bulk-rename)

(defun insert-chars (base-string new-string position)
  (if (< position 0)
      base-string
      (concatenate 'string
                   (subseq base-string 0 position)
                   new-string
                   (subseq base-string position (length base-string)))))

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

(defun numbering (strings start separator)
  (mapcar strings
          (lambda (s)
            (insert-chars s
                          (concatenate 'string
                                       "69"
                                       separator)
                          0))))

(defun remove-chars (base-string from-position to-position)
  "Remove characters from the filename."
  (if (< from-position 0)
      (setq from-position 0))
  (if (> to-position (length base-string))
      (setq to-position (length base-string)))
  (concatenate 'string
               (subseq base-string 0 from-position)
               (subseq base-string to-position (length base-string))))

(defun replace-plain (base-string find-string replace-string)
  "Replace text in a string by basic matching."
  base-string)

(defun replace-regexp (base-string regexp-string replace-string)
  "Replace text in a string by regexp."
  base-string)

(defun change-case (base-string method)
  "Change the case of a string.

METHOD can be one of: up/upper down/lower camel snake kebab lisp"
  (cond
    ;;to-upper
    ((or (string= method "up")
         (string= method "upper"))
     (string-upcase base-string))
    ;;to lower
    ((or (string= method "down")
         (string= method "lower"))
     (string-downcase base-string))))
