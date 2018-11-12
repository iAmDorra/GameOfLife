(include "assert.scm")
(include "../game-of-life/grid.scm")

(test-case "(grid?)"
    (assert-true (grid? (make-grid 1 1))))

(test-case "Grid accessors"
    (assert= 3 (grid-width (make-grid 2 3)))
    (assert= 2 (grid-height (make-grid 2 3))))

(test-case "(grid-get)"
    (assert-false (cell-is-alive (grid-get (make-grid 3 2) 0 0))))

(test-case "Grid is mutable"
    (let ((grid (make-grid 3 2)))
        (assert-false (cell-is-alive (grid-get grid 2 1)))
        (set-cell-alive! (grid-get grid 2 1) #t)
        (assert-true (cell-is-alive (grid-get grid 2 1)))))
