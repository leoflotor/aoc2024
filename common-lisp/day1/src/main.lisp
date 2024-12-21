(defpackage aoc2024-day1
  (:use :cl))
(in-package :aoc2024-day1)

(defvar *files* (asdf:system-relative-pathname :aoc2024-day1 "./../../inputs/day1/")) ; paths relative to the project's directory
(defvar *dummy* (merge-pathnames *files* "dummy.txt"))
(defvar *input* (merge-pathnames *files* "input.txt"))

(defun read-lines (stream &optional (lines '()))
  (let ((current-line (read-line stream nil)))
    (if current-line
        (read-lines stream (cons current-line lines))
        (reverse lines))))

(defun read-file (file)
  (with-open-file (stream file)
    (read-lines stream)))

(defun is-empty-str? (str) 
  (zerop (length str)))

(defun parse-line (line)
  (mapcar #'parse-integer
          (remove-if #'is-empty-str?
                     (uiop:split-string line))))

(defun parse-lines (lines)
  (mapcar #'parse-line lines))

(defun transpose (list-of-lists)
  (apply #'mapcar #'list list-of-lists))

(defun extract-columns (lst)
  (transpose lst))

(defun sort-lists (list-of-lists)
  (mapcar #'(lambda (x) (sort x #'<)) list-of-lists))

;; Part 1

(defun part-1 (input-path)
  (sum-of-distances (sort-lists (transpose (parse-lines (read-file input-path))))))

(defun distances-by-pairs (list-of-lists)
  (reduce #'(lambda (l1 l2)
              (mapcar #'(lambda (e1 e2) (abs (- e1 e2)))
                      l1 l2))
          list-of-lists))

(defun sum-of-distances (list-of-lists)
  (reduce #'+ (distances-by-pairs list-of-lists) :initial-value 0))

;; Part 2

(defun part-2 (input-path)
  (let* ((lsts (transpose (parse-lines (read-file input-path))))
         (lst1 (car lsts))
         (lst2 (cadr lsts)))
    (similarity-score (count-occurrences lst1 lst2))))

(defun count-occurrences (lst1 lst2 &optional (alst '()))
  ;; Counts the occurrences of elements in lst1 on lst2
  (if lst1
      (let* ((head (car lst1))
             (tail (cdr lst1))
             (pair (assoc head alst)))
        (if (null pair)
            (count-occurrences tail lst2 (acons head (count head lst2) alst))
            (progn
              (rplacd (assoc head alst) (+ (cdr pair) (count head lst2)))
              (count-occurrences tail lst2 alst))))
      alst))

(defun similarity-score (alst)
  (reduce #'(lambda (i x) (+ i (* (car x) (cdr x)))) alst :initial-value 0))
