(include "cell.scm")
(include "grid.scm")

(define (for-loop from to-excluded fun)
    (if (< from to-excluded)
        (cons (fun from)
              (for-loop (+ from 1)
                        to-excluded
                        fun))
        '()))

(define (get-new-state grid)
    (letrec ((new-grid (make-grid (grid-height grid)
                                  (grid-width grid))))
        (for-loop 0
            (grid-height grid)
            (lambda (i)
                (for-loop 0
                    (grid-width grid)
                    (lambda (j)
                        (let ((nb-neighbours (count-neighbours grid i j)))
                            (cond ((= nb-neighbours 2) (set-cell-alive! (grid-get new-grid i j)
                                                                        (cell-is-alive (grid-get grid i j))))
                                  ((= nb-neighbours 3) (set-cell-alive! (grid-get new-grid i j) #t))))))))
        new-grid))

(define (count-neighbours grid i j)
    (let ((nb-neighbours 0))
        (if (is-alive-neighbour grid
                                (- i 1)
                                (- j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                i
                                (- j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                (+ i 1)
                                (- j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                (- i 1)
                                j)
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                (+ i 1)
                                j)
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                (- i 1)
                                (+ j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                i
                                (+ j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        (if (is-alive-neighbour grid
                                (+ i 1)
                                (+ j 1))
            (set! nb-neighbours (+ nb-neighbours 1)))
        nb-neighbours))

(define (is-alive-neighbour grid i j)
    (and (>= i 0)
         (< i (grid-height grid))
         (>= j 0)
         (< j (grid-width grid))
         (cell-is-alive (grid-get grid i j))))
