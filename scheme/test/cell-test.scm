(include "assert.scm")
(include "../game-of-life/cell.scm")

(test-case "(make-cell)"
    (assert-true (is-instance-cell (make-cell #t)))
    (assert-true (cell-is-alive (make-cell #t)))
    (assert-false (cell-is-alive (make-cell #f))))

(test-case "(cell-set-aliv)"
    (assert-true (cell-is-alive (cell-set-alive (make-cell #f) #t)))
    (assert-false (cell-is-alive (cell-set-alive (make-cell #t) #f))))
