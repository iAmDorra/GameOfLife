(include "assert.scm")
(include "../game-of-life/grid-manager.scm")

(test-case "should not change cells if all cells are dead"
    (let ((new-grid (get-new-state (make-grid 1 1))))
        (assert-false (cell-is-alive (grid-get new-grid 0 0)))))

(test-case "should not kill cell if it has two neighbours"
    (let ((grid (make-grid 3 3)))
        (set-cell-alive! (grid-get grid 0 2) #t)
        (set-cell-alive! (grid-get grid 1 1) #t)
        (set-cell-alive! (grid-get grid 2 0) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-true (cell-is-alive (grid-get new-grid 1 1))))))

(test-case "should kill cell if it has less than two neighbours"
    (let ((grid (make-grid 2 4)))
        (set-cell-alive! (grid-get grid 1 0) #t)
        (set-cell-alive! (grid-get grid 1 1) #t)
        (set-cell-alive! (grid-get grid 1 2) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-false (cell-is-alive (grid-get new-grid 1 0)))
            (assert-false (cell-is-alive (grid-get new-grid 1 2))))))

(test-case "should alive cell if it has three neighbours"
    (let ((grid (make-grid 2 2)))
        (set-cell-alive! (grid-get grid 0 1) #t)
        (set-cell-alive! (grid-get grid 1 0) #t)
        (set-cell-alive! (grid-get grid 1 1) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-true (cell-is-alive (grid-get new-grid 0 0))))))

(test-case "should kill cell if it has more than three neighbours"
    (let ((grid (make-grid 4 3)))
        (set-cell-alive! (grid-get grid 0 2) #t)
        (set-cell-alive! (grid-get grid 1 1) #t)
        (set-cell-alive! (grid-get grid 2 0) #t)
        (set-cell-alive! (grid-get grid 2 1) #t)
        (set-cell-alive! (grid-get grid 2 2) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-false (cell-is-alive (grid-get new-grid 1 1))))))

(test-case "should count neighbours of cell"
    (let ((grid (make-grid 2 3)))
        (set-cell-alive! (grid-get grid 0 1) #t)
        (set-cell-alive! (grid-get grid 1 0) #t)
        (set-cell-alive! (grid-get grid 1 1) #t)
        (assert= 2 (count-neighbours grid 0 1))
        (assert= 3 (count-neighbours grid 0 0))))
