(include "cell.scm")

(define grid-type-signature 'Grid)

(define (make-grid h w)                ; constructor
    (define (make-cell-list size)
        (if (zero? size)
            '()
            (cons (make-cell #f)
                  (make-cell-list (- size 1)))))
    (list grid-type-signature h w (list->vector (make-cell-list (* h w)))))

(define (grid? grid)
    (and (list? grid)
         (= 4 (length grid))
         (eq? grid-type-signature (car grid))))

(define (grid-width grid)              ; getter
    (if (grid? grid)
        (caddr grid)
        (error "Argument is not a Grid -- grid-width")))

(define (grid-height grid)             ; getter
    (if (grid? grid)
        (cadr grid)
        (error "Argument is not a Grid -- grid-height")))

(define (grid-get grid i j)            ; indexed getter
    (let ((index (+ (* (grid-width grid) i) j)))
        (vector-ref (cadddr grid) index)))
