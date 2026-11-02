
; SYMPHONY - ASCII 8 SCREEN TEST

; Mode 0 = ASCII 8
screen zr, 0

; Setting 1 = Data Offset
mov r2, 1
screen r2, 256
; Write HELLO WORLD! at address 256

mov r1, 72       ; H
store_8 [256], r1

mov r1, 69       ; E
store_8 [257], r1

mov r1, 76       ; LL
store_8 [258], r1
store_8 [259], r1

mov r1, 79       ; O
store_8 [260], r1

mov r1, 32       ;  
store_8 [261], r1

mov r1, 87       ; W
store_8 [262], r1

mov r1, 79       ; O
store_8 [263], r1

mov r1, 82       ; R
store_8 [264], r1

mov r1, 76       ; L
store_8 [265], r1

mov r1, 68       ; D 
store_8 [266], r1

mov r1, 33       ; ! 
store_8 [267], r1

END:
    jmp END
