;should run at 1.2mhz for steady 60FPS

;=========== GPU constants ================

const GPU_CHARMAP 			= 674408
const GPU_TILEMAP1_X 		= 674400
const GPU_TILEMAP2_X 		= 674404
const GPU_TILEMAP1			= 614400

const LEVEL1				= 614400
const LEVEL2				= 2722408
const LEVEL3				= 2752408

const GPU_SCREEN_1			= 0
const GPU_SCREEN_2			= 307200

const GPU_DRAWTICKS			= 9600
const GPU_FRAMETICKS		= 19971;20000

const SCREEN_PIXEL32		= 3
const SCREEN_MODE_RES   	= 2
const SCREEN_RES_320_240 	= 79

const TILE_SOLID			= 100
const TILE_FLOOR			= 200

;=========== RAM constants ================

const charX				= 60000
const charY				= 60004
const anim				= 60008
const side				= 60012
const velX				= 60016
const velY				= 60020
const onFloor			= 60024
const key_left			= 60028
const key_right			= 60032
const key_jump			= 60036
const key_punch			= 60040
const punching			= 60044
const rePunchTime		= 60048
const accelX			= 60052
const punchSide			= 60056
const punchTime			= 60064
const frameTime			= 60068
const frame				= 60072
const framePosX			= 60076
const framePosY			= 60080
const frameLen			= 60084
const frameCount		= 60088
const blink				= 60092
const dead				= 60096
const decelTime			= 60100
const decelLen			= 60104
const accelTime			= 60108
const accelLen			= 60112
const screenLoc			= 60116
const movX				= 60120
const movY				= 60124
const levelLength		= 60128
const gravLen			= 60132
const gravTime			= 60136
const jumpHold			= 60144
const jumpHoldTime		= 60148
const key_jump_press	= 60152
const key_punch_press	= 60156
const loopCount			= 60160
const key_enter			= 60164
const finishLine		= 60168
const levelTilemap		= 60172
const level				= 60176

;============ enemies  =================
;obj size is 100

const objType			= 61000
const objX				= 61004
const objY				= 61008
const objSide			= 61012
const objDead			= 61020
const objDying			= 61024
const objVelX			= 61028
const objVelY			= 61032
const objWalkSpeed		= 61036
const objData			= 61040
const objCnt			= 61044
const objObjRef			= 61048
const objDataCnt		= 61052
const objStartY			= 61056

;============ objRef ===================

const objRef			= 62000 ;start of obj references

;=========== constants ================

const ENEMY_COUNT		= 10
const ENEMY_SIZE		= 100

const KEY_RIGHT			= 51
const KEY_LEFT			= 49
const KEY_JUMP			= 83
const KEY_PUNCH			= 64
const KEY_ENTER			= 60

const init_levelLength	= 4096
const init_charX		= 48
const init_charY		= 160
const init_gravLen 		= 2

const airSpeed 			= 1
const topSpeed 			= 5
const topRunAnimTime 	= 3

const jumpStr 			= 6
const jumpRelSpeed 		= 4
const jumpHoldMax 		= 7

const timeBetweenPunches= 20

const accelLenFloor 	= 5
const accelLenAir 		= 4
const decelLenFloor 	= 4

const char_sizeL		= 4
const char_sizeR		= 23
const char_sizeU		= 0
const char_sizeD		= 31

const BLACK_SCREEN_ADDR	= 3000000

;======== DEBUG ================
const debug_showDrawing = 0 	;set to 1 to see screen as it's being drawn
const startingLevel		= 1

;======== init screen =========

screen zr, SCREEN_PIXEL32 		;set mode to pixel32
mov r1, SCREEN_MODE_RES
screen r1, SCREEN_RES_320_240 	;set resolution to 320x240

;==============================

store_32 [level], startingLevel

;======= init =================
init:

	load_32 r1, [level]
	cmp r1, 1
	jne notLevel1
		mov32 r1, LEVEL1
		ja  endPickLevelTilemap
	notLevel1:
	cmp r1, 2
	jne notLevel2
		mov32 r1, LEVEL2
		ja  endPickLevelTilemap
	notLevel2:
	cmp r1, 3
	jne notLevel3
		mov32 r1, LEVEL3
		ja  endPickLevelTilemap
	notLevel3:
	endPickLevelTilemap:

	store_32 [levelTilemap], r1

	mov32 r1, 10000000
	store_32 [finishLine], r1
	store_32 [screenLoc], 0
	store_32 [onFloor], 1
	store_32 [levelLength], init_levelLength
	store_32 [charX], 100
	store_32 [charY], 384
	store_32 [accelLen], accelLenFloor
	store_32 [gravLen], init_gravLen
	store_32 [dead], 0
	store_32 [velX], 0
	store_32 [velY], 0
	store_32 [jumpHold], 0
	store_32 [jumpHoldTime], 0

	call clearEnemies
	call init_enemies
	call loadObjRefs
	call spawn_initEnemies
	
;==================================
;		Main Loop
;==================================

mainLoop:
	call draw
	call waitForVSync
	call drawSprites
	call gameLoop
	call waitForNextFrame
jmp mainLoop

;==================================
;		Game Loop
;==================================

gameLoop:
	load_32 r1,	[loopCount]
	inc r1
	store_32 [loopCount], r1 ;inc loopCount

    call processInputs
    call movement
    call state
    call spawnEnemies
    call despawnEnemies
    call updateObjects
    call physics
ret

;==================================
;		Despawn Enemies
;==================================

despawnEnemies:
	mov r13, 0
	loopDespawn:
		
		mul r2, r13, ENEMY_SIZE
		add r1, r2, objType
		load_32 r1, [r1] ;get objType
		
		cmp r1, 0
		je nextDespawn						;skip if not active
		
		add r1, r2, objX
		load_32 r3, [r1]					;r3 = objX
		
		load_32 r4, [screenLoc]				;r4 = screenLoc
		add r5, r4, 896						;r5 = farEdge
		sub r4, r4, 256
		
		cmp r3, r4
		jl despawn
		cmp r3, r5
		jl nextDespawn
		despawn:
			add r1, r2, objObjRef
			load_32 r1, [r1]
			mul r1, r1, 4
			add r1, r1, objRef
			
			store_8 [r1], zr
			add r1, r2, objType
			store_32 [r1], zr
	nextDespawn:
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopDespawn
ret


;==================================
;		Spawn Enemies
;==================================

