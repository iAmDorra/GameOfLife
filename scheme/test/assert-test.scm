(include "assert.scm")

(test-case "(check) should not fail on #t condition"
    (lambda ()
        (check "should not fail" #t)))

(test-case "(assert=) equals number"
    (assert= 1 1))

(test-case "(assert-string=) equals string"
    (assert-string= "abc" "abc"))

(test-case "(assert-true)"
    (assert-true #t))

(test-case "(assert-false)"
    (assert-false #f))

(test-case "(test-case) allows several assertions"
    (assert-false #f)
    (assert-false #f))

(ignored-test-case "(ignored-test-case) is ignored, else it would fail"
    (assert-true #f))
