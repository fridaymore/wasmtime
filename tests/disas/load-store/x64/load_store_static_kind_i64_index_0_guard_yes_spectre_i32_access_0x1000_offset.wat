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
    i32.store offset=0x1000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load offset=0x1000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r10, %r10
;;       movq    0x50(%rdi), %r11
;;       leaq    0x1000(%r11, %rdx), %r9
;;       cmpq    0xe(%rip), %rdx
;;       cmovaq  %r10, %r9
;;       movl    %ecx, (%r9)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   26: addb    %al, (%rax)
;;   28: cld
;;   29: outl    %eax, %dx
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       xorq    %r10, %r10
;;       movq    0x50(%rdi), %r11
;;       leaq    0x1000(%r11, %rdx), %r9
;;       cmpq    0xe(%rip), %rdx
;;       cmovaq  %r10, %r9
;;       movl    (%r9), %eax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;   66: addb    %al, (%rax)
;;   68: cld
;;   69: outl    %eax, %dx
