(include "assert.scm")
(include "../game-of-life/cell.scm")

(test-case "(cell?)"
    (assert-false (cell? 1))
    (assert-false (cell? (cons 1 2)))
    (assert-true (cell? (make-cell #t))))

(test-case "(cell-is-alive)"
    (assert-true (cell-is-alive (make-cell #t)))
    (assert-false (cell-is-alive (make-cell #f))))

(test-case "(set-cell-alive!)"
    (assert-true (cell-is-alive (set-cell-alive! (make-cell #f) #t)))
    (assert-false (cell-is-alive (set-cell-alive! (make-cell #t) #f))))
