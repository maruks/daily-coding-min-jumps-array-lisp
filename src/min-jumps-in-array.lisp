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
  (if (>= index (1- (length vec)))
       result
      (let ((new-max-reach (max max-reach (+ index (svref vec index)))))
	(if (zerop steps)
	    (let ((next-steps (- new-max-reach index)))
	      (when (plusp next-steps)
		(find-min-jumps vec (1+ index) (1- next-steps) new-max-reach (1+ result))))
	    (find-min-jumps vec (1+ index) (1- steps) new-max-reach result)))))

(defun min-jumps-2 (vec)
  (when (and (plusp (length vec)) (plusp (svref vec 0)))
    (find-min-jumps vec 1 (1- (svref vec 0)) (svref vec 0) 1)))

(defun min-jumps-3 (vec)
  (when (and (plusp (length vec)) (plusp (svref vec 0)))
    (iter
      (with steps = (1- (svref vec 0)))
      (with max-reach = (svref vec 0))
      (with result = 1)
      (for index :from 1 to (- (length vec) 2))
      (setf max-reach (max max-reach (+ index (svref vec index))))
      (when (zerop steps)
	  (let ((next-steps (- max-reach index)))
	    (always (plusp next-steps))
	    (setf steps next-steps)
	    (incf result)))
      (decf steps)
      (finally (return result)))))
