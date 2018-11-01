(include "cell.scm")

(define grid-type 'grid)

(define (make-grid width height)
    (list grid-type width height (list->vector (make-cell-list (* width height)))))

;; private
(define (make-cell-list size)
    (if (= size 0)
        '()
        (cons (make-cell #f)
              (make-cell-list (- size 1)))))

(define (is-instance-grid grid)
    (and (list? grid)
         (= 4 (length grid))
         (eq? grid-type (car grid))))

(define (grid-width grid)
    (if (is-instance-grid grid)
        (cadr grid)
        (error "Argument is not a Grid -- grid-width")))

(define (grid-height grid)
    (if (is-instance-grid grid)
        (caddr grid)
        (error "Argument is not a Grid -- grid-height")))

(define (grid-get grid x y)
    (vector-ref (cadddr grid) (+ (* (grid-width grid) y) x)))
