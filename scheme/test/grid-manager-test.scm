(include "assert.scm")
(include "../game-of-life/grid-manager.scm")

(test-case "should_not_change_cells_if_all_cells_are_dead"
    (let ((new-grid (get-new-state (make-grid 1 1))))
        (assert-false (cell-is-alive (grid-get new-grid 0 0)))))

(test-case "should_not_kill_cell_if_it_has_two_neighbours"
    (let ((grid (make-grid 3 3)))
        (cell-set-alive (grid-get grid 0 2) #t)
        (cell-set-alive (grid-get grid 1 1) #t)
        (cell-set-alive (grid-get grid 2 0) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-true (cell-is-alive (grid-get new-grid 1 1))))))

(test-case "should_kill_cell_if_it_has_less_than_two_neighbours"
    (let ((grid (make-grid 2 4)))
        (cell-set-alive (grid-get grid 1 0) #t)
        (cell-set-alive (grid-get grid 1 1) #t)
        (cell-set-alive (grid-get grid 1 2) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-false (cell-is-alive (grid-get new-grid 1 0)))
            (assert-false (cell-is-alive (grid-get new-grid 1 2))))))

(test-case "should_alive_cell_if_it_has_three_neighbours"
    (let ((grid (make-grid 2 2)))
        (cell-set-alive (grid-get grid 0 1) #t)
        (cell-set-alive (grid-get grid 1 0) #t)
        (cell-set-alive (grid-get grid 1 1) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-true (cell-is-alive (grid-get new-grid 0 0))))))

(test-case "should_kill_cell_if_it_has_more_than_three_neighbours"
    (let ((grid (make-grid 4 3)))
        (cell-set-alive (grid-get grid 0 2) #t)
        (cell-set-alive (grid-get grid 1 1) #t)
        (cell-set-alive (grid-get grid 2 0) #t)
        (cell-set-alive (grid-get grid 2 1) #t)
        (cell-set-alive (grid-get grid 2 2) #t)
        (let ((new-grid (get-new-state grid)))
            (assert-false (cell-is-alive (grid-get new-grid 1 1))))))

(test-case "should_count_neighbours_of_cell"
    (let ((grid (make-grid 2 3)))
        (cell-set-alive (grid-get grid 0 1) #t)
        (cell-set-alive (grid-get grid 1 0) #t)
        (cell-set-alive (grid-get grid 1 1) #t)
        (assert= 2 (count-neighbours grid 0 1))
        (assert= 3 (count-neighbours grid 0 0))))
