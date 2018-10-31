;;;
;;; Unit test framework for Scheme
;;; Copyright (c) 2017, Peter Kofler, http://www.code-cop.org/
;;; BSD licensed.
;;;
;;; Non S5RS used functions
;;; * error from R6RS
;;; * with-exception-catcher, error-exception?, error-exception-message from Gambit
;;;

;; SchemeUnit from http://c2.com/cgi/wiki?SchemeUnit

(define (fail msg)
    (error (string-append "AssertionError" ": " msg)))

(define (check msg condition)
    (if (not condition)
        (fail msg)
        #t))

(define (assert msg condition)
    (lambda () (check msg condition)))

;; extensions

;; private
(define (make-string-message prefix to-string expected actual)
    (make-message prefix
                  (to-string expected)
                  (to-string actual)))

;; private
(define (make-message prefix expected actual)
    (string-append prefix "expected:<" expected "> but was:<" actual ">"))

(define (assert-equal to-string eq-op expected actual)
    (assert (make-string-message "" to-string expected actual)
            (eq-op expected actual)))

(define (assert= expected actual)
    (assert-equal number->string = expected actual))

(define (assert-string= expected actual)
    (assert-equal values string=? expected actual))

(define (assert-char= expected actual)
    (assert-equal string char=? expected actual))

;; private - library function
(define (interval-inside? center radius x)
    (<= (abs (- center x))
        radius))

;; private - library function
(define (interval->string center radius)
    (string-append "["
                   (number->string (- center radius))
                   "-"
                   (number->string (+ center radius))
                   "]"))

(define (assert-inexact= expected actual delta)
    (assert (make-message "in range "
                         (interval->string expected delta)
                         (number->string actual))
            (interval-inside? expected delta actual)))

(define (assert-list= to-string eq-op expected-list actual-list)
    (define (item i)
        (string-append (number->string i) ". item "))

    (define (check-list-element i expected actual)
        (let* ((no-more?   (null? expected))
               (has-more?  (null? actual))
               (both-null? (and no-more? has-more?)))
            (cond (both-null? #t)
                  (no-more?   (fail (make-message (item i)
                                                  "no more elements"
                                                  "more elements")))
                  (has-more?  (fail (make-message (item i)
                                                  "more elements"
                                                  "no more elements")))
                  (else       (check-element i expected actual)))))

    (define (check-element i expected actual)
        (let* ((expected-element (car expected))
               (actual-element   (car actual))
               (sublist?         (pair? expected-element))
               (no-sublist?      (pair? actual-element))
               (both-pair?       (and sublist? no-sublist?)))
           (cond
              (both-pair?  (check-list-element (+ (* i 10) 1)
                                               expected-element
                                               actual-element))
              (sublist?    (fail (make-message (item i)
                                               "a sublist"
                                               "no sublist")))
              (no-sublist? (fail (make-message (item i)
                                               "no sublist"
                                               "a sublist")))
              (else        (cons ; dummy chaining
                               (check-numbered i expected-element actual-element)
                               (check-list-element (+ i 1)
                                                   (cdr expected)
                                                   (cdr actual)))))))

    (define (check-numbered i expected actual)
        (check (make-message (item i)
                             (to-string expected)
                             (to-string actual))
               (eq-op expected actual)))

    (lambda ()
        (check-list-element 1 expected-list actual-list)))

(define (assert-string-list= expected-list actual-list)
    (assert-list= values string=? expected-list actual-list))

;; private - library function
(define (boolean->string b)
    (if b "true" "false"))

(define (assert-true actual)
    (assert (make-string-message "" boolean->string #t #f)
            actual))

(define (assert-false actual)
    (assert (make-string-message "" boolean->string #f #t)
            (not actual)))

(define (assert-null actual)
    (assert (make-message "" "null" "not null")
            (null? actual)))

(define (assert-not-null actual)
    (assert (make-message "" "not null" "null")
            (not (null? actual))))

(define (assert-raise expected-ex body)
    (define (error-exception->string ex)
        (cond ((symbol? ex)          (symbol->string ex))
              ((string? ex)          ex)
              ((error-exception? ex) (error-exception->string (error-exception-message ex)))
              (else                  ""))) ; cannot determine message

    (lambda ()
        (with-exception-catcher
            (lambda (ex)
                (let ((expected-message (error-exception->string expected-ex))
                      (actual-message   (error-exception->string ex)))
                    (check
                        (make-string-message "raise " error-exception->string expected-ex ex)
                        (string=? expected-message actual-message))))
            (lambda () (fail (body))))))

;; private
(define (test-case-name name)
    (display name)
    (display " ... "))

;; private
(define (test-case-success)
    (display "OK")
    (newline))

(define (test-case name . assertions)
    (test-case-name name)
    (for-each (lambda (a) (a)) assertions)
    (test-case-success))

;; private
(define (test-case-ignored)
    (display "IGNORED")
    (newline))

(define (ignored-test-case name . assertions)
    (test-case-name name)
    (test-case-ignored))
