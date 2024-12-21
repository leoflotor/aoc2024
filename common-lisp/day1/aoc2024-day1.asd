(defsystem "aoc2024-day1"
  :version "0.0.1"
  :author "leonardo flores torres"
  :license "mit"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "aoc2024-day1/tests"))))

(defsystem "aoc2024-day1/tests"
  :author "leonardo flores torres"
  :license "mit"
  :depends-on ("aoc2024-day1"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for aoc2024-day1"
  :perform (test-op (op c) (symbol-call :rove :run c)))
