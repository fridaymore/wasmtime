;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation=false -O static-memory-maximum-size=0 -O static-memory-guard-size=4294967295 -O dynamic-memory-guard-size=4294967295"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0x1000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load8_u offset=0x1000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movl    %edx, %r8d
;;       cmpq    0x58(%rdi), %r8
;;       ja      0x22
;;   11: movq    0x50(%rdi), %r10
;;       movb    %cl, 0x1000(%r10, %r8)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   22: ud2
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movl    %edx, %r8d
;;       cmpq    0x58(%rdi), %r8
;;       ja      0x63
;;   51: movq    0x50(%rdi), %r10
;;       movzbq  0x1000(%r10, %r8), %rax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   63: ud2
