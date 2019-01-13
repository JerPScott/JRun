;
; @title Print hex values to conosle.
;
; @short Use BIOS printing capabilities to output
;        hex values to screen.
;

%ifndef BIOS_hex_print
%define BIOS_hex_print
; Avoid running code by including.
jmp BIOS_hex_print_file_end

;
; @desc Print a hex value to the console
;
; @reg DX [in]  hex value to print.
; @reg AX [out] Undefined.
print_hex:
  pusha
  call set_hex_string   ; Setup data for printing.
  mov bx, HEX_STRING    ; Load BX for print call.
  call print_string     ; Print value to console.
  popa
  ret

;
; @desc Set HEX_STRING with value.
;
; @reg DX [in]  Hex value to turn to string.
set_hex_string:
  pusha

  ; Get high order 4 bits.
  mov bx, dx
  and bx, 0xffff              ; Mask out unwanted higher order bits.
  shr bx, 0x0c                ; Shift right.
  mov al, [HEX_CHARS+bx]      ; Get char from memory.
  mov [HEX_STRING+0x02], al   ; Place char into hex string.

  ; Get second highest 4 bits
  mov bx, dx
  and bx, 0x0fff
  shr bx, 0x08
  mov al, [HEX_CHARS+bx]
  mov [HEX_STRING+0x03], al

  ; Get Second lowest 4 bits
  mov bx, dx
  and bx, 0x00ff
  shr bx, 0x04
  mov al, [HEX_CHARS+bx]
  mov [HEX_STRING+0x04], al

  ; Get lowest 4 bits
  mov bx, dx
  and bx, 0x000f
  mov al, [HEX_CHARS+bx]
  mov [HEX_STRING+0x05], al

  popa
  ret

%include "BIOS/video_10h/print.inc"

HEX_STRING: db '0x0000', NULL
HEX_CHARS: db '0123456789abcdef', NULL

BIOS_hex_print_file_end:
%endif ; BIOS_hex_print
