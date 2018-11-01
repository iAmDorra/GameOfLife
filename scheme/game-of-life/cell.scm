(define cell-type 'cell)

(define (make-cell is-alive)
    (cons cell-type is-alive))

;; private
(define (is-instance-cell cell)
    (and (pair? cell)
         (eq? cell-type (car cell))))

(define (cell-is-alive cell)
    (if (is-instance-cell cell)
        (cdr cell)
        (error "Argument is not a Cell -- cell-is-alive")))

(define (cell-set-alive cell is-alive)
    (if (is-instance-cell cell)
        (set-cdr! cell is-alive)
        (error "Argument is not a Cell -- cell-set-alive"))
    cell)