spawnEnemies:

	load_32 r1, [velX]
	sng r1, r1
	cmp r1, 1
	je checkSpawnsLeft
		load_32 r2, [screenLoc]
		add r2, r2, 640
		div r2, r2, 32
		mul r1, r2, 4
		add r1, r1, objRef
		mov r9, r1
		
		load_8 r10, [r1]
		inc r1
		load_8 r4, [r1]
		inc r1
		load_8 r3, [r1]
		inc r1
		load_8 r1, [r1]
		
		cmp r10, 1
		je checkSpawnEnd
		cmp r1, 0
		je checkSpawnEnd
		
		mov r8, 1
		store_8 [r9], r8
		
		;|r1 = type
		;|r2 = tileX
		;|r3 = tileY
		;|r4 = side
		call spawnEnemy
	checkSpawnsLeft:
		load_32 r2, [screenLoc]
		;add r2, r2, 640
		div r2, r2, 32
		
		cmp r2, 0
		je skipMin
			dec r2
		skipMin:
		
		mul r1, r2, 4
		add r1, r1, objRef
		mov r9, r1
		
		load_8 r10, [r1]
		inc r1
		load_8 r4, [r1]
		inc r1
		load_8 r3, [r1]
		inc r1
		load_8 r1, [r1]
		
		cmp r10, 1
		je checkSpawnEnd
		cmp r1, 0
		je checkSpawnEnd
		
		mov r8, 1
		store_8 [r9], r8
		
		;|r1 = type
		;|r2 = tileX
		;|r3 = tileY
		;|r4 = side
		call spawnEnemy
	checkSpawnEnd:
ret

;==================================
;		Spawn Init Enemies
;==================================

spawn_initEnemies:
;spawn the enemies on the inital screen

	mov r12, 0
	loopSpawnInitEnemies:
		mul	r13, r12, 4 
		add r13, r13, objRef 	;objRef addr
		
		load_32 r10, [r13]
		and r1, r10, 0xFF		;objType
		
		cmp r1, 0
		je skipInitEnemies
			lsr r10, r10, 8
			and r3, r10, 0x00FF		;objY
			and r4, r10, 0xFF00		;objSide
			lsr r4, r4, 8
			mov r2, r12
			
			mov r8, 1
			store_8 [r13], r8
			
			call spawnEnemy
		skipInitEnemies:
						
	inc r12
	cmp r12, 20
	jne loopSpawnInitEnemies
ret

clearEnemies:
	mov r12, 0
	loopClearEnemies:
		mul	r13, r12, 4 
		add r13, r13, objRef 	;objRef addr
		
		store_32 [r13], zr
						
	inc r12
	cmp r12, 500
	jne loopClearEnemies
ret

;==================================
;		Spawn Enemy
;==================================
spawnEnemy:
;|r1 = enemyType
;|r2 = tileX
;|r3 = tileY
;|r4 = side
	
	;If there's too many enemies one will be replaced..
	;   just dont spawn too many...
	
	push r1
	push r2
	push r3
	push r4
	
	mov r13, 0
	loopSpawnEnemy:
		
		mul r2, r13, ENEMY_SIZE
		add r1, r2, objType
		load_32 r1, [r1] ;get objType
		
		cmp r1, 0
		jne nextLoopSpawnEnemy
		jmp spawnEnemyFoundFree		;enemy ID is free
		
		
	nextLoopSpawnEnemy:
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopSpawnEnemy
	
	spawnEnemyFoundFree:
	
	pop r6
	pop r3
	pop r2
	pop r1
	
	mul r13, r13, ENEMY_SIZE	;r13 = objOffset
	
	mov r5, r2
	
	mul r2, r2, 32
	mul r3, r3, 32
	
	add r4, r13, objType
	store_32 [r4], r1
	
	add r4, r13, objX
	store_32 [r4], r2
	
	add r4, r13, objY
	store_32 [r4], r3
	
	add r4, r13, objStartY
	store_32 [r4], r3
	
	add r4, r13, objSide
	store_32 [r4], r6
	
	add r4, r13, objDead
	store_32 [r4], zr
	
	add r4, r13, objDying
	store_32 [r4], zr
	
	add r4, r13, objVelX
	store_32 [r4], zr
	
	add r4, r13, objVelY
	store_32 [r4], zr
	
	add r4, r13, objObjRef
	store_32 [r4], r5
	
	add r4, r13, objData
	store_32 [r4], zr
	
	add r4, r13, objDataCnt
	store_32 [r4], zr
	
ret

;==================================
;		Load Obj Refs
;==================================

loadObjRefs:
;r10 = levelID
	
	load_32 r10, [levelTilemap]

	mov r11, 0 ;X
	loopObjRefsX:
	
		mov r12, 0 ;Y
		loopObjRefsY:
		
			mul r2, r11, 4
			add r2, r2, objRef		;points to correct objRef
			
			mul r1, r12, 500
			add r1, r1, r11
			mul r1, r1, 4
			add r1, r1, r10			;get tile data addr
			
			gpu_addr r1
			gpu_read r1				;get tile data
			
			lsr r1, r1, 16			;get rid of tile ID
			
			cmp r1, 113				;beanieL
			jne noRefBeanieR
				mov r3, 1			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 1		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noRefBeanieR:
			cmp r1, 13
			jne noRefBeanieL
				mov r3, 0			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 1		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noRefBeanieL:
			
			cmp r1, 20
			jne noJumperR
				mov r3, 0			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 2		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noJumperR:
			cmp r1, 120
			jne noJumperL
				mov r3, 1			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 2		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noJumperL:
			
			cmp r1, 220
			jne noSpikeyR
				mov r3, 0			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 3		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noSpikeyR:
			cmp r1, 320
			jne noSpikeyL
				mov r3, 1			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 3		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noSpikeyL:
			
			cmp r1, 27
			jne noPoliceR
				mov r3, 0			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 4		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noPoliceR:
			cmp r1, 127
			jne noPoliceL
				mov r3, 1			;side
				lsl r3, r3, 8
				add r3, r3, r12		;Y
				lsl r3, r3, 8
				add r3, r3, 4		;type
				
				store_32 [r2], r3	;store objRef
				jmp nextObjRef
			noPoliceL:
			
			cmp r1, 400 ; levelEnd (for size)
			jne noLevelEnd
				mul r1, r11, 32
				add r1, r1, 32
				store_32 [levelLength], r1	
				jmp nextObjRef
			noLevelEnd:
			
			 cmp r1, 300
			 jne noFinishLine		 	
			 	mul r1, r11, 32
				add r1, r1, 32	 	
			 	store_32 [finishLine], r1
			 	jmp nextObjRef
			 noFinishLine:
			
		nextObjRef:
		inc r12
		cmp r12, 16
		jne loopObjRefsY
		
	inc r11
	cmp r11, 500
	jne loopObjRefsX
	
ret

;==================================
;		Update Objects
;==================================

updateObjects:
	mov r13, 0
	loopUpdateEnemies:
		
		mul r2, r13, ENEMY_SIZE
		add r1, r2, objType
		load_32 r1, [r1] ;get objType
		
		call updateObject
		
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopUpdateEnemies
ret

updateObject:
;| r1 objType
;| r2 objOffset
	
	cmp r1, 1
	je update_walker
	cmp r1, 2
	je update_jumper
	cmp r1, 3
	je update_spiker
	cmp r1, 4
	je update_police
ret

;--------------------------------------

update_walker:
;| r2 objOffset

	add r1, r2, objWalkSpeed
	mov r3, 1
	store_32 [r1], r3
	
	jmp update_walk
ret

update_spiker:
;| r2 objOffset

	add r1, r2, objWalkSpeed
	mov r3, 2
	store_32 [r1], r3
	
	jmp update_walk
