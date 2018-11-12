(define cell-type-signature 'Cell)

(define (make-cell is-alive)           ; constructor
    (cons cell-type-signature is-alive))

(define (cell? cell)
    (and (pair? cell)
         (eq? cell-type-signature (car cell))))

(define (cell-is-alive cell)           ; getter
    (if (cell? cell)
        (cdr cell)
        (error "Argument is not a Cell -- cell-is-alive")))

(define (set-cell-alive! cell is-alive) ; setter
    (if (cell? cell)
        (set-cdr! cell is-alive)
        (error "Argument is not a Cell -- set-cell-alive!"))
    cell)
