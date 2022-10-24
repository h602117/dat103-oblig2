%include "macros.asm"
%include "readLine.asm"
%include "reverseInputLines.asm"

section .data
  STDIN equ 0
  STDOUT equ 1
  SYS_READ equ 3
  SYS_WRITE equ 4
  LINE_SHIFT equ 10
  buf_size equ 4096

section .bss
  input_buffer resb buf_size

;  M A I N  E N T R Y  P O I N T
;  =============================
section .text
global _start
_start:
  call reverseInputLines

  ; sys_exit system call
  mov ebx, 0              ; Exit code
  mov eax, 0x01           ; Exit syscall
  int 0x80                ; Call interrupt

