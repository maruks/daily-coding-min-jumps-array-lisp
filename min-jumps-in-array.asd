;;;; min-jumps-in-array.asd

(defsystem "min-jumps-in-array"
  :description "Describe min-jumps-in-array here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:iterate :alexandria :queues.simple-queue)
  :components ((:module "src"
		:components ((:file "min-jumps-in-array"))))
  :in-order-to ((test-op (test-op "min-jumps-in-array/tests"))))

(defsystem "min-jumps-in-array/tests"
  :license "Specify license here"
  :depends-on (:min-jumps-in-array
	       :cacau
	       :check-it
	       :assert-p)
  :serial t
  :components ((:module "tests"
		:components ((:file "min-jumps-in-array-tests"))))
  :perform (test-op (o c) (symbol-call 'cacau 'run :colorful t :reporter :list)))
