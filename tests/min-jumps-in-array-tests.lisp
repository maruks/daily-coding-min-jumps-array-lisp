(defpackage :min-jumps-in-array-tests
  (:use :cl :cacau :assert-p :check-it :min-jumps-in-array))

(in-package :min-jumps-in-array-tests)

(defparameter *example-1* #(3 2 5 1 1 9 3 4 1 1 3))
(defparameter *example-2* #(10 0 0 0 0 0 0 0 0 0 1 0))
(defparameter *example-3* #(1 3 5 8 9 2 6 7 6 8 9))
(defparameter *example-4* #(3 12 32 45))
(defparameter *example-5* #(1 2 0 0 0))
(defparameter *example-6* #(0))
(defparameter *example-7* #(0 0))

(deftest "min-jumps test" ()
  (eql-p 3 (min-jumps *example-1*))
  (eql-p 2 (min-jumps *example-2*))
  (eql-p 3 (min-jumps *example-3*))
  (eql-p 1 (min-jumps *example-4*))
  (null-p (min-jumps *example-5*))
  (null-p (min-jumps *example-6*))
  (null-p (min-jumps *example-7*)))

(deftest "min-jumps-2 test" ()
  (eql-p 3 (min-jumps-2 *example-1*))
  (eql-p 2 (min-jumps-2 *example-2*))
  (eql-p 3 (min-jumps-2 *example-3*))
  (eql-p 1 (min-jumps-2 *example-4*))
  (null-p (min-jumps-2 *example-5*))
  (null-p (min-jumps-2 *example-6*))
  (null-p (min-jumps-2 *example-7*)))

(deftest "min-jumps-3 test" ()
  (eql-p 3 (min-jumps-3 *example-1*))
  (eql-p 2 (min-jumps-3 *example-2*))
  (eql-p 3 (min-jumps-3 *example-3*))
  (eql-p 1 (min-jumps-3 *example-4*))
  (null-p (min-jumps-3 *example-5*))
  (null-p (min-jumps-3 *example-6*))
  (null-p (min-jumps-3 *example-7*)))

(defparameter *test-gen*
  (generator
   (map (lambda (xs) (make-array (list (length xs)) :initial-contents xs))
        (list (integer 0 10)))))

(deftest "min-jumps gen test" ()
  (t-p
   (let ((*list-size* 100)
	 (*num-trials* 100000))
     (check-it *test-gen*
	       (lambda (vec)
		 (let ((r1 (min-jumps vec))
		       (r2 (min-jumps-2 vec))
		       (r3 (min-jumps-3 vec)))
		   (eql-p r1 r2)
		   (eql-p r2 r3)))))))