ret

update_police:
;| r2 objOffset

	add r1, r2, objWalkSpeed
	mov r3, 3
	store_32 [r1], r3
	
	jmp update_walk
ret

update_walk:
;| r2 objOffset

	add r1, r2, objDying
	load_32 r1, [r1]
	cmp r1, 1
	je walkMoveEnd	; skip if dead
	
	add r1, r2, objSide
	load_32 r1, [r1]
	cmp r1, 1
	je walkMoveLeft
		;-----------
		add r1, r2, objWalkSpeed
		load_32 r1, [r1]
		
		add r4, r2, objX
		load_32 r3, [r4]
		
		add r1, r1, r3
		store_32 [r4], r1 ; add walkspeed to X
		jmp walkCheckFloorWall
	walkMoveLeft:
		;-----------
		add r1, r2, objWalkSpeed
		load_32 r1, [r1]
		
		add r4, r2, objX
		load_32 r3, [r4]
		
		sub r1, r3, r1
		store_32 [r4], r1 ; sub walkspeed to X	
	walkCheckFloorWall:	
		call enemyDetectFloor
		cmp r1, 0
		je walkMoveTurn
		;-----------
		call enemyDetectWall
		cmp r1, 1
		je walkMoveTurn
		;-----------
		jmp walkMoveEnd
	walkMoveTurn:
		add r1, r2, objSide
		load_32 r3, [r1]
		xor r3, r3, 1
		store_32 [r1], r3	;flip side
	walkMoveEnd:
ret

;--------------------------------------

update_jumper:
;| r2 objOffset

	add r1, r2, objDying
	load_32 r1, [r1]
		
	cmp r1, 1
	je jumperMoveEnd
	
	add r1, r2, objVelY
	load_32 r1, [r1]			;r1 = velY
	add r4, r2, objY
	load_32 r3, [r4]			;r3 = Y  r4= Yaddr
	
	add r3, r3, r1
	store_32 [r4], r3			;add velY to Y
		
	add r1, r2, objStartY
	load_32 r1, [r1]			;r1 = startY
	
	add r4, r2, objData
	load_32 r4, [r4]			;r1 = data
	
	cmp r3, r1
	jg jumperOnFloor
	cmp r4, 1
	je jumperOnFloor
		load_32 r1, [loopCount]
		and r1, r1, 3
		cmp r1, 0
		jne jumperMoveEnd
			;------ in air, apply gravity -----
			add r3, r2, objVelY				
			load_32 r1, [r3]			;r1 = velY
			inc r1
			store_32 [r3], r1			;inc velY
		jmp jumperMoveEnd
	jumperOnFloor:
		
		add r1, r2, objStartY
		load_32 r1, [r1]				;r1 = startY
		add r3, r2, objY
		store_32 [r3], r1				;objY = objStartY
		add r1, r2, objData
		load_32 r1, [r1]				;r1 = data
		
		cmp r1, 1
		je jumperAlreadyOnFloor
			add r1, r2, objData
			mov r3, 1
			store_32 [r1], r3			;objData = 1
			add r1, r2, objDataCnt
			store_32 [r1], zr			;objDataCnt = 0
			add r1, r2, objVelY
			store_32 [r1], zr			;objVelY = 0
		jumperAlreadyOnFloor:
			add r3, r2, objDataCnt
			load_32 r1, [r3]			;r1 = dataCnt
			inc r1
			store_32 [r3], r1			;inc datCnt
			cmp r1, 20
			jl jumperNotJump
				;jump !
				add r1, r2, objVelY
				mov32 r3, -6
				store_32 [r1], r3		;velY = -6
				add r1, r2, objData
				store_32 [r1], zr		;data = 0
			jumperNotJump:
	jumperMoveEnd:
ret

;==================================
;		Enemy Detect Floor
;==================================

enemyDetectFloor:
;| r2 objOffset
;| return:
;| r1 0/1 floor found
	
	add r1, r2, objX
	load_32 r1, [r1]
	add r1, r1, 16
	
	add r3, r2, objY
	load_32 r3, [r3]
	add r3, r3, 32
	
	push r2					;safekeep objOffset
	mov r2, r3
	
	call get_tile			;r5 = tileType
	
	pop r2					;recover objOffset
	
	cmp r5, TILE_SOLID
	je enFloor
	cmp r5, TILE_FLOOR
	je enFloor
		mov r1, 0			;no floor, return 0
		ret
	enFloor:
		mov r1, 1			;floor, return 1
ret

;==================================
;		Enemy Detect Wall
;==================================

enemyDetectWall:
;| r2 objOffset
;| return:
;| r1 0/1 floor found

	add r1, r2, objX
	load_32 r1, [r1]
	add r1, r1, 2
	
	add r3, r2, objSide
	load_32 r3, [r3]
	xor r3, r3, 1 			;flip side
	mul r3, r3, 28
	add r1, r1, r3			;add 28 to objX if facing right
	
	add r3, r2, objY
	load_32 r3, [r3]
	
	push r2					;safekeep objOffset
	mov r2, r3
	
	call get_tile			;r5 = tileType
	
	pop r2					;recover objOffset
	
	cmp r5, TILE_SOLID
	je enWall
		mov r1, 0
		ret
	enWall:
		mov r1, 1
ret
;==================================
;		Init Enemies
;==================================
init_enemies:
	mov r13, 0
	loopInitEnemies:
		
		mul r2, r13, ENEMY_SIZE
		add r1, r2, objType
		store_32 [r1], zr ;store 0 in objType to deactivate
		
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopInitEnemies
	
ret

;==================================
;		Process Inputs
;==================================

processInputs:

	keyboard r1
	
	cmp r1, 0
	je inputs_end
	
	and r2, r1, 0xFF00
	lsr r2, r2, 8
	and r1, r1, 0x00FF
	
	cmp r1, KEY_ENTER
	jne inputs_notEnter
		cmp r2, 1
		jne inputs_notEnter
		store_32 [key_enter], 1
	inputs_notEnter:
	
	cmp r1, KEY_RIGHT
	jne inputs_notRight
		store_32 [key_right], r2
	inputs_notRight:
	
	cmp r1, KEY_LEFT
	jne inputs_notLeft
		store_32 [key_left], r2
	inputs_notLeft:
	
	cmp r1, KEY_JUMP
	jne inputs_notJump
		load_32 r3, [key_jump]
		
		cmp r3, 1
		je noPressJump
			store_32 [key_jump_press], r2
		noPressJump:
		cmp r2, 0
		jne noPressJump2
			store_32 [key_jump_press], zr
		noPressJump2:
	
		store_32 [key_jump], r2
	inputs_notJump:
	
	cmp r1, KEY_PUNCH
	jne inputs_notPunch
		load_32 r3, [key_punch]
		
		cmp r3, 1
		je noPressPunch
			store_32 [key_punch_press], r2
		noPressPunch:
	
		store_32 [key_punch], r2
	inputs_notPunch:
	
	jmp processInputs ;process next input
	
	inputs_end:	
ret

;==================================
;		Movement
;==================================

