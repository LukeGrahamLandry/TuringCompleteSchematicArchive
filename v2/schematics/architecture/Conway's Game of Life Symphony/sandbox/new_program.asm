const board0 = 1000 ; adr of board 0, can be increased if required
const board1 = 65535 ; adr of board 1, can be increased if required (currently max 16bit)
; boards switch role after each iteration
; board 0 starts as the prevstate, which is rendered on the screen
; board 1 starts as nextstate, which uses prevstate to simulate the next iteration

; CHANGE THESE IF YOU WANT TO CHANGE RESOLUTION
const width = 128 ; ASPECT RATIO MUST BE 4:3
const height = 96 ; ASPECT RATIO MUST BE 4:3

const dead = 0x00 ; const for black pixel
const alive = 0xff ; const for white pixel

const temp0 = r13 ; temp register 0 
const temp1 = r12 ; temp register 1

const pspointer = r11 ; prevstate pointer - address of prev board, rendered on screen
const nspointer = r10 ; nextstate pointer - address of current working board
const cpointer = r9 ; cell pointer (prevstate)
const nscpointer = r8; cell pointer (nextstate)
const npointer = r7 ; neighbor pointer

const ncounter = r6 ; neighbor counter

const x = r2 ; counter for x in loop
const y = r1 ; counter for y in loop


; INIT BOARD (BOARD 0, WHICH STARTS AS PREVSTATE)
mov pspointer, board0
mov nspointer, board1
call setscreenoffset ; SCREEN OFFSET

; SET INITIAL CELLS
; Just put coordinate on x and y register and then call drawcell
; 0, 0 coordinate is top left
; I recommend putting breakpoint at main label to check if cells are placed correctly
; This example makes the R-pentomino

mov x, 64
mov y, 47
call drawcell
mov y, 48
call drawcell
mov y, 49
call drawcell
mov x, 65
call drawcell
mov x, 63
mov y, 48
call drawcell

; SET SCREEN SETTINGS
screen zr, 2 ; PIXEL 8

const res = temp0
const setting = temp1

mov res, height
mov setting, 2

div res, res, 3
sub res, res, 1

screen setting, res ; RESOLUTION

; MAIN LOOP
main:
mov y, 0
yloop:
	mov x, 0	
	xloop:		
		mul temp0, y, width
		add temp0, temp0, x ; n = x + y * width
		
		add cpointer, temp0, pspointer ; cell pointer = n + prevstate addr
		add nscpointer, temp0, nspointer ; next state cell pointer = n + nextstate addr
		
		mov ncounter, 0 ; reset ncounter to 0	
		call checkleft
		call checkright
		call checktop
		call checktopleft
		call checktopright
		call checkbot
		call checkbotleft
		call checkbotright ; count neighbors
		
		load_8 temp0, [cpointer] ; temp = cellstate of current cell
		cmp temp0, alive
		je ifcellalive ; goto ifcellalive if cell alive
		; else
			cmp ncounter, 3
			je birthcell ; if ncounter == 3 birth cell
			jmp killcell ; else kill cell
		
		ifcellalive:	
			cmp ncounter, 2
			je birthcell ; if ncounter == 2 do birth cell
			
			cmp ncounter, 3
			je birthcell ; if ncounter == 3 do birth cell
			; else kill cell
			
		killcell:
			mov temp0, dead
			store_8 [nscpointer], temp0 ; nextstate cell = dead
			jmp endxloop
		
		
		birthcell:
			mov temp0, alive
			store_8 [nscpointer], temp0 ; nextstate cell = alive
		
		endxloop:
			add x, x, 1 ; x++
			cmp x, width
			jb xloop ; continue X loop if X < HEIGHT
			
	add y, y, 1 ; y++
	cmp y, height
	jb yloop ; continue Y loop if Y < HEIGHT
	
; LOOP END
; SWITCH BOARD ROLES
mov temp0, pspointer
mov pspointer, nspointer
mov nspointer, temp0
call setscreenoffset ; make screen render new state
jmp main ; go back to main loop
	
checkleft:
sub npointer, cpointer, 1 ; sub 1 from cell position
load_8 temp0, [npointer] ; temp = state of left cell
cmp temp0, alive 
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checkright:
add npointer, cpointer, 1 ; add 1 to cell position
load_8 temp0, [npointer] ; temp = state of right cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checktop:
sub npointer, cpointer, width ; sub width from cell position
load_8 temp0, [npointer] ; temp = state of top cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checkbot:
add npointer, cpointer, width ; add width to cell position
load_8 temp0, [npointer] ; temp = state of top cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checktopright:
sub npointer, cpointer, width ; sub width from cell position
add npointer, npointer, 1 ; add 1 to cell position
load_8 temp0, [npointer] ; temp = state of topright cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checktopleft:
sub npointer, cpointer, width ; sub width from cell position
sub npointer, npointer, 1 ; sub 1 from cell position
load_8 temp0, [npointer] ; temp = state of topleft cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checkbotright:
add npointer, cpointer, width ; add width to cell position
add npointer, npointer, 1 ; add 1 to cell position
load_8 temp0, [npointer] ; temp = state of botright cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

checkbotleft:
add npointer, cpointer, width ; add width to cell position
sub npointer, npointer, 1 ; sub 1 from cell position
load_8 temp0, [npointer] ; temp = state of botleft cell
cmp temp0, alive
je hasneighbor ; if cellstate = alive, add one to ncounter, else return
ret

hasneighbor: 
add ncounter, ncounter, 1
ret	
	
setscreenoffset:
mov temp0, 1
screen temp0, pspointer ; DATA OFFSET
ret

drawcell:
mul temp0, y, width
add temp0, temp0, x ; n = x + y * width
add temp0, temp0, pspointer ; cell pointer = n + prevstate addr
mov temp1, alive
store_8 [temp0], temp1
ret