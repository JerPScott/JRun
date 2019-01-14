;
; Boot sector to check print methods
;
[org 0x7c00]              ; Tell assembler the load location.
[bits 16]                 ; Real Mode

call clear_screen         ; Clear the screen to start.

mov bx, HELLO_MSG         ; Load BX for function call.
call print_string         ; Call register safe string print.

call new_line             ; Go to the next line.

mov dx, 0x1234            ; Setup for HEX print.
call print_hex            ; Output hex value to screen.

call new_line             ; Go to the next line.

mov dx, 0x5678            ; Setup for HEX print.
call print_hex            ; Output hex value to screen.

call new_line             ; Go to the next line.

mov dx, 0x9abc            ; Setup for HEX print.
call print_hex            ; Output hex value to screen.

call new_line             ; Go to the next line.

mov dx, 0xdef0            ; Setup for HEX print.
call print_hex            ; Output hex value to screen.

call new_line             ; Go to the next line.

mov dx, 0xff0f            ; Setup for HEX print.
call print_hex            ; Output hex value to screen.

call new_line             ; Go to the next line.

mov bx, GOODBYE_MSG       ; Load BX for function call.
call print_string         ; Call register safe string print.

jmp $                     ; Inf loop.

%include "BIOS/hex_print.inc"
%include "BIOS/video_10h/print.inc"
%include "BIOS/video_10h/cursor.inc"

; Data
HELLO_MSG:
  db 'Hello, World!', NULL

GOODBYE_MSG:
  db 'Goodbye!', NULL

; Padding and boot sector value.
times 510-($-$$) db 0
dw 0xaa55
