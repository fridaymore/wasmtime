;;! target = "aarch64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -W memory64 -O static-memory-forced -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0xffff0000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load8_u offset=0xffff0000))

;; wasm[0]::function[0]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       mov     x10, #0
;;       ldr     x11, [x2, #0x50]
;;       add     x11, x11, x4
;;       mov     x12, #0xffff0000
;;       add     x11, x11, x12
;;       mov     x9, #0xffff
;;       cmp     x4, x9
;;       csel    x12, x10, x11, hi
;;       csdb
;;       strb    w5, [x12]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
;;
;; wasm[0]::function[1]:
;;       stp     x29, x30, [sp, #-0x10]!
;;       mov     x29, sp
;;       mov     x10, #0
;;       ldr     x11, [x2, #0x50]
;;       add     x11, x11, x4
;;       mov     x12, #0xffff0000
;;       add     x11, x11, x12
;;       mov     x9, #0xffff
;;       cmp     x4, x9
;;       csel    x12, x10, x11, hi
;;       csdb
;;       ldrb    w2, [x12]
;;       ldp     x29, x30, [sp], #0x10
;;       ret
