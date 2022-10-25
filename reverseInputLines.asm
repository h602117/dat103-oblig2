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
  mov esp, eax   ; Allocate the space on the stack

  mov eax, 0     ; Index into the buffer when copying


  ; -----------------------------------------------
  ; Solution --------------------------------------
  ; -----------------------------------------------

push_loop:
  movzx ebx, byte [input_buffer + eax]        ; Move byte from input_buffer into ebx
  push dword ebx                              ; Push byte as dword onto stack
  inc eax                                     ; Increase counter
  cmp eax, edx                                ; Compare counter to total char count
  jl push_loop                                ; Continue looping if more chars left
  push dword eax                              ; Push char count onto stack

  call reverseInputLines                      ; Recursively get another line

  pop eax                                     ; Get char count from stack to be used as counter
  mov edx, eax                                ; Save copy of char count
pop_loop:
  pop dword ecx                               ; Get char of stack
  dec eax                                     ; Decrement counter
  mov [input_buffer + eax], cl                ; Move char into buffer as byte, by taking only the lower part of the register
  cmp eax, 0x00                               ; Compare counter to zero
  jg pop_loop                                 ; Continue looping if more chars in line

  mov [input_buffer + edx], byte LINE_SHIFT   ; Append new line to buffer
  inc edx                                     ; Increase char count used for printing

  ; Ready register for printing buffer, edx (count) is set above
  mov ecx, input_buffer
  mov ebx, STDOUT
  mov eax, SYS_WRITE
  int 0x80                                    ; Call interrupt

  pop eax                                     ; Remove shit left by funret1_1 macro!!!
  ret
