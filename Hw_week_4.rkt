
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

(define (sequence low high stride)
  (cond ((> high low)
         (cons low (sequence (+ low stride) high stride)))))

(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

(define (list-nth-mod xs n)
    (cond [(< n 0) (error "list-nth-mod: negative number")]
          [(null? xs) (error "list-nth-mod: empty list")]
          [#t (car (list-tail xs (remainder n (length xs))))]))

(define (stream-for-n-steps s n)
  (cond [(= n 0) null]
        [#t (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))]))

(define funny-number-stream
  (letrec ([f (lambda (x)
               (if (= (remainder x 5) 0)
                   (cons (- 0 x) (lambda () (f (+ x 1))))
                   (cons x (lambda () (f (+ x 1))))))])
    (lambda () (f 1))))

(define dan-then-dog
  (letrec ([f (lambda ()
                (cons "dan.jpg" (lambda () (g))))]
           [g (lambda ()
                (cons "dog.jpg" (lambda () (f))))])
    (lambda () (f))))

(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys)
  (letrec ([f (lambda (n1 n2)
                (cons (cons (list-nth-mod xs n1) (list-nth-mod ys n2)) (lambda () (f (+ n1 1) (+ n2 1)))))])
    (lambda () (f 0 0))))

(define (vector-assoc v vec)
  (letrec ([f (lambda (n)
                (cond [(= n (vector-length vec)) #f]
                      [(not (pair? (vector-ref vec n))) (f (+ n 1))]
                      [(equal? (car (vector-ref vec n)) v) (vector-ref vec n)]
                      [#t (f (+ n 1))]))])
    (f 0)))

(define (cached-assoc xs n)
    (letrec([track-next 0]
            [cache-vector (make-vector n #f)]
            [f (lambda (v)
                (let ([ans (vector-assoc v cache-vector)])
                    (if ans
                        ans
                        (let ([new-ans (assoc v xs)])
                            (if new-ans
                                (begin
                                ;(print cache-vector)
                                (vector-set! cache-vector track-next new-ans)
                                (set! track-next (remainder (+ track-next 1) n))
                                new-ans)
                                #f
                            )
                        )
                    ))
                    )])
    f))