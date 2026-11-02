
; =======================================
; SYMPHONY CPU STRESS BENCHMARK
; 4,000,000 loops
; 40,000,000 core instructions
; =======================================

START:
    ; Loop count = 15625 * 256
    mov r3, 15625
    lsl r3, r3, 8

    mov r6, 0
    mov r8, 0
    mov r11, 0

    ; RAM test address = 65536
    mov r9, 16384
    lsl r9, r9, 2

    ; Start time
    time_0 r1
    time_1 r2

BENCH_LOOP:
    add r6, r6, 1
    xor r8, r8, r6
    lsl r8, r8, 1
    add r8, r8, 13
    store_32 [r9], r8
    load_32 r10, [r9]
    xor r11, r11, r10
    sub r3, r3, 1
    cmp r3, 0
    jne BENCH_LOOP

    ; End time
    time_0 r4
    time_1 r5

    ; Elapsed low 32-bit
    sub r12, r4, r1

    ; Elapsed high 32-bit
    sub r7, r5, r2
    cmp r4, r1
    jae NO_BORROW
    sub r7, r7, 1

NO_BORROW:
    out 111
    out r7
    out r12
    out r6
    out r11
    out r8
    out 999

END:
    jmp END
