
; ==========================================
; SYMPHONY CPU - FIBONACCI MIRROR TEST
; ==========================================
; Tests: ALU, RAM, STACK, CALL, RET
; CMP, JNE, IO, REGISTER
;
; r1 = Fibonacci A
; r2 = Fibonacci B
; r3 = Temporary Result
; r4 = Loop Counter
; sp = Stack Pointer
; ==========================================

; Initialize
mov sp, 1024
mov r1, 0
mov r2, 1
mov r4, 10
screen zr, 0
screen r2, 4096
mov r13, 4096

; ==========================================
; PHASE 1: GENERATE FIBONACCI
; ==========================================

GENERATE:
    push r1
    call PRINT_WRAPPER

    ; Calculate next Fibonacci
    add r3, r1, r2
    mov r1, r2
    mov r2, r3

    sub r4, r4, 1
    cmp r4, 0
    jne GENERATE

; Separator
out 999

; ==========================================
; PHASE 2: REVERSE USING STACK
; ==========================================

mov r4, 10

REVERSE:
    pop r1
    call PRINT_WRAPPER

    sub r4, r4, 1
    cmp r4, 0
    jne REVERSE

; Completed
out 888

END:
    jmp END

; ==========================================
; FUNCTIONS
; ==========================================

PRINT_WRAPPER:
	out r1
    call PRINT 
    ret

PRINT:
	mov r12, r1
	mov r9, 32
	cmp r12, 0
	je ZERO
	mov r11, 1
	lsl r11, r11, 31
LEFT_SHIFT:
	and r10, r11, r12
	cmp r10, 0
	jne SHOW_RETURN
	lsl r12, r12, 1
	sub r9, r9, 1
	jmp LEFT_SHIFT
SHOW_RETURN:
	cmp r9, 0
	jne SHOW_SCREEN
	mov r12, 32
	store_8 [r13], r12
    add r13, r13, 1
    ret
ZERO:
	mov r10, 48
	store_8 [r13], r10
    add r13, r13, 1
    mov r10, 32
	store_8 [r13], r10
    add r13, r13, 1
    ret
    
SHOW_SCREEN:
	and r10, r11, r12
	lsr r10, r10, 31
	add r10, r10, 48
	store_8 [r13], r10
    add r13, r13, 1
    lsl r12, r12, 1
    sub r9, r9, 1
    jmp SHOW_RETURN