movement:
	
	load_32 r1, [punching]
	cmp r1, 1 ; check if punching
	je move_punch
	
	load_32 r1, [rePunchTime]
	cmp r1, 0
	je stopRePunchTimer
		dec r1
		store_32 [rePunchTime], r1
	stopRePunchTimer:
	
	load_32 r1, [key_punch_press]
	cmp r1, 0
	je no_punch

	load_32 r1, [onFloor]
	cmp r1, 0
	je no_punch
	
	load_32 r1, [rePunchTime]
	cmp r1, 0
	jne no_punch
	
;--- start punch ----
	store_32 [key_punch_press], zr
	mov r1, 3
	call setAnim
	
	mov r1, 1
	store_32 [punching], r1 ; set punching to true
	store_32 [accelX], zr 	; accelX = 0
	store_32 [velX], zr 	; velX = 0
	;-------------------
	
	load_32 r1, [punchSide]
	xor r1, r1, 1
	store_32 [punchSide], r1
	
	store_32 [rePunchTime], timeBetweenPunches
	
	jmp move_punch

	no_punch:

;--- check dead
	
	load_32 r1, [dead]
	cmp r1, 0
	je notDead
		pop r1 ;clear stack cause we aren't returning
		jmp died
	notDead:
	
	call jump
	
;---- move right
	
	load_32 r1, [key_right]
	cmp r1, 0 
	je noRight
		
		load_32 r1, [key_left]
		cmp r1, 1
		je idle ; both dir pressed, idle
		
		load_32 r1, [onFloor]
		cmp r1, 0
		je noWalkRight
			store_32 [side], zr
			mov r1, 1
			call setAnim ;set walk anim
			
			load_32 r1, [velX]
			sng r1, r1
			cmp r1, 0
			je noTurnRight
				jmp idle
			noTurnRight:
				store_32 [accelX], 1
				ret
		noWalkRight:
			store_32 [accelX], airSpeed
			ret
	noRight:
;---- move left

	load_32 r1, [key_left]
	cmp r1, 0 
	je noLeft
		load_32 r1, [onFloor]
		cmp r1, 0
		je noWalkLeft
			store_32 [side], 1
			mov r1, 1
			call setAnim ;set walk anim
			
			load_32 r1, [velX]
			sng r2, r1
			
			cmp r1, 0
			je noTurnLeft
			cmp r2, 1
			je noTurnLeft
				jmp idle
			noTurnLeft:
				mov32 r1, -1
				store_32 [accelX], r1
				ret
		noWalkLeft:
			mov r1, airSpeed
			neg r1, r1
			store_32 [accelX], r1
			ret
	noLeft:
idle:
	
	;--- check if on floor ---
	load_32 r1, [onFloor]
	cmp r1, 1
	jne idle_air
	
	;--- idle on floor ---
	store_32 [accelX], zr
	load_32 r1, [velX]
	cmp r1, 0
	je noWalkAccel
	
	;--- floor slowdown check ---
	mov r1, decelTime
	mov r2, decelLen
	call countdown
	
	cmp r1, 0
	je endMove
		;--- floor slowdown ---
		
		load_32 r1, [velX] ;this line was missing from old code ???

		sng r2, r1
		mov r3, 1
		cmp r2, 0
		je posAccel
			neg r3, r3
		posAccel:
		sub r1, r1, r3
		store_32 [velX], r1 ;store reduced velX
		ret
		
	noWalkAccel:
	mov r1, 0
	call setAnim
endMove:
ret

idle_air:
	load_32 r2, [velX]
	sng r1, r2
	cmp r2, 0 ;check if no velX
	je noAirSlowdown
	
	cmp r1, 1
	je airNegVel
		mov32 r1, -1
		store_32 [accelX], r1
		jmp endAirSlowdown
	airNegVel:
		store_32 [accelX], 1
		jmp endAirSlowdown
	noAirSlowdown:
		store_32 [accelX], zr
	endAirSlowdown:
ret

jump:

	load_32 r1, [onFloor]
	cmp r1, 0
	je notOnFloor
	
	load_32 r1, [key_jump_press]
	cmp r1, 0
	je endJumpin
		jmp startJump
	endJumpin:
ret

startJump:
	store_32 [velY], jumpStr
	store_32 [onFloor], 0
	load_32 r1, [gravLen]
	store_32 [gravTime], r1
	store_32 [accelLen], accelLenAir
	store_32 [jumpHold], 1
	load_32 r1, [velX]
	cmp r1, 0
	je skipChangeSide
		sng r1, r1
		store_32 [side], r1
	skipChangeSide:
	
notOnFloor:
;--- set air anim ---
	mov r1, 2
	call setAnim

;--- jump holding ---

	;not sure this will work with ceilings ?
	load_32 r1, [velY]
	sng r1, r1
	cmp r1, 1
	je notJumpHolding
	
	load_32 r1, [key_jump]
	cmp r1, 0
	je notJumpHolding
	
		load_32 r1, [jumpHoldTime]
		cmp r1, jumpHoldMax
		jg notJumpHolding
		
			inc r1
			store_32 [jumpHoldTime], r1
			ret
	
;--- not holding ---
notJumpHolding:
	load_32 r1, [jumpHold]
	cmp r1, 0
	je falling
		stopJumpHolding:
		store_32 [jumpHold], zr
		store_32 [key_jump_press], zr
		store_32 [velY], jumpRelSpeed
		store_32 [jumpHoldTime], 0
		
;--- falling accel ---
falling:
	mov r1, gravTime
	mov r2, gravLen
	call countdown
	
	cmp r1, 0
	je skipGrav
		load_32 r1, [velY]
		dec r1
		store_32 [velY], r1
	skipGrav:
	
ret


died:
	
	store_32 [key_enter], 0
	call drawDeathScreen
	call endGameLoop
	call cleanEndScreen
		
	mov sp, 0 	;reset stack pointer
	jmp init 	;go back to init
	
;----------------------------

cleanEndScreen:
	call hideLevel
	
	mov r10, 449
	load_32 r11, [charX]
	load_32 r12, [charY]
	call drawSprite
	
	gpu_getScreenAddr r9
	
	sprite_screenAddr r9
	
	mov r5, 0
	mov r6, 0
	
	cleanScreenLoopY:
		mov r5, 0
		cleanScreenLoopX:
		
			mul r11, r5, 32
			mul r12, r6, 32
	
			mov r10, 449
			call drawSprite
	
		inc r5
		cmp r5, 20
		jne cleanScreenLoopX
	inc r6
	cmp r6, 15
	jne cleanScreenLoopY
ret

;----------------------------

hideLevel:
	;set screen addr to an empty part of the gpu to have a black background

	mov32 r1, BLACK_SCREEN_ADDR
	sprite_screenAddr r1	;make background black
	
	mov r13, 0
	
	loopHideLevel:
	
		mov r10, 449
		mul r11, r13, 32
		add r11, r11, 168
		mov r12, 172
	
		call drawSprite
	
	inc r13
	cmp r13, 10
	jne loopHideLevel

	mov32 r1, BLACK_SCREEN_ADDR
	mov r2, 1
	screen r2,r1
