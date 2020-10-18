#lang racket/base

(require ffi/unsafe
         ffi/unsafe/define)

(require "log.rkt")

(define-ffi-definer define-uv (ffi-lib "libuv"))

(define (check v who)
  (unless (zero? v)
    (error who "failed: ~a" v)))

(define-uv uv_uptime
  (_fun (uptime : (_ptr o _double))
        ->  (r : _int)
        -> (begin
             (check r 'uv_uptime)
             uptime)))

(define-uv uv_resident_set_memory
  (_fun (resident_set_memory : (_ptr o _int))
        -> (r : _int)
        -> (begin
             (check r 'uv_resident_set_memory)
             resident_set_memory)))

(log_info "Uptime: ~a" (uv_uptime))
(log_info "RSS: ~a" (uv_resident_set_memory))
