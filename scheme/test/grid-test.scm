(include "assert.scm")
(include "../game-of-life/grid.scm")

(test-case "(make-grid)"
    (assert-true (is-instance-grid (make-grid 1 1)))
    (assert= 3 (grid-width (make-grid 2 3)))
    (assert= 2 (grid-height (make-grid 2 3))))

(test-case "(grid-get)"
    (assert-false (cell-is-alive (grid-get (make-grid 3 2) 0 0))))

(test-case "(grid-set)"
    (let ((grid (make-grid 3 2)))
        (assert-false (cell-is-alive (grid-get grid 2 1)))
        (cell-set-alive (grid-get grid 2 1) #t)
        (assert-true (cell-is-alive (grid-get grid 2 1)))))