ret

;----------------------------

drawDeathScreen:
	call waitForNextFrame
	
	mov32 r1, BLACK_SCREEN_ADDR
	mov r2, 1
	screen r2,r1
	
	mov32 r1, BLACK_SCREEN_ADDR
	sprite_screenAddr r1	;make background black

	mov r10, 5				;dead player charID
	load_32 r1, [side]		;0=right 1=left
	mul r1, r1, 6
	add r10, r10, r1		;add 6 if facing left
	
	load_32 r11, [charX]
	load_32 r12, [charY]
	
	call drawSprite
	call drawPressEnter
ret

drawPressEnter:
	mov r10, 58	;start of text charID
	
	loopDrawPressEnter:
	
		sub r11, r10, 58
		mul r11, r11, 32
		add r11, r11, 168
		mov r12, 172
	
		call drawSprite
	
	inc r10
	add r11, r11, 32
	cmp r10, 68
	jne loopDrawPressEnter
ret

endGameLoop:

		call hideLevel
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
		call drawPressEnter
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
	mov r1, 10
	call waitForXFrames
	
	call processInputs
	load_32 r1, [key_enter]
	cmp r1, 1
	je endOfEndGameLoop
	
	jmp endGameLoop
	
	endOfEndGameLoop:
ret

drawWinScreen:
	call waitForNextFrame
	
	mov32 r1, BLACK_SCREEN_ADDR
	mov r2, 1
	screen r2,r1
	
	mov32 r1, BLACK_SCREEN_ADDR
	sprite_screenAddr r1	;make background black

	mov r10, 212			;dead player charID
	load_32 r1, [side]		;0=right 1=left
	mul r1, r1, 6
	add r10, r10, r1		;add 6 if facing left
	
	load_32 r11, [charX]
	load_32 r12, [charY]
	
	call drawSprite
	
	mov r10, 158
	mov r11, 248
	mov r12, 204
	;call drawSprite

	mov r10, 159
	mov r11, 280
	mov r12, 204
	;call drawSprite

	call drawPressEnter
ret

waitForXFrames:

	mul r1, r1, 20000
	div r1, r1, 4
	mov r2, 0
	loopWaitForXFrames:
		nop
		inc r2
	cmp r2, r1
	jl loopWaitForXFrames

ret

;----------------------------

move_punch:
	store_32 [velY], zr
	
	load_32 r1, [punchTime]
	cmp r1, 15
	jl noPunchFinish
		store_32 [punching], zr
		store_32 [punchTime], zr
	noPunchFinish:
	
	load_32 r1, [punchTime]
	inc r1
	store_32 [punchTime], r1; inc punchTime
ret

countdown:
;|r1 = counterTimeAddr
;|r2 = counterLenAddr
;|return r1 = 0/1 ?
	
	load_32 r3, [r1]
	load_32 r4, [r2]
	
	cmp r3, 0
	je count_done
		dec r3
		store_32 [r1], r3
		mov r1, 0
		ret
	count_done:
	store_32 [r1], r4
	mov r1, 1
ret	

;==================================
;		State
;==================================

state:
	;je+i 1 winPose state_win
	load_32 r1, [anim]
	cmp r1, 0
	je state_idle
	cmp r1, 1
	je state_walking
	cmp r1, 2
	je state_air
	cmp r1, 3
	je state_punch
	
ret

state_idle:
	store_32 [frameLen], 16
	store_32 [frameCount], 4
	store_32 [framePosY], 0
	store_32 [framePosX], 1
	
	call state_blinking
	call animate	
ret


abs:
;|r1 value
	cmp r1, 0
	jge positiveAbs
		neg r1, r1; make r1 positive
	positiveAbs:
ret

state_walking:
	load_32 r1, [velX]
	call abs
	mov r2, topSpeed
	add r2, r2, topRunAnimTime
	sub r1, r2, r1
	
	store_32 [frameLen], r1
	store_32 [frameCount], 6
	store_32 [framePosX], 1
	store_32 [framePosY], 1
	
	call animate
ret

state_blinking:
	load_32 r1, [frame]
	cmp r1, 2
	jne skipNoBlink
		load_32 r1, [frameTime]
		cmp r1, 0
		jne skipNoBlink
			load_32 r1, [blink]
			cmp r1, 0
			jne skipBlink
				store_32 [blink], 2
				store_32 [frameTime], 6
				store_32 [frame], 3
				jmp skipNoBlink
			skipBlink:
				dec r1
				store_32 [blink], r1
				load_32 r1, [frameLen] 
				store_32 [frameTime], r1
				store_32 [frame], zr
	skipNoBlink:
ret

state_air:
	store_32 [frameLen], 1
	store_32 [frameCount], 1
	store_32 [framePosY], 2
	
	load_32 r1, [velY]
	sng r1,r1
	cmp r1, 0
	je setRiseAnim
		store_32 [framePosX], 2
		jmp endJumpAnim
	setRiseAnim:
		store_32 [framePosX], 1
	endJumpAnim:
	
	call animate
ret

state_punch:
	store_32 [frameLen], 8
	store_32 [frameCount], 2
	store_32 [framePosY], 4
	store_32 [framePosX], 1
	
	load_32 r1, [punchSide]
	cmp r1, 0
	je noPunchHook
		store_32 [framePosX], 3
	noPunchHook:
	
	call animate
ret
;==================================
;		Animate
;==================================
animate:
	load_32 r1, [frameTime]
	cmp r1, 0
	
	jne skipFrame
		load_32 r1, [frame]
		inc r1
		store_32 [frame], r1
		load_32 r2, [frameCount]
		cmp r1,r2
		jl skipReset
			store_32 [frame], zr
		skipReset:
		
		load_32 r1, [frameLen]
		store_32 [frameTime], r1
		
	skipFrame:
	
	load_32 r1, [frameTime]
	dec r1
	store_32 [frameTime], r1
ret

;==================================
;		Set Anim
;==================================
;|r1 animID

setAnim:
	push r2
	load_32 r2, [anim]
	cmp r2,r1
	je skipSetAnim
		store_32 [anim], r1
		store_32 [frameTime], zr
		
		mov32 r1, -1
		store_32 [frame], r1
	skipSetAnim:
	pop r2
ret

;=================================
;		Collision Detection
;=================================

detectCollisions:

	load_32 r1, [velX]
	load_32 r2, [velY]
	store_32 [movX], r1
	store_32 [movY], r2
	
	call col
	;---------------------

	load_32 r2, [velX]
	sng r1, r2
	cmp r1, 1
	je noRvel
	cmp r2, 0
	je noRvel
		call col_right
	noRvel:
	
	;---------------------

	load_32 r2, [velX]
	sng r1, r2
	cmp r1, 0
	je noLvel
		call col_left
	noLvel:
	
	;---------------------
	
	load_32 r2, [velY]
	sng r1, r2
	cmp r1, 0
	je noDvel
	cmp r2, 0
	je noDvel
		call col_down
	noDvel:
	
	;---------------------
	
	load_32 r2, [velY]
	sng r1, r2
	cmp r1, 1
	je noUvel
	cmp r2, 0
	je noUvel
		call col_up
	noUvel:
