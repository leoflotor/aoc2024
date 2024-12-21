(defpackage aoc2024-day1/tests/main
  (:use :cl
        :rove)
  (:local-nicknames (:day1 :aoc2024-day1)))
(in-package :aoc2024-day1/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :aoc2024-day1)' in your Lisp.

(deftest test-target-1
  (testing "Test for dummy input part 1"
    (ok (= (day1::part-1 day1::*dummy*) 11)))
  (testing "Test for dummy input part 2"
    (ok (= (day1::part-2 day1::*dummy*) 31))))

(deftest test-target-2
  (testing "Test for input part 1"
    (ok (= (day1::part-1 day1::*input*) 2430334)))
  (testing "Test for input part 2"
    (ok (= (day1::part-2 day1::*input*) 28786472))))
