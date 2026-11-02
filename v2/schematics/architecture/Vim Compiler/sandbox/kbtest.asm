; SYMPHONY KEYCODE TEST
; Use Localized Mode. Every Key-Down prints the 8-bit code.

READ:
    keyboard r1
    and r2, r1, 256
    cmp r2, 0
    je READ
    and r1, r1, 255
    out r1
    jmp READ