ret

col:
;|returns:
;|r10 = worldLocX (top left corner)
;|r11 = worldLocY (top right corner)
	load_32 r1, [charX]
	load_32 r2, [screenLoc]
	add r10, r1, r2			;r1 = worldLocX
	load_32 r11, [charY]
ret

col_right:
	;============ Check Collision On Right/Down corner =========
	add r1, r10, char_sizeR		;worldLocX + width
	mov r8, r1					;safeKeep in r8
	load_32 r3, [velX]
	add r1, r1, r3				;add velX
	add r2, r11, char_sizeD		;r9 = worldLocY + height
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colRight
	;============ Check Collision On Right/Up corner =========
	load_32 r3, [velX]
	add r1, r8, r3				;add velX
	add r2, r11, char_sizeU		;add height
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colRight
	ret
	;===================== col detected ======================
	colRight:
	dec r6					;tileWorldX-1
	sub r3, r6, r8			;tileWorldX-1 - 
	store_32 [movX], r3		;get blocked
	store_32 [velX], zr		;remove velocity
	store_32 [accelX], zr	;remove accelX ?
ret

col_left:
	;============ Check Collision On Left/Down corner =========
	add r1, r10, char_sizeL		;worldLocX + width
	mov r8, r1					;safeKeep in r8
	load_32 r3, [velX]
	add r1, r1, r3				;add velX
	add r2, r11, char_sizeD		;r9 = worldLocY + height
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colLeft
	;============ Check Collision On Left/Up corner =========
	load_32 r3, [velX]
	add r1, r8, r3				;add velX
	add r2, r11, char_sizeU		;add height
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colLeft
	ret
	;===================== col detected ======================
	colLeft:
	add r6, r6, 32			;tileWorldX-1
	sub r3, r6, r8			;tileWorldX-1 - 
	store_32 [movX], r3		;get blocked
	store_32 [velX], zr		;remove velocity
	store_32 [accelX], zr	;remove accelX ?
ret

col_down:
	;============ Check Collision On Right/Down corner =========
	add r1, r10, char_sizeR		;worldLocX + width
	add r2, r11, char_sizeD		;worldLocY + height
	load_32 r3, [velY]
	sub r2, r2, r3				;add velY
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colDown
	cmp r5, TILE_FLOOR
	je colDown
	;============ Check Collision On Left/Down corner =========
	add r1, r10, char_sizeL		;worldLocX + width
	add r2, r11, char_sizeD		;worldLocY + height
	load_32 r3, [velY]
	sub r2, r2, r3				;add velY
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colDown
	cmp r5, TILE_FLOOR
	je colDown
	;---------------------
	;no floor, start falling
	noColDown:
	store_32 [onFloor], zr
	ret
	;===================== col detected ======================
	colDown:
	dec r7						;tileWorldY-1
	add r2, r11, char_sizeD		;worldLocY + height
	sub r3, r7, r2				;
	neg r3, r3
	
	sng r1, r3					;make sure you dont go up
	cmp r1, 1
	je doColDown
	cmp r3, 0
	je doColDown
		jmp noColDown
	doColDown:
	
	store_32 [movY], r3			;get blocked
	load_32 r3, [velY]
	store_32 [velY], zr			;remove velocity
	
	call landed
ret

col_up:
	;============ Check Collision On Right/Up corner =========
	add r1, r10, char_sizeR		;worldLocX + width
	add r2, r11, char_sizeU		;worldLocY + height
	load_32 r3, [velY]
	sub r2, r2, r3				;add velY
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colUp
	;============ Check Collision On Left/Up corner =========
	add r1, r10, char_sizeL		;worldLocX + width
	add r2, r11, char_sizeU		;worldLocY + height
	load_32 r3, [velY]
	sub r2, r2, r3				;add velY
	;---------------------
	call get_tile
	cmp r5, TILE_SOLID			;check if tile is solid
	je colUp
	;---------------------
	ret
	;===================== col detected ======================
	colUp:
	;inc r7						
	add r7, r7, 64				;? why 64 tho ?
	add r2, r11, char_sizeD		;worldLocY + height
	sub r3, r7, r2				;
	neg r3, r3
	
	store_32 [movY], r3			;get blocked
	load_32 r3, [velY]
	store_32 [velY], zr			;remove velocity
	store_32 [jumpHold], zr		;stop jump holding
	store_32 [key_jump_press], zr	;zero jump press
ret

pitDetection:
	load_32 r1, [charY]
	
	sng r4, r1
	cmp r4, 1
	je notFell
	
	div r1, r1, 32 			;get charTileY
	
	cmp r1, 14
	jle notFell
	
	store_32 [velX], 0
	store_32 [velY], 0
	store_32 [charY], 449
	store_32 [dead], 1
	
	notFell:
ret

landed:
	load_32 r1, [onFloor]
	cmp r1, 1
	je endLanded
		store_32 [onFloor], 1
		store_32 [velY], 0
		store_32 [accelTime], 0
		store_32 [jumpHoldTime], 0
		load_32 r1, [accelLen]
		store_32 [accelLenFloor], r1
	endLanded:
ret

;==================================
;		Get Tile
;==================================

get_tile:
;| r1 X in world coords
;| r2 Y in world coords
;| return:
;| r5 = tileType
;| r6 = tileX
;| r7 = tileY
	
	div r1, r1, 32
	div r2, r2, 32
	
	mul r6, r1, 32		;return tileWorldX
	mul r7, r2, 32		;return tileWorldY
	
	mul r2, r2, 500		;mul tileY by 500
	add r2, r2, r1		;add tileX
	mul r2, r2, 4		;mul by 4 because its 32bits
	
	load_32 r1, [levelTilemap]
	add r2, r2, r1		;add tileMap1 addr
	
	gpu_addr r2
	gpu_read r1
	
	lsr r5, r1, 16		;only keep the highest 16bits
ret

;==================================
;		Obj Col Detection
;==================================

objColDetection:
	mov r13, 0
	loopColEnemies:
		mul r2, r13, ENEMY_SIZE
		call colEnemy
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopColEnemies
ret

