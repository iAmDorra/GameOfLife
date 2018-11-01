(include "cell.scm")
(include "grid.scm")

(define (get-new-state grid)
    (letrec ((new-grid (make-grid (grid-height grid)
                               (grid-width grid)))
          (loop     (lambda (current limit f)
                        (if (< current limit)
                            (cons (f current) ; dummy cons
                                  (loop (+ current 1)
                                        limit
                                        f))
                            '()))))    ; dummy value
        (loop 0
              (grid-height grid)
              (lambda (i)
                  (loop 0
                        (grid-width grid)
                        (lambda (j)
                            (let ((nb-neighbours (count-neighbours grid i j)))
                                (cond ((= nb-neighbours 2) (cell-set-alive (grid-get new-grid i j)
                                                                           (cell-is-alive (grid-get grid i j))))
                                      ((= nb-neighbours 3) (cell-set-alive (grid-get new-grid i j) #t))))))))
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

;; private
(define (is-alive-neighbour grid i j)
    (and (>= i 0)
         (< i (grid-height grid))
         (>= j 0)
         (< j (grid-width grid))
         (cell-is-alive (grid-get grid i j))))
