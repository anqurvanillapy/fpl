;;; call-with-current-continuation, call/cc.

(newline)

(define (println x)
  (display x)
  (newline))

(define call/cc call-with-current-continuation)

;;; Continuation as parameter, literally *call with continuation*.

(newline)

(define (f return)
  (return 42)
  69)

(println (f (lambda (x) x))) ; 69

;; Now `return' is the continuation `(println (_))'.
(println (call/cc f)) ; 42

;;; Perserve and restore continuation.

(newline)

(define cont 'nil)

;; Continuation `(println (+ 1 _))' stored in cont.
(println (+ 1
            (call/cc (lambda (c)
                       (set! cont c)
                       3)))) ; 4

(cont 42) ; 43

(* 666 (cont 42)) ; 43, as the current continuation is replaced.

;;; Generator.


(newline)

;; Note: (define x 42) (set! x (set! x (+ x x))) returns 84 but x is 42, hence
;; the second `set!' is eval-ed first.

(define (iter lst)
  (define (state return)
    (for-each
      (lambda (elem)
        (set! return (call/cc
                       (lambda (resume)
                         (set! state resume)
                         ;; a) Suspension after `(return elem)'.
                         ;; b) Second call leads to continuation `resume'.
                         ;; c) Expression returns to `(set! return _)', updating
                         ;; continuation `return'.
                         ;; d) Next iteration.
                         (return elem)))))
      lst)
    (return 'nil))
  (define (generator)
    (call/cc state))
  generator)

(define foo (iter '(1 2 3)))

(println (foo))
(println (foo))
(println (foo))
(println (foo))

;;; Cooperative multitasking.

(newline)

(define task-queue '())

(define exit
  (let ((exit exit))
    (lambda ()
      (if (not (null? task-queue))
          (let ((task (car task-queue)))
            (set! task-queue (cdr task-queue))
            (task '()))
          (exit)))))

(define (fork fn arg)
  (set! task-queue
    (append task-queue
            (cons
              (lambda (x)
                (fn arg)
                (exit))
              '()))))

(define (yield)
  (call/cc (lambda (cont)
             (set! task-queue
               (append task-queue
                       (cons cont '())))
             (let ((task (car task-queue)))
               (set! task-queue (cdr task-queue))
               (task '())))))

(define (run)
  (let ((task (car task-queue)))
    (set! task-queue (cdr task-queue))
    (task '())))

(define (t0 x)
  (println "task0 start")
  (yield)
  (println (string "task0: " (* 2 x))))

(define (t1 x)
  (println "task1 start")
  (yield)
  (println (string "task1: " (+ 69 x))))

(fork t0 42)
(fork t1 42)
(run)
