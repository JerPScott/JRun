;
; Boot sector to check print methods
;
[org 0x7c00]              ; Tell assembler the load location.

mov bx, HELLO_MSG         ; Load BX for function call.
call print_string         ; Call register safe string print.

call new_line             ; Go to the next line.

mov bx, GOODBYE_MSG       ; Load BX for function call.
call print_string         ; Call register safe string print.

jmp $                     ; Inf loop.

%include "../inc/BIOS/video_10h/print.asm"
%include "../inc/BIOS/video_10h/cursor.asm"

; Data
HELLO_MSG:
  db 'Hello, World!', NULL

GOODBYE_MSG:
  db 'Goodbye!', NULL

; Padding and boot sector value.
times 510-($-$$) db 0
dw 0xaa55
