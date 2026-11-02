
; ==================================
; SYMPHONY - NEON SNAKE
; Pixel 8 RGB332
; Resolution: 8 x 6
; Frame Buffer: 192 - 239
; ==================================

; Screen Mode = Pixel 8
screen zr, 2

; Setting 1 = Data Offset
mov r1, 1
screen r1, 192

; Setting 2 = Resolution
; n = 1 -> 8 x 6
mov r1, 2
screen r1, 1

; ==================================
; Clear Screen
; ==================================

mov r2, 192

CLEAR:
    store_8 [r2], zr
    add r2, r2, 1
    cmp r2, 240
    jne CLEAR

; ==================================
; Initialize Snake
; ==================================

mov r3, 192    ; Head address
mov r4, 234    ; Tail address
mov r5, 224    ; Initial color

; ==================================
; Animation Loop
; ==================================

LOOP:

    ; Draw colored head
    store_8 [r3], r5

    ; Erase old tail
    store_8 [r4], zr

    ; Move head
    add r3, r3, 1

    cmp r3, 240
    jne HEAD_OK

    mov r3, 192

HEAD_OK:

    ; Move tail
    add r4, r4, 1

    cmp r4, 240
    jne TAIL_OK

    mov r4, 192

TAIL_OK:

    ; Cycle RGB332 colors
    add r5, r5, 37
    and r5, r5, 255

    jmp LOOP
