(include "cell.scm")

(define grid-type 'grid)

(define (make-grid h w)
    (list grid-type h w (list->vector (make-cell-list (* h w)))))

;; private
(define (make-cell-list size)
    (if (zero? size)
        '()
        (cons (make-cell #f)
              (make-cell-list (- size 1)))))

;; private
(define (is-instance-grid grid)
    (and (list? grid)
         (= 4 (length grid))
         (eq? grid-type (car grid))))

(define (grid-width grid)
    (if (is-instance-grid grid)
        (caddr grid)
        (error "Argument is not a Grid -- grid-width")))

(define (grid-height grid)
    (if (is-instance-grid grid)
        (cadr grid)
        (error "Argument is not a Grid -- grid-height")))

(define (grid-get grid i j)
    (vector-ref (cadddr grid) (+ (* (grid-width grid) i) j)))
