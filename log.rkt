#lang racket

(provide log_info)

(require (for-syntax racket/list))

(require ansi/format)

(define (log_info-fn #:loc loc fmt . args)
  (match-define (list source line) loc)

  (display-ansi (green "INFO  ")
                (apply format fmt args)
                (dim  (format "   (~a:~a)" source line)))
  (newline))

(define-syntax (log_info stx)
  (define source (last (explode-path (syntax-source stx))))
  (define line (syntax-line stx))
  (syntax-case stx ()
    [(_ arg* ...)
     #`(log_info-fn #:loc (list #,source #,line) arg* ...)]))
