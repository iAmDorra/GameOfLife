(include "assert.scm")
(include "../game-of-life/grid.scm")

(test-case "(make-grid)"
    (assert-true (is-instance-grid (make-grid 2 3)))
    (assert= 2 (grid-width (make-grid 2 3)))
    (assert= 3 (grid-height (make-grid 2 3))))

(test-case "(grid-get)"
    (assert-false (cell-is-alive (grid-get (make-grid 2 3) 0 0))))

(test-case "(grid-set)"
    (let ((grid (make-grid 2 3)))
        (assert-false (cell-is-alive (grid-get grid 0 0)))
        (cell-set-alive (grid-get grid 0 0) #t)
        (assert-true (cell-is-alive (grid-get grid 0 0)))))
