(defpackage :min-jumps-in-array
  (:use :cl :alexandria :iterate)
  (:export :min-jumps :min-jumps-2 :min-jumps-3))

(in-package :min-jumps-in-array)

;; --------------------------------- O(n^2) ---------------------------------

(defun best-jump (vec from)
  (iter
    (for i :from from :to (+ from (svref vec from)))
    (finding i :maximizing (+ i (svref vec i)))))

(defun find-min-jumps-0 (vec &optional (from 0) (result 0))
  (if (<= (length vec) (+ 1 from (svref vec from)))
      (1+ result)
      (let ((jmp (best-jump vec from)))
	(when (< from jmp)
	  (find-min-jumps-0 vec jmp (1+ result))))))

(defun min-jumps (vec)
  (when (and (plusp (length vec)) (plusp (svref vec 0)))
    (find-min-jumps-0 vec)))

;; --------------------------------- O(n) ---------------------------------

(defun find-min-jumps (vec index steps max-reach result)
  (if (> index (1- (length vec)))
      result
      (when (<= index max-reach)
	(let ((jump? (zerop steps)))
	  (find-min-jumps
	   vec
	   (1+ index)
	   (if jump? (- max-reach index) (1- steps))
	   (max max-reach (+ index (svref vec index)))
	   (if jump? (1+ result) result))))))

(defun min-jumps-2 (vec)
  (when (and (plusp (length vec)) (plusp (svref vec 0)))
    (find-min-jumps vec 1 (svref vec 0) (svref vec 0) 1)))

(defun min-jumps-3 (vec)
  (when (and (plusp (length vec)) (plusp (svref vec 0)))
    (iter
      (with steps = (svref vec 0))
      (with result = 1)
      (for index :from 1 :to (1- (length vec)))
      (for max-reach :initially (svref vec 0) :then (max max-reach (+ index (svref vec index))))
      (always (<= index max-reach))
      (if (zerop steps)
	  (progn
	    (setf steps (- max-reach index))
	    (incf result))
	  (decf steps))
      (finally (return result)))))
