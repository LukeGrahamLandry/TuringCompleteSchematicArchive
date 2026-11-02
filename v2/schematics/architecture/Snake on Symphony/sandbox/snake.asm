

const screen_buffer =	r13 ;pointer
const snake =			r12	;pointer
const fruit =			r11 ;pointer
const key =				r10 ;reg
const direction =		r9  ;reg
const snakelength =		r8 ;length of snake list, reg
const snakeend =		r7 ;index in list for end of snake position, reg
const addr =			r6 ;for addressing, reg

;				0xrrggbbXX
const black =	0x00000000
const white =	0xffffff00
const red =		0xff000000


const resolution = 9 ;40 x 30 ;1200 pixels total
;4 x (res + 1) x 3 x (res + 1)
const pixels = 1200
const screen_size = 4800; in bytes, so x4
const width = 40
const height = 30

const snakeobjsize = 9600 ;x and y, 4 bytes each, as many as there can be pixels 
const fruitsize = 8; x and y position

const up = 1
const down = 3
const left = 4
const right = 2
const space = 32


const screen_mode = 0
const screen_offset = 1
const screen_resolution = 2

;static allocated variables
atefruit:
U32 0
second_screen_buffer:
U32 0
paused:
U32 0

jmp init

include malloc
include math


init:
mov r1, screen_size
call malloc.malloc ;alloc screen buffer
mov screen_buffer, r1

mov r1, screen_size
call malloc.malloc
store_32 [second_screen_buffer], r1

mov r1, snakeobjsize
call malloc.malloc ;alloc snake list
mov snake, r1

mov r1, fruitsize
call malloc.malloc ;alloc fruit pos
mov fruit, r1

;start snake in middle of screen moving right
mov direction, right
mov snakelength, 1
mov r1, 2
mov r2, 2
;save first position
store_32 [snake], r1
add r1, snake, 4
store_32 [r1], r2

call growsnake ; 2
call growsnake ; 3
call growsnake ; 4
call growsnake ; 5

call newfruit


initscreen:
mov r1, screen_mode
screen r1, 3
mov r1, screen_resolution
screen r1, resolution
mov r1, screen_offset
screen r1, screen_buffer

call drawscreen
call drawscreen


loop:

inputloop:
;get input
keyboard key
and r2, key, 0x0100 ; get keydown
lsr r2, key, 8 ; shift to low byte
and key, key, 0x00ff ; clean key input

;done handling inputs
cmp key, 0
jmpif equ, inputdone

;only handle keydown
cmp r2, 0
jmpif equ, inputloop

cmp key, up
jmpif equ, dirkeypressed
cmp key, down
jmpif equ, dirkeypressed
cmp key, right
jmpif equ, dirkeypressed
cmp key, left
jmpif equ, dirkeypressed
cmp key, space
jmpif equ, spacepressed

;no arrows pressed
jmp inputloop

dirkeypressed:
mov direction, key
jmp inputloop

spacepressed:
load_32 r1, [paused]
not r1, r1
store_32 [paused], r1
jmp inputloop


inputdone:
load_32 r1, [paused]
cmp r1, 0
jmpif neq, loop


;handle movement
call growsnake
load_32 r1, [atefruit]
cmp r1, 0
jmpif neq, skipshrink

call shrinksnake
skipshrink:
store_32 [atefruit], zr ;reset atefruit for next loop

;handle drawing to screen
call drawscreen

jmp loop

end:
jmp end


;get the memory address for a position in the screen by width and height
;r1 = x, r2 = y
;returns address in r1
postobuffer:
;(width * y + x) * 4 bytes
;+ bufferstart
push r1
mov r1, width
call math.multiply
pop r2
add r1, r1, r2
lsl r1, r1, 2; * 4
add r1, r1, screen_buffer
ret

;get random x and y for a position
randpos:

mov r1, 0
mov r2, width
call math.randbetween
push r1

mov r1, 0
mov r2, height
call math.randbetween
mov r2, r1
pop r1

ret

;draw all snake pieces and body to screen buffer
;	after drawing all black to it
drawscreen:
push r1
push r2
push r3
push r4
push addr

;for addr = screenbuffer; addr < screenbuffer+csreen_size;addr+=4
mov r4, screen_buffer
drawloop1:
add r3, screen_buffer, screen_size
cmp r4, r3
jmpif gte, drawloop1done

store_32 [r4], zr ;black
add r4, r4, 4
jmp drawloop1
drawloop1done: ;screen is black

;draw snake

mov r4, 0;index
mov addr, snake
snakedrawloop:

cmp r4, snakelength
jmpif gte, donesnakedraw

mov r1, r4
call getsnakeaddress
mov addr, r1

snakedraw1:
;get pos
load_32 r1, [addr]
add addr, addr, 4 ;get y
load_32 r2, [addr]

;draw pos
call postobuffer
mov r2, !white
store_32 [r1], r2


;increment index
add r4, r4, 1
jmp snakedrawloop

donesnakedraw:

;draw fruit
mov r4, fruit
load_32 r1, [r4]
add r4, r4, 4
load_32 r2, [r4]
call postobuffer