colEnemy:
;|r2 objOffset
	;------- skip if dead or dying  or deactivated ------
	add r1, r2, objType
	load_32 r1, [r1]
	cmp r1, 0
	je skipObjCol
	
	add r1, r2, objDying
	load_32 r1, [r1]
	cmp r1, 1
	je skipObjCol
	
	add r1, r2, objDead
	load_32 r1, [r1]
	cmp r1, 1
	je skipObjCol
	;-----------------------
	
	load_32 r1, [charX]
	load_32 r3, [screenLoc]
	add r1, r1, r3					;r1 = charX world loc
	load_32 r3, [movX]
	add r1, r1, r3					;r1 = charX world loc + movX
	;-----------------------
	
	load_32 r3, [punching]
	cmp r3, 0
	je noColDetectPunch
		mov r3, 20	
		load_32 r4, [side]
		cmp r4, 0
		je noColPunchRight
			neg r3, r3
		noColPunchRight:
		add r1, r1, r3				;move char forward when punching
	noColDetectPunch:
	
	;-----------------------
	
	load_32 r3, [charY]
	load_32 r4, [movY]
	sub r3, r3, r4					;r3 = charY world loc - movY
	
	;-----------------------
	
	;add r1, r1, 16					;get middle X 
	add r3, r3, 16					;get middle Y
	
	add r4, r2, objX
	load_32 r4, [r4]
	add r5, r2, objY
	load_32 r5, [r5]
	
	sub r1, r4, r1					;get diffX
	sub r3, r5, r3					;get diffY
	
	call abs
	mov r4, r1						;r4 = abs(diffX)
	mov r1, r3
	call abs
	mov r5, r1						;r5 = abs(diffY)
	
	mul r1, r4, r4					;pow2 X
	mul r3, r5, r5					;pow2 Y
	
	add r1, r1, r3					;pythagoras
	
	cmp r1, 500
	jg skipObjCol
	
		load_32 r1, [charY]
		add r1, r1, 16				;get bottom char Y
		
		add r3, r2, objY
		load_32 r3, [r3]
		sub r3, r3, 10				;get top of obj
		
		cmp r1, r3
		jg getHurt
		
		add r3, r2, objType
		load_32 r3, [r3]
		cmp r3, 3
		je getHurt					;if enemy is spiker, no stump
		
		stomp:
			push r2					;safekeep ObjOff
			call startJump
			pop r2					;pullback objOff
			store_32 [movY], 8
		enemyGetHurt:					
			add r1, r2, objDying
			mov r3, 1
			store_32 [r1], r3		;enemy dies
		jmp skipObjCol
			
		getHurt:
		load_32 r1, [punching]
		cmp r1, 1
		jne noPunched
			add r1, r2, objType
			load_32 r1, [r1]	
			cmp r1, 4
			jne notPolice			;check if police
				add r1, r2, objData
				mov r3, 1
				store_32 [r1], r3	;store objData
				mov32 r3, -2
				load_32 r1, [side]
				cmp r1, 0			;check side
				je skipSidePolicePushback
					mov r3, 2
				skipSidePolicePushback:
				store_32 [velX], r3	;push back player after punch
				jmp skipObjCol
			notPolice:
				mov32 r3, -1
				load_32 r1, [side]
				cmp r1, 0			;check side
				je skipSidePushback
					mov r3, 1
				skipSidePushback:
				store_32 [velX], r3	;push back player after punch
				jmp enemyGetHurt
	noPunched:		
	pop r1
	pop r1
	pop r1							;pull return addresses
	jmp died
	skipObjCol:
ret

;==================================
;		Win
;==================================

win:
	store_32 [key_enter], 0
	call drawWinScreen
	call endGameLoop
	call cleanEndScreen
	
	load_32 r1, [level]
	inc r1
	cmp r1, 3
	jl notLastLevel
		mov r1, 1
	notLastLevel:
	store_32 [level], r1
	
	mov sp, 0 	;reset stack pointer
	jmp init 	;go back to init
ret

;==================================
;		Physics
;==================================

physics:
	call pitDetection
	call detectCollisions
	call objColDetection
	
;--- accelX ---
	mov r1, accelTime
	mov r2, accelLen
	call countdown
	
	cmp r1, 0
	je skipAccelX

	load_32 r1, [velX]
	load_32 r2, [accelX]
	
	add r1, r1, r2
	sng r3, r1 ;get the sign of velX in r3
	call abs
	
	cmp r1, topSpeed
	jle accelXContinue
		mov r1, topSpeed
	accelXContinue:
	
	cmp r3, 0
	je accelNotNeg
		neg r1, r1 ; give velX it's sign back
	accelNotNeg:
	
	store_32 [velX], r1 ; store new velX
		
	skipAccelX:
	
; --- gravity ---

	load_32 r4, [onFloor]
	cmp r4, 1
	jne skipGravity
		mov32 r4, -1
		store_32 [velY], r4
	skipGravity:
	
	load_32 r1, [charY]
	load_32 r2, [movY]
	sub r2, r1, r2
	
	store_32 [charY], r2
	
; ----- finish line test -----

	load_32 r1, [charX]
	load_32 r2, [finishLine]
	load_32 r3, [screenLoc]
	
	add r1, r1, r3
	
	cmp r1, r2
	jl notWon
		call win
	notWon:

; --- add velX to charX or Screen ---

	load_32 r2, [movX]
	load_32 r1, [charX]
	load_32 r3, [screenLoc]
	load_32 r4, [levelLength]
	
	sng r5, r2 ;put the sign of movX in r5
	cmp r5, 1
	je screenLeft
		sub r5, r4, 640
		cmp r3, r5; compare screenLoc and screenLoc-640
		jge moveChar
		cmp r1, 320
		jg moveScreen
		jmp moveChar
	screenLeft:
		cmp r3, 0
		je moveChar
		cmp r1, 320
		jl moveScreen
		
	moveChar:
		add r1, r1, r2
		sng r5, r1
		cmp r5, 0
		je boundChar
			mov r1, 0
		boundChar:
		cmp r1, 608
		jle boundChar2
			mov r1, 608
		boundChar2:
		
		store_32 [charX], r1
		ret
	
	moveScreen:
		load_32 r1, [screenLoc]
		add r1, r1, r2 ;add movX to screenLoc
		
		sng r5, r1
		cmp r5, 0
		je boundSc
			mov r1, 0
		boundSc:
		sub r5, r4, 640
		cmp r1, r5
		jle boundSc2
			mov r5, r1
		boundSc2:
		
		store_32 [screenLoc], r1
ret

;==================================
;		Draw Sprites
;==================================

drawSprites:

	gpu_getScreenAddr r1
	sprite_screenAddr r1	;draw the sprites on current screen buffer

	mov r13, 0
	loopDrawEnemies:
		
		mul r2, r13, ENEMY_SIZE
		add r1, r2, objType
		load_32 r1, [r1] ;get objType
		
		cmp r1, 0
		je nextLoopDrawEnemies
		cmp r1, 1
		je draw_walker
		cmp r1, 2
		je draw_jumper
		cmp r1, 3
		je draw_spiker
		cmp r1, 4
		je draw_police
		
	nextLoopDrawEnemies:
	inc r13
	cmp r13, ENEMY_COUNT
	jne loopDrawEnemies
	
	call drawPlayerSprite ; draw player at the end so he's over the enemies ?
ret

draw_walker:
;| r2 = obj_i * ENEMY_SIZE
	mov r10, 13 ;move starting enemy charID
	
	call draw_walk
	
	cmp r10, 0
	je nextLoopDrawEnemies
	
	lsl r11, r11, 1 ;gotta lsl them because draw_sprite did lsr
	lsl r12, r12, 1
	sub r12, r12, 32 ;sub 32 so the beanie is above
	
	sub r10, r10, 13
	cmp r10, 100
	jl beanieFaceRight
		sub r10, r10, 100
	beanieFaceRight:
	;r10 now 0 to 7
	mod r10, r10, 3
	and r10, r10, 1
	
	add r10, r10, 411
	
	call drawSprite ; draw beanie
	
