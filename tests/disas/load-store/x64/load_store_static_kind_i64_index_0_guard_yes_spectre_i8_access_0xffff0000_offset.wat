;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -W memory64 -O static-memory-forced -O static-memory-guard-size=0 -O dynamic-memory-guard-size=0"

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
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r11, %r11
;;       movq    %rdx, %rsi
;;       addq    0x50(%rdi), %rsi
;;       movl    $0xffff0000, %edi
;;       leaq    (%rsi, %rdi), %r10
;;       cmpq    $0xffff, %rdx
;;       cmovaq  %r11, %r10
;;       movb    %cl, (%r10)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r11, %r11
;;       movq    %rdx, %rsi
;;       addq    0x50(%rdi), %rsi
;;       movl    $0xffff0000, %edi
;;       leaq    (%rsi, %rdi), %r10
;;       cmpq    $0xffff, %rdx
;;       cmovaq  %r11, %r10
;;       movzbq  (%r10), %rax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