mov r4, r1
mov r1, !red
store_32 [r4], r1


;swap double buffer
mov r4, screen_buffer
load_32 screen_buffer, [second_screen_buffer]
store_32 [second_screen_buffer], r4

mov r1, screen_offset
screen r1, r4

pop addr
pop r4
pop r3
pop r2
pop r1
ret


;grow snake
growsnake:
push r1
push r2
push r3
push r4 ;old head pos
push addr

;get old head pos
sub r1, snakelength, 1
call getsnakeaddress
mov r4, r1

;add to length
add snakelength, snakelength, 1

;get address
sub r1, snakelength, 1
call getsnakeaddress
mov addr, r1

;get new position from direction

cmp direction, up
jmpif equ, snakegrowup
cmp direction, down
jmpif equ, snakegrowdown
cmp direction, left
jmpif equ, snakegrowleft
cmp direction, right
jmpif equ, snakegrowright

snakegrowup:
load_32 r1, [r4] ;old x
add r3, r4, 4 ;old position y
load_32 r2, [r3]
sub r3, r2, 1 ;go up

cmp r3, r2
jmpif ab, snakehittop
mov r2, r3
jmp snakegrow1

snakehittop:
mov r3, height
sub r2, r3, 1
jmp snakegrow1

snakegrowleft:
load_32 r1, [r4] ;old x
add r3, r4, 4 ;old position y
load_32 r2, [r3]
sub r3, r1, 1 ;go left

cmp r3, r1
jmpif ab, snakehitleft
mov r1, r3
jmp snakegrow1

snakehitleft:
mov r3, width
sub r1, r3, 1
jmp snakegrow1

snakegrowdown:
load_32 r1, [r4] ;old x
add r3, r4, 4 ;old position y
load_32 r2, [r3]
add r2, r2, 1 ;go down
jmp snakegrow1

snakegrowright:
load_32 r1, [r4] ;old x
add r3, r4, 4 ;old position y
load_32 r2, [r3]
add r1, r1, 1 ;go right

snakegrow1:
cmp r1, width
jmpif lt, snakegrow2
sub r1, r1, width

snakegrow2:
cmp r2, height
jmpif lt, snakegrow3
sub r2, r2, height

snakegrow3:
sub snakelength, snakelength, 1 ;snake has not fully grown yet
push r1
call checkcollide
add snakelength, snakelength, 1 ;bring it back up
cmp r1, 0
jmpif neq, end ;end game if you hit yourself
pop r1

;save position
store_32 [addr], r1
add addr, addr, 4
store_32 [addr], r2

;check if ate fruit
load_32 r5, [fruit] ;x
add r3, fruit, 4
load_32 r6, [r3] ;y

cmp r1, r5 ;check x
jmpif neq, snakegrow4
cmp r2, r6 ;check y
jmpif neq, snakegrow4

; call new fruit if eaten
mov r1, 1
store_32 [atefruit], r1 ;set ate fruit for this loop
call newfruit

snakegrow4:

pop addr
pop r4
pop r3
pop r2
pop r1
ret

;kill the last body part
shrinksnake:
add snakeend, snakeend, 1
sub snakelength, snakelength, 1
cmp snakeend, pixels ;max size of snake
jmpif lt, doneshrink
sub snakeend, snakeend, pixels 
doneshrink:
ret

newfruit:
push r1
push r2
push addr

fruitloop:
call randpos
push r1
call checkcollide
cmp r1, 0
jmpif neq, fruitloop;repeat until safe position found

;save position
pop r1
mov addr, fruit
store_32 [addr], r1
add addr, addr, 4
store_32 [addr], r2

pop addr
pop r2
pop r1
ret


;check if the position in r1, r2 collides with snake
;return 1 in r1 if true, 0 otherwise
checkcollide:
push r2
push r3
push r4 ;index
push addr
;for pos in snake list
;return 1 if equal
;false at end of list

mov r4, 0
collideloop:
cmp r4, snakelength
jmpif gte, collidedone

push r1
mov r1, r4
call getsnakeaddress
mov addr, r1
pop r1

load_32 r3, [addr]
cmp r1, r3 ;check x
jmpif neq, collide1

add addr, addr, 4
load_32 r3, [addr]
cmp r2, r3 ;check y
jmpif neq, collide1

;early return
mov r1, 1
jmp collidedone1

collide1:
add r4, r4, 1
jmp collideloop

collidedone:
mov r1, 0
collidedone1:

pop addr
pop r4
pop r3
pop r2
ret


;get an address from the index into snake list
;r1 is index
;returns into r1
getsnakeaddress:
push addr
push r2
mov r2, r1

;get address
;check if need to loop back to start of array
add addr, r2, snakeend ;index plus list start
lsl addr, addr, 3 ;8x index
add addr, addr, snake

;check if need to loop
add r1, snake, snakeobjsize ;get end of array address
cmp addr, r1
jmpif lt, snakeaddress1
;need to loop
sub addr, addr, r1 ;get distance past
add addr, addr, snake ;index into array

snakeaddress1:

mov r1, addr
pop r2
pop addr
ret