jmp nextLoopDrawEnemies

draw_jumper:
;| r2 = obj_i * ENEMY_SIZE

	mov r10, 20 ;starting charID

	add r1, r2, objDying
	load_32 r1, [r1]

	cmp r1, 1
	je jumperIsDying

			add r1, r2, objVelY
			load_32 r1, [r1]

			add r3, r2, objData
			load_32 r3, [r3]

			sng r1, r1
			cmp r3, 1
			je jumperIdle
			cmp r1, 1
			je jumperNotFalling
				add r10, r10, 2
				jmp jumperFallingEnd
			jumperNotFalling:
				add r10, r10, 1
				jmp jumperFallingEnd
			jumperIdle:
				add r1, r2, objDataCnt
				load_32 r1, [r1]
				cmp r1, 10
				jg jumperFallingEnd
					add r10, r10, 3
			jumperFallingEnd:

	jmp jumperNotDying
	jumperIsDying:
		call draw_dying
	jumperNotDying:

	call draw_flip
	call draw_sendGPU

jmp nextLoopDrawEnemies

draw_spiker:
;| r2 = obj_i * ENEMY_SIZE

	mov r10, 220
	call draw_walk

jmp nextLoopDrawEnemies

draw_police:
;| r2 = obj_i * ENEMY_SIZE

	mov r10, 27
	call draw_walk
jmp nextLoopDrawEnemies

;------- reused for many enemies -----
draw_walk:
;| r2 = obj_i * ENEMY_SIZE
;| r10 = starting enemy charID

	add r1, r2, objDying
	load_32 r1, [r1]
	cmp r1, 1 ;check if dying
	je walkerIsDying
		load_32 r3, [loopCount]
		
		mov r5, 4
		add r4, r2, objWalkSpeed
		load_32 r4, [r4]
		sub r4, r5, r4
		
		lsr r1, r3, r4
		mod r1, r1, 6
		add r10, r1, r10 ;add starting enemy charID
		jmp walkerNotDying
	walkerIsDying:
		call draw_dying
	walkerNotDying:

	call draw_flip
	call draw_sendGPU

ret

draw_flip:
;| r2 = obj_i * ENEMY_SIZE
;| r10 = charID
	cmp r10, 0	;if flashing dont flip
	je skipObjFlip

	add r1, r2, objSide
	load_32 r1, [r1]
	cmp r1, 0
	je skipObjFlip
		add r10, r10, 100 ;add 100 to charID to flip it
	skipObjFlip:
ret

draw_dying:
;| r2 = obj_i * ENEMY_SIZE
;| r10 = starting enemy charID

	add r10, r10, 6				;set frame as "dying"
	add r1, r2, objCnt
	load_32 r3, [r1]
	inc r3
	store_32 [r1],r3 			;store inc objCnt
	cmp r3, 20
	jl objNotDeadYet
		add r1, r2, objDead
		mov r4, 1
		store_32 [r1], r4
		add r1, r2, objDying
		store_32 [r1], zr
		add r1, r2, objCnt
		store_32 [r1], zr
		add r1, r2, objType
		store_32 [r1], zr
		
		;add r1, r2, objObjRef
		;load_32 r1, [r1]
		
		;mul r1, r1, 4
		;add r1, r1, objRef
		
		;store_8 [r1], zr
		
	objNotDeadYet:
	cmp r3, 13
	jl objNotFlash
	
	load_32 r1, [loopCount]
	and r1, r1, 1
	cmp r1, 0
	je objNotFlash
		mov r10, 0
	objNotFlash:
ret

;--------------------------------------

draw_sendGPU:
;| r2 = obj_i * ENEMY_SIZE
;| r10 = charID

	add r1, r2, objX
	load_32 r11, [r1]
	load_32 r3, [screenLoc]
	
	asr r11, r11, 1		;prevent wobbling
	asr r3, r3, 1

	sub r11, r11, r3	;sub screenLoc
	
	lsl r11, r11, 1
	
	add r1, r2, objY
	load_32 r12, [r1]
	
	call drawSprite
ret

drawPlayerSprite:
	;setX
	load_32 r1, [frame]
	load_32 r2, [framePosX]
	add r1, r1, r2
	
	;setY
	load_32 r2, [framePosY]
	mul r2, r2, 100
	add r2, r1, r2 ;r2 = frameID
	
	;setSide
	load_32 r1, [side]
	cmp r1, 1
	jne faceRight
		add r2, r2, 6; add 6 so the player faces left
	faceRight:

	mov r10, r2
	
	load_32 r11, [charX]
	load_32 r12, [charY]
	
	load_32 r1, [punching]
	cmp r1, 0
	je notDrawPunching
		load_32 r1, [frame]
		cmp r1, 1
		jne notDrawPunching
		load_32 r1, [side]
		cmp r1, 1
		je drawPunchLeft
			add r11, r11, 10
			jmp notDrawPunching
		drawPunchLeft:
			sub r11, r11, 10
	notDrawPunching:
	
	call drawSprite
ret

;==================================
;		Draw Sprite
;==================================
;| r10 = charID
;| r11 = X
;| r12 = Y
drawSprite:
	asr r11, r11, 1
	asr r12, r12, 1

	sprite_charID r10
	sprite_posX r11
	sprite_posY r12
	sprite_draw
	
	;Wait 256 ticks for the sprite to be drawn by the GPU
	mov r1, 0
	loopWaitSprite:
		nop
		inc r1
		cmp r1, 64
	jne loopWaitSprite
ret

;==================================
;		Wait For GPU
;==================================

waitForVSync:
	gpu_counter r1
	cmp r1, GPU_DRAWTICKS
	jl waitForVSync
ret

;==================================
;		Draw Tilemap
;==================================

draw:

	load_32 r1, [levelTilemap]
	gpu_setTilemapAddr r1
	
	mov32 r1, GPU_TILEMAP1_X
	gpu_addr r1
	
	load_32 r3, [screenLoc]
	lsr r3, r3, 1
	gpu_write r3 ; scroll tileMap
	
	mov32 r1, GPU_TILEMAP2_X
	gpu_addr r1
	lsr r2, r3, 3
	gpu_write r2
	
	;switch screen buffer
	gpu_getScreenAddr r1		
	mov r2, 1
	screen r2,r1
	
	;reset counter and draw
	gpu_resetCounter
	gpu_draw
	
	;==== TO SEE SCREEN WHILE IT'S BEING DRAWN ====
	mov r1, debug_showDrawing
	cmp r1, 1
	jne noShowDrawing
		gpu_getScreenAddr r1		
		mov r2, 1
		screen r2,r1
	noShowDrawing:
ret
	
end:

;==================================
;		Wait For Next Frame
;==================================

waitForNextFrame:
	gpu_counter r1
	cmp r1, GPU_FRAMETICKS
	jl waitForNextFrame
ret

