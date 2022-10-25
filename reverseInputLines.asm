; R E V E R S I N G
; =================
; void reverse()
; Recursively read in words, until none are found anymore.
; After the recursive calls are done, write out the word again.
reverseInputLines:

  call1_1 edx, readLine, input_buffer

  cmp edx, 0          ; If nothing was read, it means the
  jg there_is_input   ; input is already fully processed, i.e.
  ret                 ; that this call is finished.

there_is_input:
  mov eax, esp   ; Original stack pointer
  sub eax, edx   ; Enough space to store the read string

  mov ebx, 3     ; Complement of round-to-multiples-of-4 bitmask
  not ebx
  and eax, ebx   ; Align stack location to 32-bit
  mov esi, esp   ; NEW: save stack pointer
  mov esp, eax   ; Allocate the space on the stack

  mov eax, 0     ; Index into the buffer when copying


  ; -----------------------------------------------
  ; Solution --------------------------------------
  ; -----------------------------------------------

push_loop:
  ; Move bytes from input_buffer one by one into
  ; ebx and push onto stack
  ; Offset by eax and inc while eax is less than
  ; edx, count bytes read
  ; Finally push the count onto the stack
  movzx ebx, byte [input_buffer + eax]
  push dword ebx
  inc eax
  cmp eax, edx
  jl push_loop
  push dword eax

  pop eax                         ; Get count from stack
  mov edx, eax
pop_loop:
  pop dword ecx                         ; Get char
  dec eax
  mov [input_buffer + eax], ecx   ; Move char into buffer
  cmp eax, 0
  jg pop_loop

  mov [input_buffer + edx], byte LINE_SHIFT
  inc edx

  mov ecx, input_buffer
  mov ebx, STDOUT
  mov eax, SYS_WRITE
  int 0x80

  mov esp, esi                    ; Restore stack pointer with return address
  ret
