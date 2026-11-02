
mov r1, 5
mov r2, 25
call randbetween
loop:
jmp loop


;multiply r1 by r2, returned in r1
pub multiply:
push r2
push r3

mov r3, r1
mov r1, 0
cmp r3, r2
jmpif gt, mulloop

;swap to repeat smaller amount of times
push r3
mov r3, r2
pop r2

mulloop:
cmp r2, 0
jmpif lte, mulfin

add r1, r1, r3
sub r2, r2, 1
jmp mulloop

mulfin:
pop r3
pop r2
ret

;return random number between r1 (inclusive) and r2 (exclusive)
pub randbetween:
push r2
push r3 ;min
push r4 ;max

mov r3, r1 
mov r4, r2

call random

sub r2, r4, r3 ;max - min is the max for the divide purpose
call divide ;calc max into r2
add r2, r2, r3 ;calc min
mov r1, r2

pop r4
pop r3
pop r2
ret


;return a random number based on a seed
pub random:
push r2
push r3
push r4

load_32 r1, [randomseed]
lsr r2, r1, 13
xor r3, r1, r2

lsl r2, r3, 17
xor r4, r3, r2

lsr r2, r4, 5
xor r1, r4, r2

store_32 [randomseed], r1 ;set next seed

;and r1, r1, 0xffff ;make 16 bit

pop r4
pop r3
pop r2
ret

;set the random seed with r1
pub randomseedset:
store_32 [randomseed], r1
ret

randomseed: ;bytes in memory for the random seed
U32 124783 



;divide r1 by r2
;returns dividend in r1, modulus in r2
;can be faster with lower dividends and higher divisors
pub slowdivide:
push r4

;subtract until r2 > r1
divloop:
cmp r1, r2
jmpif bl, divdone
sub r1, r1, r2
add r4, r4, 1
jmp divloop

divdone:
mov r2, r1
mov r1, r4
pop r4
ret

;divide r1 by r2 into r1
pub divide:
push r3 ;divisor
push r4 ;counter
push r5 ;temp
push r6 ;temp answer

;r1 = dividend higher
;r2 = dividend lower
;r3 = divisor
;r4 = counter to 32
;r5 = temp
;r6 = temp answer

mov r3, r2
mov r2, r1
mov r1, 0
mov r4, 0

fastdivloop:
;shift into r1
cmp r2, 0
jmpif lt, divshift1

;0 in high bit of r2
mov r5, 0
jmp divshift

divshift1:
;1 in high bit of r2
mov r5, 1

divshift:
lsl r2, r2, 1
lsl r1, r1, 1
add r1, r1, r5

;compare
mov r5, 0
cmp r3, r1 
jmpif ab, divnosub ;if divisor <= dividend: do sub

;subtract
sub r1, r1, r3
mov r5, 1

divnosub:
;add to  answer
lsl r6, r6, 1
add r6, r6, r5

;check if loop
add r4, r4, 1
cmp r4, 32
jmpif lt, fastdivloop

mov r2, r1 ;modulus
mov r1, r6 ;quotient

pop r6
pop r5
pop r4
pop r3
ret











