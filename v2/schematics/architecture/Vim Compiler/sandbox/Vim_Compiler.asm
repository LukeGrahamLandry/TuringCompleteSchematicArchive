; ==========================================================
; SYMPHONY VIM EDITOR V7 + BASIC EXPRESSION COMPILER + TERMINAL
;
; :c compiles BASIC in text buffer; :r executes compiled code
; BASIC: recursive-descent + - * / % ( ), LET/PRINT, IF/WHILE/FOR/DO
; Empty lines / semicolon comments allowed, ASCII case-insensitive
; Screen = 24576, 28 editor rows + 11 terminal rows + status
; Text = 28672, 8192 bytes, State=36864, Keyboard map=40960
; Undo=49152, Redo=57344, Variables=39040 (A-Z)
; Generated machine code: 41472..49151 (max 7680 bytes)
; Program and screen do not overlap if resulting program <24KB.
; Requires 16 MiB Main RAM, physical keyboard and SSD for :w.
; ==============================================

START:
    mov r2, 256
    mov r7, 0
    mov r8, 0
    mov r9, 0
    mov r10, 0
    mov r12, 0
    mov sp, 15625
    lsl sp, sp, 6
    screen zr, 0
    mov r1, 1
    screen r1, 24576

    ; Reset state and metadata (36864..36903)
    mov r3, 36864
    mov r4, 36904
INIT_STATE:
    store_8 [r3], zr
    add r3, r3, 1
    cmp r3, r4
    jne INIT_STATE

    ; Zero both 256-byte keyboard lookup tables
    mov r3, 40960
    mov r4, 41472
INIT_KEYMAP:
    store_8 [r3], zr
    add r3, r3, 1
    cmp r3, r4
    jne INIT_KEYMAP

    ; Key map: physical code -> unshifted ASCII
    ; shifted punctuation stored at address (33024+code)

    mov r5, 96

    store_8 [40976], r5

    mov r5, 126

    store_8 [41232], r5

    mov r5, 49

    store_8 [40977], r5

    mov r5, 33

    store_8 [41233], r5

    mov r5, 50

    store_8 [40978], r5

    mov r5, 64

    store_8 [41234], r5

    mov r5, 51

    store_8 [40979], r5

    mov r5, 35

    store_8 [41235], r5

    mov r5, 52

    store_8 [40980], r5

    mov r5, 36

    store_8 [41236], r5

    mov r5, 53

    store_8 [40981], r5

    mov r5, 37

    store_8 [41237], r5

    mov r5, 54

    store_8 [40982], r5

    mov r5, 94

    store_8 [41238], r5

    mov r5, 55

    store_8 [40983], r5

    mov r5, 38

    store_8 [41239], r5

    mov r5, 56

    store_8 [40984], r5

    mov r5, 42

    store_8 [41240], r5

    mov r5, 57

    store_8 [40985], r5

    mov r5, 40

    store_8 [41241], r5

    mov r5, 48

    store_8 [40986], r5

    mov r5, 41

    store_8 [41242], r5

    mov r5, 45

    store_8 [40987], r5

    mov r5, 95

    store_8 [41243], r5

    mov r5, 61

    store_8 [40988], r5

    mov r5, 43

    store_8 [41244], r5

    mov r5, 113

    store_8 [40993], r5

    mov r5, 119

    store_8 [40994], r5

    mov r5, 101

    store_8 [40995], r5

    mov r5, 114

    store_8 [40996], r5

    mov r5, 116

    store_8 [40997], r5

    mov r5, 121

    store_8 [40998], r5

    mov r5, 117

    store_8 [40999], r5

    mov r5, 105

    store_8 [41000], r5

    mov r5, 111

    store_8 [41001], r5

    mov r5, 112

    store_8 [41002], r5

    mov r5, 91

    store_8 [41003], r5

    mov r5, 123

    store_8 [41259], r5

    mov r5, 93

    store_8 [41004], r5

    mov r5, 125

    store_8 [41260], r5

    mov r5, 92

    store_8 [41005], r5

    mov r5, 124

    store_8 [41261], r5

    mov r5, 97

    store_8 [41009], r5

    mov r5, 115

    store_8 [41010], r5

    mov r5, 100

    store_8 [41011], r5

    mov r5, 102

    store_8 [41012], r5

    mov r5, 103

    store_8 [41013], r5

    mov r5, 104

    store_8 [41014], r5

    mov r5, 106

    store_8 [41015], r5

    mov r5, 107

    store_8 [41016], r5

    mov r5, 108

    store_8 [41017], r5

    mov r5, 59

    store_8 [41018], r5

    mov r5, 58

    store_8 [41274], r5

    mov r5, 39

    store_8 [41019], r5

    mov r5, 34

    store_8 [41275], r5

    mov r5, 122

    store_8 [41025], r5

    mov r5, 120

    store_8 [41026], r5

    mov r5, 99

    store_8 [41027], r5

    mov r5, 118

    store_8 [41028], r5

    mov r5, 98

    store_8 [41029], r5

    mov r5, 110

    store_8 [41030], r5

    mov r5, 109

    store_8 [41031], r5

    mov r5, 44

    store_8 [41032], r5

    mov r5, 60

    store_8 [41288], r5

    mov r5, 46

    store_8 [41033], r5

    mov r5, 62

    store_8 [41289], r5

    mov r5, 47

    store_8 [41034], r5

    mov r5, 63

    store_8 [41290], r5

    mov r5, 32

    store_8 [41043], r5

    mov r5, 55

    store_8 [41123], r5

    mov r5, 56

    store_8 [41124], r5

    mov r5, 57

    store_8 [41125], r5

    mov r5, 52

    store_8 [41139], r5

    mov r5, 53

    store_8 [41140], r5

    mov r5, 54

    store_8 [41141], r5

    mov r5, 49

    store_8 [41155], r5

    mov r5, 50

    store_8 [41156], r5

    mov r5, 51

    store_8 [41157], r5

    mov r5, 48

    store_8 [41172], r5

    mov r5, 46

    store_8 [41173], r5

    ; Clear full ASCII-8 screen
    mov r3, 24576
    mov r4, 28416
    mov r5, 32
INIT_CLEAR:
    store_8 [r3], r5
    add r3, r3, 1
    cmp r3, r4
    jne INIT_CLEAR
    ; Terminal starts on visual row 28; rows 28-38 reserved.
    mov r3, 27264
    store_32 [36960], r3
    store_32 [36984], zr
    store_32 [36964], zr
    ; AUTO-RESTORE: don't report error if this is a fresh SSD
    mov r6, 1
    store_8 [36876], r6
    jmp LOAD_DOC

; ==========================================================
; Keyboard event dispatch (Physical mode, includes Key-Up)
; ==========================================================
READ_KB:
    keyboard r1
    and r3, r1, 256
    and r4, r1, 255

    ; Modifier key DOWN and UP transitions
    cmp r4, 64
    je LEFT_SHIFT
    cmp r4, 75
    je RIGHT_SHIFT
    cmp r4, 80
    je LEFT_CTRL
    cmp r4, 87
    je RIGHT_CTRL
    cmp r4, 48
    je CAPS_EVENT

    ; Ordinary key-up or no key waiting: ignore
    cmp r3, 0
    je CHECK_BLINK

    ; Special keys by physical location
    cmp r4, 0
    je KEY_ESCAPE
    cmp r4, 29
    je KEY_BACKSPACE
    cmp r4, 60
    je KEY_ENTER
    cmp r4, 208
    je MOVE_LEFT
    cmp r4, 210
    je MOVE_RIGHT
    cmp r4, 193
    je MOVE_UP
    cmp r4, 209
    je MOVE_DOWN
    cmp r4, 145
    je MOVE_HOME
    cmp r4, 161
    je MOVE_END
    cmp r4, 160
    je KEY_DELETE
    cmp r4, 5
    je SAVE_DOC
    cmp r4, 9
    je LOAD_DOC
    cmp r4, 32
    je KEY_TAB

    ; CTRL + physical R (0x24) in NORMAL -> REDO
    cmp r4, 36
    jne MAP_KEY
    load_8 r5, [36871]
    load_8 r6, [36872]
    or r5, r5, r6
    cmp r5, 0
    je MAP_KEY
    load_8 r5, [36867]
    cmp r5, 0
    je REDO_CHANGE
    jmp READ_KB

LEFT_SHIFT:
    cmp r3, 0
    je LEFT_SHIFT_UP
    mov r5, 1
    store_8 [36864], r5
    jmp READ_KB
LEFT_SHIFT_UP:
    store_8 [36864], zr
    jmp READ_KB
RIGHT_SHIFT:
    cmp r3, 0
    je RIGHT_SHIFT_UP
    mov r5, 1
    store_8 [36865], r5
    jmp READ_KB
RIGHT_SHIFT_UP:
    store_8 [36865], zr
    jmp READ_KB
LEFT_CTRL:
    cmp r3, 0
    je LEFT_CTRL_UP
    mov r5, 1
    store_8 [36871], r5
    jmp READ_KB
LEFT_CTRL_UP:
    store_8 [36871], zr
    jmp READ_KB
RIGHT_CTRL:
    cmp r3, 0
    je RIGHT_CTRL_UP
    mov r5, 1
    store_8 [36872], r5
    jmp READ_KB
RIGHT_CTRL_UP:
    store_8 [36872], zr
    jmp READ_KB
CAPS_EVENT:
    cmp r3, 0
    je READ_KB
    load_8 r5, [36866]
    xor r5, r5, 1
    store_8 [36866], r5
    jmp READ_KB

; ==========================================================
; Convert physical code -> ASCII using two RAM lookup tables
; Alphabet case is Shift XOR CapsLock, symbols use Shift only
; ==========================================================
MAP_KEY:
    add r5, r4, 40960
    load_8 r1, [r5]
    cmp r1, 0
    je READ_KB
    load_8 r5, [36864]
    load_8 r6, [36865]
    or r5, r5, r6
    cmp r5, 0
    je MAP_NO_SHIFT
    mov r5, 1
    jmp MAP_SHIFT_READY
MAP_NO_SHIFT:
    mov r5, 0
MAP_SHIFT_READY:
    cmp r1, 97
    jb MAP_SYMBOL
    cmp r1, 122
    ja MAP_SYMBOL
    load_8 r6, [36866]
    xor r5, r5, r6
    cmp r5, 0
    je DISPATCH_ASCII
    sub r1, r1, 32
    jmp DISPATCH_ASCII
MAP_SYMBOL:
    cmp r5, 0
    je DISPATCH_ASCII
    add r6, r4, 41216
    load_8 r6, [r6]
    cmp r6, 0
    je DISPATCH_ASCII
    mov r1, r6

DISPATCH_ASCII:
    load_8 r5, [36867]
    cmp r5, 1
    je INSERT_CHAR
    cmp r5, 2
    je CMD_CHARACTER
    jmp NORMAL_CHARACTER

; ==========================================================
; Modes and command keys
; ==========================================================
KEY_ESCAPE:
    store_8 [36868], zr
    store_8 [36869], zr
    store_8 [36874], zr
    store_8 [36867], zr
    jmp REFRESH

KEY_BACKSPACE:
    load_8 r5, [36867]
    cmp r5, 1
    je BACKSPACE
    cmp r5, 2
    je CMD_RESET
    jmp READ_KB
KEY_DELETE:
    load_8 r5, [36867]
    cmp r5, 1
    je DELETE_FORWARD
    jmp READ_KB
KEY_ENTER:
    load_8 r5, [36867]
    cmp r5, 2
    je RUN_COMMAND
    cmp r5, 1
    jne READ_KB
    mov r1, 10
    jmp INSERT_CHAR
KEY_TAB:
    load_8 r5, [36867]
    cmp r5, 1
    jne READ_KB
    ; Insert 4 spaces as one Undo operation
    cmp r7, 8192
    jae READ_KB
    call SNAPSHOT_UNDO
    mov r6, 4
    mov r1, 32
TAB_INSERT_LOOP:
    call INSERT_BYTE_RAW
    sub r6, r6, 1
    cmp r6, 0
    jne TAB_INSERT_LOOP
    jmp REFRESH

; Normal-mode commands, including two-key gg / dd
NORMAL_CHARACTER:
    load_8 r5, [36868]
    cmp r5, 1
    je NORMAL_AFTER_G
    cmp r5, 2
    je NORMAL_AFTER_D
    cmp r5, 3
    je NORMAL_AFTER_R
    store_8 [36868], zr
    cmp r1, 105              ; i
    je ENTER_INSERT
    cmp r1, 97               ; a
    je NORMAL_APPEND
    cmp r1, 73               ; I
    je NORMAL_INSERT_BEGIN
    cmp r1, 65               ; A
    je NORMAL_APPEND_END
    cmp r1, 111              ; o
    je NORMAL_OPEN_BELOW
    cmp r1, 79               ; O
    je NORMAL_OPEN_ABOVE
    cmp r1, 104              ; h
    je MOVE_LEFT
    cmp r1, 106              ; j
    je MOVE_DOWN
    cmp r1, 107              ; k
    je MOVE_UP
    cmp r1, 108              ; l
    je MOVE_RIGHT
    cmp r1, 48               ; 0
    je MOVE_HOME
    cmp r1, 36               ; $
    je MOVE_END
    cmp r1, 120              ; x
    je DELETE_FORWARD
    cmp r1, 88               ; X
    je BACKSPACE
    cmp r1, 117              ; u
    je UNDO_CHANGE
    cmp r1, 71               ; G
    je GOTO_END
    cmp r1, 103              ; g
    je PREFIX_G
    cmp r1, 100              ; d
    je PREFIX_D
    cmp r1, 114              ; r
    je PREFIX_R
    cmp r1, 58               ; :
    je ENTER_COMMAND
    jmp READ_KB
PREFIX_G:
    mov r5, 1
    store_8 [36868], r5
    jmp READ_KB
PREFIX_D:
    mov r5, 2
    store_8 [36868], r5
    jmp READ_KB
PREFIX_R:
    mov r5, 3
    store_8 [36868], r5
    jmp READ_KB
NORMAL_AFTER_R:
    store_8 [36868], zr
    cmp r8, r7
    jae READ_KB
    add r4, r8, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je READ_KB
    call SNAPSHOT_UNDO
    add r4, r8, 28672
    store_8 [r4], r1
    jmp REFRESH
NORMAL_AFTER_G:
    store_8 [36868], zr
    cmp r1, 103
    jne NORMAL_CHARACTER
    mov r8, 0
    jmp REFRESH
NORMAL_AFTER_D:
    store_8 [36868], zr
    cmp r1, 100
    jne NORMAL_CHARACTER
    jmp DELETE_LINE
GOTO_END:
    mov r8, r7
    jmp REFRESH
ENTER_INSERT:
    mov r5, 1
    store_8 [36867], r5
    jmp REFRESH
NORMAL_APPEND:
    cmp r8, r7
    jae ENTER_INSERT
    add r4, r8, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je ENTER_INSERT
    add r8, r8, 1
    jmp ENTER_INSERT
NORMAL_INSERT_BEGIN:
    mov r5, 1
    store_8 [36874], r5
    jmp MOVE_HOME
NORMAL_APPEND_END:
    mov r5, 1
    store_8 [36874], r5
    jmp MOVE_END
NORMAL_OPEN_BELOW:
    ; Move to end of current logical line then insert a LF
    mov r3, r8
OPEN_BELOW_SCAN:
    cmp r3, r7
    jae OPEN_BELOW_INSERT
    add r4, r3, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je OPEN_BELOW_INSERT
    add r3, r3, 1
    jmp OPEN_BELOW_SCAN
OPEN_BELOW_INSERT:
    mov r8, r3
    mov r5, 1
    store_8 [36867], r5
    mov r1, 10
    jmp INSERT_CHAR
NORMAL_OPEN_ABOVE:
    ; Insert LF at line start, then position before that LF
    mov r5, 1
    store_8 [36867], r5
    store_8 [36874], zr
    store_8 [36873], r5
    mov r3, r8
OPEN_ABOVE_SCAN:
    cmp r3, 0
    je OPEN_ABOVE_INSERT
    sub r4, r3, 1
    add r4, r4, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je OPEN_ABOVE_INSERT
    sub r3, r3, 1
    jmp OPEN_ABOVE_SCAN
OPEN_ABOVE_INSERT:
    mov r8, r3
    mov r1, 10
    jmp INSERT_CHAR

; :w, :wq, :e, :q command line (single word parser)
ENTER_COMMAND:
    mov r5, 2
    store_8 [36867], r5
    store_8 [36869], zr
    jmp REFRESH
CMD_CHARACTER:
    load_8 r5, [36869]
    cmp r1, 119             ; w
    je CMD_W
    cmp r1, 113             ; q
    je CMD_Q
    cmp r1, 101             ; e
    je CMD_E
    cmp r1, 99              ; c = compile
    je CMD_C
    cmp r1, 114             ; r = run
    je CMD_R
    store_8 [36869], zr
    jmp REFRESH
CMD_W:
    cmp r5, 0
    jne CMD_RESET
    mov r5, 1
    store_8 [36869], r5
    jmp REFRESH
CMD_Q:
    cmp r5, 1
    je CMD_WQ
    cmp r5, 0
    jne CMD_RESET
    mov r5, 3
    store_8 [36869], r5
    jmp REFRESH
CMD_WQ:
    mov r5, 2
    store_8 [36869], r5
    jmp REFRESH
CMD_E:
    cmp r5, 0
    jne CMD_RESET
    mov r5, 4
    store_8 [36869], r5
    jmp REFRESH
CMD_C:
    cmp r5, 0
    jne CMD_RESET
    mov r5, 5
    store_8 [36869], r5
    jmp REFRESH
CMD_R:
    cmp r5, 0
    jne CMD_RESET
    mov r5, 6
    store_8 [36869], r5
    jmp REFRESH
CMD_RESET:
    store_8 [36869], zr
    jmp REFRESH
RUN_COMMAND:
    load_8 r5, [36869]
    store_8 [36867], zr
    store_8 [36869], zr
    cmp r5, 1
    je SAVE_DOC
    cmp r5, 2
    je SAVE_AND_QUIT
    cmp r5, 3
    je QUIT_EDITOR
    cmp r5, 4
    je LOAD_DOC
    cmp r5, 5
    je COMPILE_START
    cmp r5, 6
    je RUN_START
    jmp REFRESH
SAVE_AND_QUIT:
    ; :wq invokes save, then emits 900 / stops
    mov r6, 1
    store_8 [36875], r6
    jmp SAVE_DOC
QUIT_EDITOR:
    out 900
STOP_EDITOR:
    jmp STOP_EDITOR

; ==========================================================
; INSERT: save undo snapshot, shift text right, store byte
; ==========================================================
INSERT_CHAR:
    cmp r7, 8192
    jae READ_KB
    call SNAPSHOT_UNDO
    call INSERT_BYTE_RAW
    jmp REFRESH

; Reusable insertion helper, input r1=byte, preserves r1/r6
INSERT_BYTE_RAW:
    cmp r7, 8192
    jae INSERT_BYTE_DONE
    mov r3, r7
SHIFT_RIGHT:
    cmp r3, r8
    je INSERT_AT
    sub r4, r3, 1
    add r4, r4, 28672
    load_8 r5, [r4]
    add r4, r4, 1
    store_8 [r4], r5
    sub r3, r3, 1
    jmp SHIFT_RIGHT
INSERT_AT:
    add r4, r8, 28672
    store_8 [r4], r1
    add r7, r7, 1
    add r8, r8, 1
    load_8 r5, [36873]
    cmp r5, 0
    je INSERT_FINISH
    sub r8, r8, 1
    store_8 [36873], zr
INSERT_FINISH:
INSERT_BYTE_DONE:
    ret

BACKSPACE:
    cmp r8, 0
    je READ_KB
    call SNAPSHOT_UNDO
    sub r8, r8, 1
    jmp DELETE_AT

DELETE_FORWARD:
    cmp r8, r7
    jae READ_KB
    call SNAPSHOT_UNDO
DELETE_AT:
    mov r3, r8
SHIFT_LEFT:
    add r4, r3, 1
    cmp r4, r7
    jae DELETE_DONE
    add r4, r4, 28672
    load_8 r5, [r4]
    sub r4, r4, 1
    store_8 [r4], r5
    add r3, r3, 1
    jmp SHIFT_LEFT
DELETE_DONE:
    sub r7, r7, 1
    add r4, r7, 28672
    mov r5, 32
    store_8 [r4], r5
    jmp REFRESH

; dd deletes entire logical line, including its LF (if any)
DELETE_LINE:
    cmp r7, 0
    je READ_KB
    call SNAPSHOT_UNDO
    mov r3, r8
DD_FIND_START:
    cmp r3, 0
    je DD_START_FOUND
    sub r4, r3, 1
    add r4, r4, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je DD_START_FOUND
    sub r3, r3, 1
    jmp DD_FIND_START
DD_START_FOUND:
    mov r4, r3
DD_FIND_END:
    cmp r4, r7
    jae DD_END_FOUND
    add r5, r4, 28672
    load_8 r6, [r5]
    add r4, r4, 1
    cmp r6, 10
    jne DD_FIND_END
DD_END_FOUND:
    ; if final line without LF, also remove preceding LF
    cmp r4, r7
    jne DD_RANGE_READY
    cmp r3, 0
    je DD_RANGE_READY
    cmp r4, r3
    je DD_REMOVE_PREV_LF
    sub r5, r4, 1
    add r5, r5, 28672
    load_8 r6, [r5]
    cmp r6, 10
    je DD_RANGE_READY
DD_REMOVE_PREV_LF:
    sub r3, r3, 1
DD_RANGE_READY:
    ; r3 start, r4 end (exclusive)
    sub r5, r4, r3
    mov r6, r3
DD_SHIFT:
    cmp r4, r7
    jae DD_FINISH
    add r13, r4, 28672
    load_8 r1, [r13]
    add r13, r6, 28672
    store_8 [r13], r1
    add r4, r4, 1
    add r6, r6, 1
    jmp DD_SHIFT
DD_FINISH:
    sub r7, r7, r5
    mov r8, r3
    ; Clamp cursor if a deleted final line was removed
    cmp r8, r7
    jbe DD_CLAMP_DONE
    mov r8, r7
DD_CLAMP_DONE:
    jmp REFRESH

MOVE_LEFT:
    cmp r8, 0
    je READ_KB
    sub r8, r8, 1
    jmp REFRESH

MOVE_RIGHT:
    cmp r8, r7
    jae READ_KB
    add r8, r8, 1
    jmp REFRESH

MOVE_HOME:
    mov r3, r8
HOME_SCAN:
    cmp r3, 0
    je HOME_DONE
    sub r4, r3, 1
    add r4, r4, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je HOME_DONE
    sub r3, r3, 1
    jmp HOME_SCAN
HOME_DONE:
    mov r8, r3
    load_8 r5, [36874]
    cmp r5, 0
    je REFRESH
    store_8 [36874], zr
    jmp ENTER_INSERT

MOVE_END:
    mov r3, r8
END_SCAN:
    cmp r3, r7
    jae END_DONE
    add r4, r3, 28672
    load_8 r5, [r4]
    cmp r5, 10
    je END_DONE
    add r3, r3, 1
    jmp END_SCAN
END_DONE:
    mov r8, r3
    load_8 r5, [36874]
    cmp r5, 0
    je REFRESH
    store_8 [36874], zr
    jmp ENTER_INSERT

; ========================================================
; UP / DOWN: move between LOGICAL LINES, preserve column
; ========================================================
; Find the start of current logical line -> r3
; This routine jumps to UP_FROM_START / DOWN_FROM_START
; rather than CALL, preserving flags and avoiding stack.
MOVE_UP:
    mov r3, r8
UP_FIND_START:
    cmp r3, 0
    je UP_FROM_START
    sub r5, r3, 1
    add r6, r5, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je UP_FROM_START
    sub r3, r3, 1
    jmp UP_FIND_START
UP_FROM_START:
    cmp r3, 0
    je READ_KB
    sub r4, r8, r3      ; preferred column
    sub r5, r3, 1       ; previous line end (LF index)
    mov r3, r5         ; scan previous line backwards
UP_FIND_PREV:
    cmp r3, 0
    je UP_TARGET
    sub r6, r3, 1
    add r6, r6, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je UP_TARGET
    sub r3, r3, 1
    jmp UP_FIND_PREV
UP_TARGET:
    sub r6, r5, r3      ; previous line length
    cmp r4, r6
    jbe UP_USE_COL
    mov r4, r6
UP_USE_COL:
    add r8, r3, r4
    jmp REFRESH

MOVE_DOWN:
    mov r3, r8
DOWN_FIND_START:
    cmp r3, 0
    je DOWN_FROM_START
    sub r5, r3, 1
    add r6, r5, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je DOWN_FROM_START
    sub r3, r3, 1
    jmp DOWN_FIND_START
DOWN_FROM_START:
    sub r4, r8, r3      ; preferred column
    mov r5, r8
DOWN_FIND_LF:
    cmp r5, r7
    jae READ_KB
    add r6, r5, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je DOWN_NEXT_LINE
    add r5, r5, 1
    jmp DOWN_FIND_LF
DOWN_NEXT_LINE:
    add r5, r5, 1       ; next logical line start
    mov r3, r5
DOWN_FIND_END:
    cmp r3, r7
    jae DOWN_TARGET
    add r6, r3, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je DOWN_TARGET
    add r3, r3, 1
    jmp DOWN_FIND_END
DOWN_TARGET:
    sub r6, r3, r5      ; next logical line length
    cmp r4, r6
    jbe DOWN_USE_COL
    mov r4, r6
DOWN_USE_COL:
    add r8, r5, r4
    jmp REFRESH

; ==========================================================
; ONE-LEVEL UNDO/REDO (copy actual document only, word aligned)
; CALL/RET require initialized stack, r1 is preserved.
; ==========================================================
SNAPSHOT_UNDO:
    store_32 [36964], zr
    store_32 [36880], r7
    store_32 [36884], r8
    mov r3, 1
    store_32 [36888], r3
    store_32 [36900], zr
    mov r3, 0
SNAPSHOT_LOOP:
    cmp r3, r7
    jae SNAPSHOT_DONE
    add r4, r3, 28672
    load_32 r5, [r4]
    add r4, r3, 49152
    store_32 [r4], r5
    add r3, r3, 4
    jmp SNAPSHOT_LOOP
SNAPSHOT_DONE:
    ret

UNDO_CHANGE:
    store_32 [36964], zr
    load_32 r6, [36888]
    cmp r6, 0
    je READ_KB
    ; Save current document to redo buffer
    store_32 [36892], r7
    store_32 [36896], r8
    mov r6, 1
    store_32 [36900], r6
    mov r3, 0
UNDO_BACKUP:
    cmp r3, r7
    jae UNDO_RESTORE
    add r4, r3, 28672
    load_32 r5, [r4]
    add r4, r3, 57344
    store_32 [r4], r5
    add r3, r3, 4
    jmp UNDO_BACKUP
UNDO_RESTORE:
    load_32 r7, [36880]
    load_32 r8, [36884]
    mov r3, 0
UNDO_LOOP:
    cmp r3, r7
    jae UNDO_DONE
    add r4, r3, 49152
    load_32 r5, [r4]
    add r4, r3, 28672
    store_32 [r4], r5
    add r3, r3, 4
    jmp UNDO_LOOP
UNDO_DONE:
    store_32 [36888], zr
    jmp REFRESH

REDO_CHANGE:
    store_32 [36964], zr
    load_32 r6, [36900]
    cmp r6, 0
    je READ_KB
    ; Re-save current state into undo
    store_32 [36880], r7
    store_32 [36884], r8
    mov r6, 1
    store_32 [36888], r6
    mov r3, 0
REDO_BACKUP:
    cmp r3, r7
    jae REDO_RESTORE
    add r4, r3, 28672
    load_32 r5, [r4]
    add r4, r3, 49152
    store_32 [r4], r5
    add r3, r3, 4
    jmp REDO_BACKUP
REDO_RESTORE:
    load_32 r7, [36892]
    load_32 r8, [36896]
    mov r3, 0
REDO_LOOP:
    cmp r3, r7
    jae REDO_DONE
    add r4, r3, 57344
    load_32 r5, [r4]
    add r4, r3, 28672
    store_32 [r4], r5
    add r3, r3, 4
    jmp REDO_LOOP
REDO_DONE:
    store_32 [36900], zr
    jmp REFRESH

; ==========================================================
; PERSISTENT STORAGE: TWO SAVESLOTS WITH VALIDATION
; Layout of each 8,208-byte slot (address in Bytes):
;   +0  Magic 21318 (written LAST as commit)
;   +4  Generation (monotonically increasing)
;   +8  Document length (0..8192)
;   +12 Checksum (length XOR generation, then rotate-like
;       shift-left-one and XOR each 32-bit document word)
;   +16 Document payload, 8192 bytes maximum.
; Slot A base = 0, Slot B base = 8224.
; The previous valid slot is never overwritten by a new save.
;
; Scratch metadata in Main RAM:
;   36912 checksum scratch for validation
;   28724 selected slot address
;   28728 selected generation
;   28732 valid slot found (0/1)
;   28736 destination for current save
;   28740 generation for current save
;   28684 boot loading flag (1 on reset)
;
; r7 = current document length, r8 = cursor, r9 = top.
; Helper routines preserve r2, r7-r12, sp and return using
; r1/r3-r6/r13 for scratch. (Call/ret use stack.)
; ==========================================================

SAVE_DOC:
    ; Choose destination: write to the slot NOT containing
    ; the newest valid save.
    call FIND_SAVED_SLOT
    load_32 r6, [36924]
    cmp r6, 0
    je SAVE_TO_B
    load_32 r6, [36916]
    cmp r6, 0
    je SAVE_TO_B
SAVE_TO_A:
    mov r3, 0
    jmp SAVE_PREPARE
SAVE_TO_B:
    mov r3, 16416
SAVE_PREPARE:
    store_32 [36928], r3
    load_32 r5, [36920]
    add r5, r5, 1
    store_32 [36932], r5

    ; Invalidate destination only; last save remains valid.
    pstore [r3], zr

    ; Write generation and logical document size.
    add r13, r3, 4
    pstore [r13], r5
    add r13, r3, 8
    pstore [r13], r7

    ; Write full 32-bit words, including the last partial one.
    ; The final unused bytes are ignored using saved length.
    xor r1, r7, r5
    mov r4, 0
SAVE_LOOP:
    cmp r4, r7
    jae SAVE_COMMIT
    add r13, r4, 28672
    load_32 r6, [r13]
    lsl r1, r1, 1
    xor r1, r1, r6
    add r13, r3, r4
    add r13, r13, 16
    pstore [r13], r6
    add r4, r4, 4
    jmp SAVE_LOOP

SAVE_COMMIT:
    ; First write checksum; only then mark slot valid.
    add r13, r3, 12
    pstore [r13], r1
    mov r6, 29510
    pstore [r3], r6

    ; Read it all back to verify persistent writes.
    call VALIDATE_SLOT
    cmp r6, 0
    je SAVE_FAILED
    out 501
    load_8 r5, [36875]
    cmp r5, 0
    je REFRESH
    store_8 [36875], zr
    jmp QUIT_EDITOR

SAVE_FAILED:
    ; Do not stop after :wq if the save failed.
    store_8 [36875], zr
    out 598
    jmp REFRESH

LOAD_DOC:
    store_32 [36964], zr
    ; Choose the newest valid slot, verify length + checksum.
    call FIND_SAVED_SLOT
    load_32 r6, [36924]
    cmp r6, 0
    je LOAD_LEGACY
    load_32 r3, [36916]
    mov r6, 16
    store_32 [36936], r6
    add r13, r3, 8
    pload r7, [r13]
    jmp LOAD_SETUP

; Backward compatibility with V2 format:
;   +0 magic 21317, +4 length, +8 payload
; Read this ONLY when neither V3 slot is valid.
LOAD_LEGACY:
    pload r6, [0]
    cmp r6, 29509
    jne LOAD_BAD
    pload r6, [4]
    cmp r6, 8192
    ja LOAD_BAD
    mov r7, r6
    mov r3, 0
    mov r6, 8
    store_32 [36936], r6

LOAD_SETUP:
    mov r8, 0
    mov r9, 0
    mov r4, 0
LOAD_LOOP:
    cmp r4, r7
    jae LOAD_DONE
    add r13, r3, r4
    load_32 r6, [36936]
    add r13, r13, r6
    pload r6, [r13]
    add r5, r4, 28672
    store_32 [r5], r6
    add r4, r4, 4
    jmp LOAD_LOOP
LOAD_DONE:
    store_32 [36888], zr
    store_32 [36900], zr
    load_8 r5, [36876]
    store_8 [36876], zr
    cmp r5, 0
    jne REFRESH
    out 502
    jmp REFRESH
LOAD_BAD:
    load_8 r5, [36876]
    store_8 [36876], zr
    cmp r5, 0
    jne REFRESH
    out 599
    jmp REFRESH

; ----------------------------------------------------------
; FIND_SAVED_SLOT
; Output: Main RAM metadata selected slot / generation / valid
; Checks both slots. Chooses the newer generation.
; ----------------------------------------------------------
FIND_SAVED_SLOT:
    store_32 [36916], zr
    store_32 [36920], zr
    store_32 [36924], zr

    mov r3, 0
    call VALIDATE_SLOT
    cmp r6, 0
    je FIND_SLOT_B
    store_32 [36916], r3
    store_32 [36920], r5
    store_32 [36924], r6

FIND_SLOT_B:
    mov r3, 16416
    call VALIDATE_SLOT
    cmp r6, 0
    je FIND_DONE
    load_32 r6, [36924]
    cmp r6, 0
    je FIND_USE_B
    load_32 r6, [36920]
    cmp r5, r6
    jbe FIND_DONE
FIND_USE_B:
    store_32 [36916], r3
    store_32 [36920], r5
    mov r6, 1
    store_32 [36924], r6
FIND_DONE:
    ret

; ----------------------------------------------------------
; VALIDATE_SLOT
; Input: r3 = persistent storage base address.
; Output: r6=1 valid, 0 invalid. r5=generation, r4=length.
; Preserves r3, r7-r12, r2. Clobbers r1/r4/r5/r6/r13.
; ----------------------------------------------------------
VALIDATE_SLOT:
    pload r6, [r3]
    cmp r6, 29510
    jne SLOT_INVALID
    add r13, r3, 4
    pload r5, [r13]
    add r13, r3, 8
    pload r4, [r13]
    cmp r4, 8192
    ja SLOT_INVALID
    add r13, r3, 12
    pload r6, [r13]
    store_32 [36912], r6

    xor r1, r4, r5
    mov r13, 0
VALIDATE_LOOP:
    cmp r13, r4
    jae VALIDATE_END
    add r6, r3, r13
    add r6, r6, 16
    pload r6, [r6]
    lsl r1, r1, 1
    xor r1, r1, r6
    add r13, r13, 4
    jmp VALIDATE_LOOP
VALIDATE_END:
    load_32 r6, [36912]
    cmp r1, r6
    jne SLOT_INVALID
    mov r6, 1
    ret
SLOT_INVALID:
    mov r6, 0
    ret

; ==========================================================
; BLINK on no keyboard event
; ==========================================================
CHECK_BLINK:
    ; Blink every 2^29 ns (~0.537 seconds)
    time_0 r3
    sub r3, r3, r11
    lsr r3, r3, 29
    cmp r3, 0
    je READ_KB
    time_0 r11
    cmp r10, 0
    je BLINK_SHOW

BLINK_HIDE:
    cmp r12, 0
    je BLINK_HIDE_DONE
    mov r3, 32
    cmp r8, r7
    jae BLINK_HIDE_WRITE
    add r4, r8, 28672
    load_8 r3, [r4]
    cmp r3, 10
    jne BLINK_HIDE_WRITE
    mov r3, 32
BLINK_HIDE_WRITE:
    store_8 [r12], r3
BLINK_HIDE_DONE:
    mov r10, 0
    jmp READ_KB

BLINK_SHOW:
    cmp r12, 0
    je READ_KB
    mov r3, 219
    store_8 [r12], r3
    mov r10, 1
    jmp READ_KB

REFRESH:
    cmp r8, r9
    jae REFRESH_BEGIN
    mov r9, 0
REFRESH_BEGIN:
    mov r3, 24576
    mov r4, 27264
    mov r5, 32
CLEAR_EDITOR:
    store_8 [r3], r5
    add r3, r3, 1
    cmp r3, r4
    jne CLEAR_EDITOR

    mov r3, r9          ; document index
    mov r4, 24576        ; screen byte address
    mov r5, 0           ; display column
    mov r12, 0          ; cursor screen address (invalid)
RENDER_SCAN:
    cmp r4, 27264
    jae RENDER_DONE
    cmp r3, r8
    jne RENDER_NO_CURSOR
    mov r12, r4
RENDER_NO_CURSOR:
    cmp r3, r7
    jae RENDER_DONE
    add r6, r3, 28672
    load_8 r13, [r6]
    cmp r13, 10
    je RENDER_LF

    store_8 [r4], r13
    add r4, r4, 1
    add r5, r5, 1
    cmp r5, 96
    jne RENDER_NEXT
    mov r5, 0
RENDER_NEXT:
    add r3, r3, 1
    jmp RENDER_SCAN

RENDER_LF:
    mov r6, 96
    sub r6, r6, r5
    add r4, r4, r6
    mov r5, 0
    add r3, r3, 1
    jmp RENDER_SCAN

RENDER_DONE:
    cmp r12, 0
    jne RENDER_CURSOR

    ; The cursor is below the display window.
    ; Shift the top by exactly one visual row.
    mov r3, r9
    mov r4, 0
NEXT_VISIBLE_ROW:
    cmp r3, r7
    jae FALLBACK_TOP
    add r5, r3, 28672
    load_8 r6, [r5]
    add r3, r3, 1
    cmp r6, 10
    je SET_NEW_TOP
    add r4, r4, 1
    cmp r4, 96
    jb NEXT_VISIBLE_ROW
SET_NEW_TOP:
    mov r9, r3
    jmp REFRESH
FALLBACK_TOP:
    mov r9, r8
    jmp REFRESH

RENDER_CURSOR:
    mov r3, 219
    store_8 [r12], r3
    mov r10, 1
    time_0 r11
    jmp DRAW_STATUS

; ==========================================================
; Status row at 11936. Changes reflect mode and command.
; ==========================================================
DRAW_STATUS:
    mov r3, 28320
    mov r4, 28344
    mov r5, 32
STATUS_CLEAR:
    store_8 [r3], r5
    add r3, r3, 1
    cmp r3, r4
    jne STATUS_CLEAR
    load_8 r3, [36867]
    cmp r3, 1
    je STATUS_INSERT
    cmp r3, 2
    je STATUS_CMD
STATUS_NORMAL:

    mov r3, 45

    store_8 [28320], r3

    store_8 [28321], r3

    mov r3, 32

    store_8 [28322], r3

    mov r3, 78

    store_8 [28323], r3

    mov r3, 79

    store_8 [28324], r3

    mov r3, 82

    store_8 [28325], r3

    mov r3, 77

    store_8 [28326], r3

    mov r3, 65

    store_8 [28327], r3

    mov r3, 76

    store_8 [28328], r3

    mov r3, 32

    store_8 [28329], r3

    mov r3, 45

    store_8 [28330], r3

    store_8 [28331], r3

    jmp READ_KB

STATUS_INSERT:

    mov r3, 45

    store_8 [28320], r3

    store_8 [28321], r3

    mov r3, 32

    store_8 [28322], r3

    mov r3, 73

    store_8 [28323], r3

    mov r3, 78

    store_8 [28324], r3

    mov r3, 83

    store_8 [28325], r3

    mov r3, 69

    store_8 [28326], r3

    mov r3, 82

    store_8 [28327], r3

    mov r3, 84

    store_8 [28328], r3

    mov r3, 32

    store_8 [28329], r3

    mov r3, 45

    store_8 [28330], r3

    store_8 [28331], r3

    jmp READ_KB

STATUS_CMD:

    mov r3, 58

    store_8 [28320], r3

    load_8 r3, [36869]
    cmp r3, 1
    je STATUS_CMD_W
    cmp r3, 2
    je STATUS_CMD_WQ
    cmp r3, 3
    je STATUS_CMD_Q
    cmp r3, 4
    je STATUS_CMD_E
    cmp r3, 5
    je STATUS_CMD_C
    cmp r3, 6
    je STATUS_CMD_R
    jmp READ_KB

STATUS_CMD_W:

    mov r3, 119

    store_8 [28321], r3
    jmp READ_KB

STATUS_CMD_WQ:

    mov r3, 119
    store_8 [28321], r3
    mov r3, 113
    store_8 [28322], r3
    jmp READ_KB

STATUS_CMD_Q:

    mov r3, 113
    store_8 [28321], r3
    jmp READ_KB

STATUS_CMD_E:

    mov r3, 101
    store_8 [28321], r3
    jmp READ_KB

STATUS_CMD_C:
    mov r3, 99
    store_8 [28321], r3
    jmp READ_KB
STATUS_CMD_R:
    mov r3, 114
    store_8 [28321], r3
    jmp READ_KB


; ==========================================================
; SYMPHONY BASIC V0.1 COMPILER + TERMINAL
; Editor RAM: Screen=24576, Text=28672, State=36864,
; Keymap=40960, Undo=49152, Redo=57344, Variables=39040
; Compiler work=36960..37663; Generated native code=41472
; Grammar (case-insensitive, 1 statement per line):
; LET A = expression ; ADD/SUB/MUL/DIV/MOD A expression ; PRINT expression ; END
; In-source semicolon comments and blank lines allowed.
; Each generated instruction is emitted as 4 big-endian bytes.
; To run, :r calls a trampoline to 41472; native code ends RET.
; Terminal occupies ASCII screen rows 28-38.
; ==========================================================

COMPILE_START:
    store_32 [37000], zr      ; nesting depth
    store_32 [36988], zr      ; runtime error flag
    store_32 [36964], zr       ; compiled flag reset
    store_32 [36972], zr       ; error code
    mov r4, 41472              ; executable low-RAM location
    store_32 [36968], r4     ; emit pointer
    mov r3, 0                 ; source byte index
    mov r6, 1
    store_32 [36976], r6     ; source line number
    call TERM_CLEAR
    call MSG_COMPILE
    call TERM_NEWLINE
    mov r4, 39040
    mov r5, 39144
COMPILE_ZERO_VARS:
    store_32 [r4], zr
    add r4, r4, 4
    cmp r4, r5
    jb COMPILE_ZERO_VARS
COMPILE_NEXT_LINE:
    call SKIP_SPACES
    cmp r1, 0
    je COMPILE_FINISH
    cmp r1, 10
    je COMPILE_NEW_LINE
    cmp r1, 59                 ; semicolon comment
    je COMPILE_SKIP_COMMENT
    call TO_UPPER
    cmp r1, 70
    je PARSE_FOR
    cmp r1, 78
    je PARSE_NEXT_HEAD
    cmp r1, 68
    je PARSE_D_FAMILY
    cmp r1, 77
    je PARSE_M_FAMILY
    cmp r1, 66
    je PARSE_BREAK_HEAD
    cmp r1, 67
    je PARSE_CONTINUE_HEAD
    cmp r1, 73
    je PARSE_IF
    cmp r1, 87
    je PARSE_WHILE
    cmp r1, 80
    je PARSE_PRINT
    cmp r1, 76
    je PARSE_L_FAMILY
    cmp r1, 65
    je PARSE_ADD
    cmp r1, 83
    je PARSE_SUB
    cmp r1, 69
    je PARSE_E_FAMILY
    jmp COMPILE_SYNTAX
COMPILE_SKIP_COMMENT:
    call GET_CHAR
    cmp r1, 0
    je COMPILE_FINISH
    cmp r1, 10
    jne COMPILE_SKIP_COMMENT
COMPILE_NEW_LINE:
    load_32 r6, [36976]
    add r6, r6, 1
    store_32 [36976], r6
    jmp COMPILE_NEXT_LINE
PARSE_PRINT:
    call GET_UPPER
    cmp r1, 82
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 78
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    jmp PRINT_ARG
PARSE_L_FAMILY:
    call GET_UPPER
    cmp r1, 69
    je PARSE_LET_T
    cmp r1, 79
    je PARSE_LOOP_O
    jmp COMPILE_SYNTAX
PARSE_LET_T:
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    jmp LET_ARG
PARSE_LOOP_O:
    call GET_UPPER
    cmp r1, 79
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 80
    jne COMPILE_SYNTAX
    call GET_CHAR
    jmp PARSE_LOOP_BODY
PARSE_ADD:
    call GET_UPPER
    cmp r1, 68
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 68
    jne COMPILE_SYNTAX
    mov r4, 4
    jmp V6_MATH_HEAD
PARSE_SUB:
    call GET_UPPER
    cmp r1, 85
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 66
    jne COMPILE_SYNTAX
    mov r4, 5
    jmp V6_MATH_HEAD
PARSE_E_FAMILY:
    call GET_UPPER
    cmp r1, 76                 ; EL...
    je E_ELSE
    cmp r1, 78                 ; EN...
    je E_END
    jmp COMPILE_SYNTAX
E_ELSE:
    call GET_UPPER
    cmp r1, 83
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_CHAR
    jmp PARSE_ELSE
E_END:
    call GET_UPPER
    cmp r1, 68
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73                 ; ENDIF
    je E_ENDIF
    cmp r1, 87                 ; ENDWHILE
    je E_ENDWHILE
    jmp END_SOURCE            ; END followed by whitespace/EOF/LF
E_ENDIF:
    call GET_UPPER
    cmp r1, 70
    jne COMPILE_SYNTAX
    call GET_CHAR
    jmp PARSE_ENDIF
E_ENDWHILE:
    call GET_UPPER
    cmp r1, 72
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 76
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_CHAR
    jmp PARSE_ENDWHILE
PRINT_ARG:
    call SKIP_SPACES
    call E_EXPR
    push r1
    mov r1, 512             ; OUT r1: 0x02000100
    lsl r1, r1, 16
    or r1, r1, 256
    call EMIT_WORD
    call EMIT_PRINT_CALL
    pop r1
    jmp END_STATEMENT

LET_ARG:
    call SKIP_SPACES
    call PARSE_VARIABLE
    load_32 r4, [36980]
    store_32 [37656], r4    ; destination survives RHS variables
    call SKIP_SPACES
    cmp r1, 61              ; =
    jne COMPILE_SYNTAX
    call SKIP_SPACES
    call E_EXPR             ; result in runtime r1
    load_32 r6, [37656]
    store_32 [36980], r6
    push r1
    call EMIT_STORE_VAR
    pop r1
    jmp END_STATEMENT

ADD_ARG:
    call SKIP_SPACES
    call PARSE_VARIABLE
    call SKIP_SPACES
    call PARSE_NUMBER
    store_8 [36992], r1
    store_32 [36996], r6
    call EMIT_LOAD_VAR
    load_32 r6, [36996]
    mov r1, 13329           ; ADD r1,r1,imm
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    call EMIT_STORE_VAR
    load_8 r1, [36992]
    jmp END_STATEMENT
SUB_ARG:
    call SKIP_SPACES
    call PARSE_VARIABLE
    call SKIP_SPACES
    call PARSE_NUMBER
    store_8 [36992], r1
    store_32 [36996], r6
    call EMIT_LOAD_VAR
    load_32 r6, [36996]
    mov r1, 13585           ; SUB r1,r1,imm
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    call EMIT_STORE_VAR
    load_8 r1, [36992]
    jmp END_STATEMENT
END_ARG:
    call GET_CHAR
    jmp END_SOURCE
END_SOURCE:
    cmp r1, 32
    jne END_SOURCE_CHECK
    call GET_CHAR
    jmp END_SOURCE
END_SOURCE_CHECK:
    cmp r1, 0
    je COMPILE_FINISH
    cmp r1, 10
    je COMPILE_FINISH
    jmp COMPILE_SYNTAX
END_STATEMENT:
    load_32 r4, [36972]
    cmp r4, 0
    jne COMPILE_ERROR
    cmp r1, 32
    jne END_STATEMENT_CHECK
    call GET_CHAR
    jmp END_STATEMENT
END_STATEMENT_CHECK:
    cmp r1, 10
    je COMPILE_NEW_LINE
    cmp r1, 0
    je COMPILE_FINISH
    jmp COMPILE_SYNTAX
COMPILE_FINISH:
    load_32 r6, [37000]
    cmp r6, 0
    jne COMPILE_UNCLOSED
    mov r1, 25328
    lsl r1, r1, 16
    or r1, r1, 3584
    call EMIT_WORD
    mov r1, 13550
    lsl r1, r1, 16
    or r1, r1, 4
    call EMIT_WORD
    mov r1, 18447
    lsl r1, r1, 16
    or r1, r1, 3840
    call EMIT_WORD
    load_32 r6, [36972]
    cmp r6, 0
    jne COMPILE_ERROR
    mov r6, 1
    store_32 [36964], r6
    call MSG_COMPILE_OK
    load_32 r1, [36968]
    mov r4, 41472
    sub r1, r1, r4
    call TERM_NUMBER
    jmp REFRESH
COMPILE_UNCLOSED:
    mov r6, 4
    store_32 [36972], r6
    jmp COMPILE_ERROR
COMPILE_UNMATCHED:
    mov r6, 5
    store_32 [36972], r6
    jmp COMPILE_ERROR
COMPILE_SYNTAX:
    mov r6, 1
    store_32 [36972], r6
COMPILE_ERROR:
    store_32 [36964], zr
    call MSG_COMPILE_ERROR
    load_32 r1, [36976]
    call TERM_NUMBER
    load_32 r6, [36972]
    cmp r6, 1
    je ERROR_SYNTAX_MSG
    cmp r6, 2
    je ERROR_VALUE_MSG
    cmp r6, 3
    je ERROR_SIZE_MSG
    cmp r6, 4
    je ERROR_BLOCK_MSG
    cmp r6, 5
    je ERROR_UNMATCHED_MSG
    cmp r6, 6
    je ERROR_NESTING_MSG
    cmp r6, 7
    je ERROR_DIV_MSG
    jmp REFRESH
ERROR_SYNTAX_MSG:
    call MSG_SYNTAX
    jmp REFRESH
ERROR_VALUE_MSG:
    call MSG_VALUE
    jmp REFRESH
ERROR_SIZE_MSG:
    call MSG_SIZE
    jmp REFRESH
RUN_START:
    load_32 r3, [36964]
    cmp r3, 0
    je RUN_NO_CODE
    call MSG_RUNNING
    call TERM_NEWLINE
    mov r3, 39040
    mov r4, 39144
RUN_ZERO_VARS:
    store_32 [r3], zr
    add r3, r3, 4
    cmp r3, r4
    jb RUN_ZERO_VARS
    store_32 [36988], zr
    push r2
    call EXEC_ENTRY
    pop r2
    load_32 r6, [36988]
    cmp r6, 0
    jne RUN_RETURN_AFTER_ERROR
    call MSG_RUN_DONE
    call TERM_NEWLINE
    jmp REFRESH
RUN_RETURN_AFTER_ERROR:
    call TERM_NEWLINE
    jmp REFRESH
RUN_NO_CODE:
    call MSG_RUN_NO_CODE
    call TERM_NEWLINE
    jmp REFRESH
EXEC_ENTRY:
    store_32 [37660], sp   ; restore stack if division by zero occurs mid-expression
    mov r1, 41472
    jmp r1
RUN_DIV_ZERO:
    mov r1, 1
    store_32 [36988], r1
    load_32 sp, [37660]   ; throw away partial expression values
    call MSG_RUNTIME_DIV_ZERO
    ret
GET_CHAR:
    cmp r3, r7
    jae GET_CHAR_EOF
    add r5, r3, 28672
    load_8 r1, [r5]
    add r3, r3, 1
    ret
GET_CHAR_EOF:
    mov r1, 0
    ret
TO_UPPER:
    cmp r1, 97
    jb TO_UPPER_DONE
    cmp r1, 122
    ja TO_UPPER_DONE
    sub r1, r1, 32
TO_UPPER_DONE:
    ret
GET_UPPER:
    call GET_CHAR
    call TO_UPPER
    ret
SKIP_SPACES:
    call GET_UPPER
    cmp r1, 32
    je SKIP_SPACES
    ret
PARSE_VARIABLE:
    cmp r1, 65
    jb PARSE_VARIABLE_BAD
    cmp r1, 90
    ja PARSE_VARIABLE_BAD
    sub r4, r1, 65
    lsl r4, r4, 2
    add r4, r4, 39040
    store_32 [36980], r4
    ret
PARSE_VARIABLE_BAD:
    mov r4, 1
    store_32 [36972], r4
    mov r4, 39040
    store_32 [36980], r4
    ret
PARSE_NUMBER:
    mov r6, 0
    mov r13, 0             ; count digits
NUMBER_LOOP:
    cmp r1, 48
    jb NUMBER_END
    cmp r1, 57
    ja NUMBER_END
    sub r4, r1, 48
    lsl r5, r6, 3
    lsl r6, r6, 1
    add r6, r6, r5
    add r6, r6, r4
    add r13, r13, 1
    cmp r6, 65535
    jbe NUMBER_NEXT
    mov r4, 2
    store_32 [36972], r4
NUMBER_NEXT:
    call GET_CHAR
    jmp NUMBER_LOOP
NUMBER_END:
    cmp r13, 0
    jne NUMBER_NONEMPTY
    mov r4, 1
    store_32 [36972], r4
NUMBER_NONEMPTY:
    cmp r1, 65
    jb NUMBER_FINISH
    cmp r1, 90
    ja NUMBER_FINISH
    mov r4, 1
    store_32 [36972], r4
NUMBER_FINISH:
    ret
EMIT_MOV_R1:
    mov r1, 12560        ; 0x3110
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    ret
EMIT_LOAD_VAR:
    load_32 r6, [36980]
    mov r1, 29200        ; 0x7210
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    ret
EMIT_STORE_VAR:
    load_32 r6, [36980]
    mov r1, 30209        ; 0x7601
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    ret
EMIT_PRINT_CALL:
    mov r1, 2032
    lsl r1, r1, 16
    call EMIT_WORD
    mov r1, 13567
    lsl r1, r1, 16
    or r1, r1, 20
    call EMIT_WORD
    mov r1, 13806
    lsl r1, r1, 16
    or r1, r1, 4
    call EMIT_WORD
    mov r1, 26127
    lsl r1, r1, 16
    or r1, r1, 3584
    call EMIT_WORD
    mov r1, 22543    ; 0x580F
    lsl r1, r1, 16
    mov r6, TERM_NUMBER
    or r1, r1, r6
    call EMIT_WORD
    ret
EMIT_WORD:
    push r1
    push r3
    push r4
    push r5
    push r6
    push r13
    load_32 r3, [36968]
    mov r5, 41472
    sub r5, r3, r5
    cmp r5, 7680
    jae EMIT_TOO_LARGE
    mov r4, r1
    lsr r5, r4, 24
    store_8 [r3], r5
    add r3, r3, 1
    lsr r5, r4, 16
    store_8 [r3], r5
    add r3, r3, 1
    lsr r5, r4, 8
    store_8 [r3], r5
    add r3, r3, 1
    mov r5, r4
    store_8 [r3], r5
    add r3, r3, 1
    store_32 [36968], r3
    jmp EMIT_WORD_END
EMIT_TOO_LARGE:
    mov r5, 3
    store_32 [36972], r5
EMIT_WORD_END:
    pop r13
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    ret
TERM_CLEAR:
    push r3
    push r4
    push r5
    mov r3, 27264
    mov r4, 28320
    mov r5, 32
TERM_CLEAR_LOOP:
    store_8 [r3], r5
    add r3, r3, 1
    cmp r3, r4
    jne TERM_CLEAR_LOOP
    mov r3, 27264
    store_32 [36960], r3
    store_32 [36984], zr
    pop r5
    pop r4
    pop r3
    ret
TERM_NEWLINE:
    push r1
    mov r1, 10
    call TERM_CHAR
    pop r1
    ret
TERM_CHAR:
    push r3
    push r4
    push r5
    push r6
    push r13
    load_32 r3, [36960]
    load_32 r4, [36984]
    cmp r1, 10
    je TERM_CHAR_LINE
    store_8 [r3], r1
    add r3, r3, 1
    add r4, r4, 1
    cmp r4, 96
    jb TERM_CHAR_COMMIT
    mov r4, 0
    jmp TERM_CHAR_NEWLINE_CHECK
TERM_CHAR_LINE:
    mov r5, 96
    sub r5, r5, r4
    add r3, r3, r5
    mov r4, 0
TERM_CHAR_NEWLINE_CHECK:
    cmp r3, 28320
    jb TERM_CHAR_COMMIT
    mov r5, 27264
    mov r6, 28224
TERM_SCROLL_LOOP:
    add r13, r5, 96
    load_8 r3, [r13]
    store_8 [r5], r3
    add r5, r5, 1
    cmp r5, r6
    jb TERM_SCROLL_LOOP
    mov r3, 28224
    mov r6, 28320
TERM_BLANK_ROW:
    mov r5, 32
    store_8 [r3], r5
    add r3, r3, 1
    cmp r3, r6
    jb TERM_BLANK_ROW
    mov r3, 28224
TERM_CHAR_COMMIT:
    store_32 [36960], r3
    store_32 [36984], r4
    pop r13
    pop r6
    pop r5
    pop r4
    pop r3
    ret
TERM_NUMBER:
    push r1
    push r3
    push r4
    push r5
    push r6
    push r13
    mov r3, r1
    mov r4, 1
    mov r5, 10
TERM_POWERS:
    push r4
    sub r5, r5, 1
    cmp r5, 0
    je TERM_START_DIGITS
    lsl r6, r4, 3
    lsl r4, r4, 1
    add r4, r4, r6
    jmp TERM_POWERS
TERM_START_DIGITS:
    mov r5, 10
    mov r13, 0
TERM_NEXT_DIGIT:
    pop r4
    mov r6, 0
TERM_SUBTRACT:
    cmp r3, r4
    jb TERM_DIGIT_READY
    sub r3, r3, r4
    add r6, r6, 1
    jmp TERM_SUBTRACT
TERM_DIGIT_READY:
    cmp r6, 0
    jne TERM_PRINT_DIGIT
    cmp r13, 0
    jne TERM_PRINT_DIGIT
    cmp r4, 1
    jne TERM_SKIP_DIGIT
TERM_PRINT_DIGIT:
    add r1, r6, 48
    call TERM_CHAR
    mov r13, 1
TERM_SKIP_DIGIT:
    sub r5, r5, 1
    cmp r5, 0
    jne TERM_NEXT_DIGIT
    call TERM_NEWLINE
    pop r13
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    ret
MSG_COMPILE:
    mov r1, 67
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 77
    call TERM_CHAR
    mov r1, 80
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    ret
MSG_COMPILE_OK:
    mov r1, 79
    call TERM_CHAR
    mov r1, 75
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 66
    call TERM_CHAR
    mov r1, 89
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 83
    call TERM_CHAR
    mov r1, 58
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    ret
MSG_COMPILE_ERROR:
    mov r1, 69
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 58
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    ret
MSG_RUNNING:
    mov r1, 82
    call TERM_CHAR
    mov r1, 85
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    mov r1, 46
    call TERM_CHAR
    ret
MSG_RUN_DONE:
    mov r1, 91
    call TERM_CHAR
    mov r1, 68
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 93
    call TERM_CHAR
    ret
MSG_RUN_NO_CODE:
    mov r1, 78
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 68
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 45
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 85
    call TERM_CHAR
    mov r1, 83
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 58
    call TERM_CHAR
    mov r1, 99
    call TERM_CHAR
    ret
MSG_SYNTAX:
    mov r1, 83
    call TERM_CHAR
    mov r1, 89
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 88
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    ret
MSG_VALUE:
    mov r1, 86
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 85
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 85
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 70
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    ret
MSG_SIZE:
    mov r1, 80
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 77
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    ret

ERROR_BLOCK_MSG:
    call MSG_UNCLOSED
    jmp REFRESH
ERROR_UNMATCHED_MSG:
    call MSG_UNMATCHED
    jmp REFRESH
ERROR_NESTING_MSG:
    call MSG_NESTING
    jmp REFRESH


; ============================================================
; BASIC IF / ELSE / ENDIF, WHILE / ENDWHILE (V5 retained)
; r3=source position, r7=source length, r1=scanner lookahead
; Block stack: depth [37000], 16 frames @ 37024+32*n
; Types: IF=1 WHILE=2 FOR=3 DO=4; fields described below
; Scratch [37004] loop start, [37008] op, [37020] new branch
; Executable buffer 41472..49151, fully 16-bit addressable
; ============================================================
PARSE_IF:
    call GET_UPPER
    cmp r1, 70
    jne COMPILE_SYNTAX
    call PARSE_CONDITION
    ; Lookahead must contain optional spaces then THEN
    cmp r1, 32
    jne IF_CHECK_T
    call SKIP_SPACES
IF_CHECK_T:
    cmp r1, 84
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 72
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 78
    jne COMPILE_SYNTAX
    call GET_CHAR
    call EMIT_BRANCH_FALSE
    mov r4, 1
    call PUSH_BLOCK
    jmp END_STATEMENT

PARSE_WHILE:
    call GET_UPPER
    cmp r1, 72
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 76
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    load_32 r4, [36968]
    store_32 [37004], r4   ; loop head before CMP
    call PARSE_CONDITION
    call EMIT_BRANCH_FALSE
    mov r4, 2
    call PUSH_BLOCK
    jmp END_STATEMENT

; Compare lhs variable (A-Z) to rhs variable or 0..65535
; Signed comparisons; both variable values are 32-bit
PARSE_CONDITION:
    call SKIP_SPACES
    call E_EXPR             ; emits lhs value to runtime r1
    call E_GEN_PUSH_R1      ; keep lhs while compiling rhs
    cmp r1, 32
    jne C_OPERATOR_READY
    call SKIP_SPACES

C_OPERATOR_READY:
    cmp r1, 61               ; ==
    je C_EQ
    cmp r1, 33               ; !=
    je C_NE
    cmp r1, 60               ; < <=
    je C_LT
    cmp r1, 62               ; > >=
    je C_GT
    mov r4, 1
    store_32 [36972], r4
    ret
C_EQ:
    call GET_CHAR
    cmp r1, 61
    jne C_OP_BAD
    mov r4, 0
    call SAVE_C_OP
    call GET_CHAR
    jmp C_RHS
C_NE:
    call GET_CHAR
    cmp r1, 61
    jne C_OP_BAD
    mov r4, 1
    call SAVE_C_OP
    call GET_CHAR
    jmp C_RHS
C_LT:
    mov r4, 2
    call GET_CHAR
    cmp r1, 61
    jne C_LT_DONE
    mov r4, 3
C_LT_DONE:
    call SAVE_C_OP
    cmp r1, 61
    jne C_RHS
    call GET_CHAR
    jmp C_RHS
C_GT:
    mov r4, 4
    call GET_CHAR
    cmp r1, 61
    jne C_GT_DONE
    mov r4, 5
C_GT_DONE:
    call SAVE_C_OP
    cmp r1, 61
    jne C_RHS
    call GET_CHAR
    jmp C_RHS
C_OP_BAD:
    mov r4, 1
    store_32 [36972], r4
    ret
SAVE_C_OP:
    store_32 [37008], r4
    ret
C_RHS:
    call E_EXPR             ; emits rhs value to runtime r1
    call E_GEN_POP_R2       ; lhs goes to runtime r2
    push r1                 ; compiler lookahead
    mov r1, 10994           ; CMP r2,r1 = 0x2AF20100
    lsl r1, r1, 16
    or r1, r1, 256
    call EMIT_WORD
    pop r1
    ret

; False branch: equality=>JNE, !==>JE, <=>JGE, <==>JG,
;               >=>JLE, >==>JL
EMIT_BRANCH_FALSE:
    push r1
    load_32 r4, [37008]
    cmp r4, 0
    je CB_NE
    cmp r4, 1
    je CB_EQ
    cmp r4, 2
    je CB_GE
    cmp r4, 3
    je CB_G
    cmp r4, 4
    je CB_LE
    mov r1, 21519            ; 0x540F JL (not >=)
    jmp CB_EMIT
CB_NE:
    mov r1, 22799            ; 0x590F JNE
    jmp CB_EMIT
CB_EQ:
    mov r1, 20751            ; 0x510F JE
    jmp CB_EMIT
CB_GE:
    mov r1, 23567            ; 0x5C0F JGE
    jmp CB_EMIT
CB_G:
    mov r1, 23823            ; 0x5D0F JG
    jmp CB_EMIT
CB_LE:
    mov r1, 21775            ; 0x550F JLE
CB_EMIT:
    lsl r1, r1, 16
    load_32 r6, [36968]
    store_32 [37020], r6
    call EMIT_WORD
    pop r1
    ret

PUSH_BLOCK:
    push r1
    push r3
    push r4
    push r5
    push r6
    push r13
    load_32 r13, [37000]
    cmp r13, 16
    jb BLOCK_PUSH_OK
    mov r6, 6
    store_32 [36972], r6
    jmp BLOCK_PUSH_EXIT
BLOCK_PUSH_OK:
    lsl r5, r13, 5
    add r5, r5, 37024
    store_32 [r5], r4        ; frame.type
    add r5, r5, 4
    load_32 r6, [37020]
    store_32 [r5], r6        ; frame.patch
    add r5, r5, 4
    load_32 r6, [37004]
    store_32 [r5], r6        ; frame.loop_start
    add r5, r5, 4
    store_32 [r5], zr       ; else flag / for variable address
    add r5, r5, 4
    store_32 [r5], zr       ; for limit
    add r5, r5, 4
    store_32 [r5], zr       ; for step (32-bit signed)
    add r5, r5, 4
    store_32 [r5], zr       ; break list
    add r5, r5, 4
    store_32 [r5], zr       ; continue list
    add r13, r13, 1
    store_32 [37000], r13
BLOCK_PUSH_EXIT:
    pop r13
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    ret

; PEEK_BLOCK: r5=frame addr, r6=frame type, 0 if stack empty
PEEK_BLOCK:
    load_32 r6, [37000]
    cmp r6, 0
    jne BLOCK_HAS_FRAME
    mov r5, 37024
    mov r6, 0
    ret
BLOCK_HAS_FRAME:
    sub r6, r6, 1
    lsl r5, r6, 5
    add r5, r5, 37024
    load_32 r6, [r5]
    ret

PARSE_ELSE:
    call PEEK_BLOCK
    cmp r6, 1
    jne COMPILE_UNMATCHED
    add r4, r5, 12
    load_32 r4, [r4]
    cmp r4, 0
    jne COMPILE_UNMATCHED
    ; emit JMP after IF body, new patch site for ENDIF
    push r1
    load_32 r6, [36968]
    store_32 [37020], r6
    mov r1, 22543          ; JMP 0 (0x580F0000)
    lsl r1, r1, 16
    call EMIT_WORD
    ; backpatch IF false branch to ELSE first instruction
    call PEEK_BLOCK
    add r4, r5, 4
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_TARGET
    ; frame.patch=ELSE unconditional JMP, flag=1
    call PEEK_BLOCK
    add r5, r5, 4
    load_32 r6, [37020]
    store_32 [r5], r6
    add r5, r5, 8
    mov r6, 1
    store_32 [r5], r6
    pop r1
    jmp END_STATEMENT

PARSE_ENDIF:
    call PEEK_BLOCK
    cmp r6, 1
    jne COMPILE_UNMATCHED
    add r4, r5, 4
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_TARGET
    call POP_BLOCK
    jmp END_STATEMENT

PARSE_ENDWHILE:
    call PEEK_BLOCK
    cmp r6, 2
    jne COMPILE_UNMATCHED
    ; emit unconditional jump to loop head
    push r1
    add r4, r5, 8
    load_32 r6, [r4]
    mov r1, 22543
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    pop r1
    ; patch loop exit forward jump to after backward jump
    call PEEK_BLOCK
    add r4, r5, 4
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_TARGET
    ; fix all BREAK sites to end of loop and CONTINUE to test head
    call PEEK_BLOCK
    add r4, r5, 24
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_CHAIN
    call PEEK_BLOCK
    add r4, r5, 28
    load_32 r4, [r4]
    add r6, r5, 8
    load_32 r6, [r6]
    call PATCH_CHAIN
    call POP_BLOCK
    jmp END_STATEMENT

POP_BLOCK:
    load_32 r4, [37000]
    sub r4, r4, 1
    store_32 [37000], r4
    ret

; r4=address of conditional / unconditional JMP, r6=target
PATCH_TARGET:
    push r4
    push r5
    add r4, r4, 2
    lsr r5, r6, 8
    store_8 [r4], r5
    add r4, r4, 1
    store_8 [r4], r6
    pop r5
    pop r4
    ret

MSG_UNCLOSED:
    mov r1, 85
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 83
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 68
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 66
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 75
    call TERM_CHAR
    ret

MSG_UNMATCHED:
    mov r1, 77
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 83
    call TERM_CHAR
    mov r1, 77
    call TERM_CHAR
    mov r1, 65
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 72
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 68
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 66
    call TERM_CHAR
    mov r1, 76
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 75
    call TERM_CHAR
    ret

MSG_NESTING:
    mov r1, 84
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 77
    call TERM_CHAR
    mov r1, 85
    call TERM_CHAR
    mov r1, 67
    call TERM_CHAR
    mov r1, 72
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 83
    call TERM_CHAR
    mov r1, 84
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 78
    call TERM_CHAR
    mov r1, 71
    call TERM_CHAR
    ret

; ============================================================
; SYMPHONY BASIC V6
; ALU MUL/DIV/MOD opcode low nibble B,C,D.
; Reg forms: 0x2B/2C/2D, Imm forms: 0x3B/3C/3D.
; Work scratch: [37600..37663]; Frame: 32 bytes, max 16.
; Frame fields: type, patch, loop_head, var/else, limit, signedStep,
;               break_link, continue_link.
; Loops: type 2 WHILE, type 3 FOR, type 4 DO.
; ============================================================

; ADD/SUB/MUL/DIV/MOD A 3 or A B (immediate or variable)
PARSE_M_FAMILY:
    call GET_UPPER
    cmp r1, 85
    je V6_MUL_U
    cmp r1, 79
    je V6_MOD_O
    jmp COMPILE_SYNTAX
V6_MUL_U:
    call GET_UPPER
    cmp r1, 76
    jne COMPILE_SYNTAX
    mov r4, 11
    jmp V6_MATH_HEAD
V6_MOD_O:
    call GET_UPPER
    cmp r1, 68
    jne COMPILE_SYNTAX
    mov r4, 13
    jmp V6_MATH_HEAD

; DIV or DO
PARSE_D_FAMILY:
    call GET_UPPER
    cmp r1, 73
    je V6_DIV_I
    cmp r1, 79
    je V6_DO_O
    jmp COMPILE_SYNTAX
V6_DIV_I:
    call GET_UPPER
    cmp r1, 86
    jne COMPILE_SYNTAX
    mov r4, 12
    jmp V6_MATH_HEAD
V6_DO_O:
    call GET_CHAR
    load_32 r4, [36968]
    store_32 [37004], r4
    store_32 [37020], zr
    mov r4, 4
    call PUSH_BLOCK
    jmp END_STATEMENT

V6_MATH_HEAD:
    store_32 [37624], r4   ; opcode low nibble 4,5,11,12,13
    call SKIP_SPACES
    call PARSE_VARIABLE
    load_32 r6, [36980]
    store_32 [37628], r6
    call SKIP_SPACES
    call E_EXPR             ; runtime r1 = arbitrary expression
    call E_GEN_MOV_R2_R1    ; runtime r2 = expression value
    load_32 r4, [37624]
    cmp r4, 12
    je V7_MATH_TEST_ZERO
    cmp r4, 13
    jne V7_MATH_EXECUTE
V7_MATH_TEST_ZERO:
    call E_GEN_TEST_R2_ZERO
V7_MATH_EXECUTE:
    load_32 r6, [37628]
    store_32 [36980], r6
    push r1
    call EMIT_LOAD_VAR      ; runtime r1 = destination old value
    load_32 r4, [37624]
    add r4, r4, 32         ; opcode for register-to-register
    lsl r4, r4, 8
    add r4, r4, 17         ; registers: dest r1 and src r1
    lsl r1, r4, 16
    or r1, r1, 512         ; src2 = r2 (byte 3 high nibble)
    call EMIT_WORD
    call EMIT_STORE_VAR
    pop r1
    jmp END_STATEMENT

; FOR A = 1 TO 10 [STEP 2] ; negative STEP supported
; Start and bound are expressions; STEP is nonzero U16 magnitude.
PARSE_FOR:
    call GET_UPPER
    cmp r1, 79
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 82
    jne COMPILE_SYNTAX
    call SKIP_SPACES
    call PARSE_VARIABLE
    load_32 r6, [36980]
    store_32 [37600], r6
    call SKIP_SPACES
    cmp r1, 61
    jne COMPILE_SYNTAX
    call SKIP_SPACES
    call E_EXPR             ; runtime r1 = start expression
    load_32 r6, [37600]
    store_32 [36980], r6
    push r1
    call EMIT_STORE_VAR
    pop r1
    cmp r1, 84              ; expect TO after start expression
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 79
    jne COMPILE_SYNTAX
    call SKIP_SPACES
    load_32 r4, [36968]
    store_32 [37004], r4   ; loop head: recalculate bound each iteration
    call E_EXPR             ; runtime r1 = bound
    call E_GEN_MOV_R2_R1    ; runtime r2 = bound
    load_32 r6, [37600]
    store_32 [36980], r6
    push r1
    call EMIT_LOAD_VAR      ; runtime r1 = loop variable
    mov r1, 10993           ; CMP r1,r2 = 0x2AF10200
    lsl r1, r1, 16
    or r1, r1, 512
    call EMIT_WORD
    pop r1
    mov r4, 1
    store_32 [37612], r4
    store_32 [37616], zr   ; ascending by default
    cmp r1, 83              ; optional STEP, word begins S
    jne V6_FOR_EMIT
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 80
    jne COMPILE_SYNTAX
    call SKIP_SPACES
    cmp r1, 45
    jne V6_FOR_STEP_NUMBER
    mov r4, 1
    store_32 [37616], r4
    call GET_CHAR

V6_FOR_STEP_NUMBER:
    call PARSE_NUMBER
    cmp r6, 0
    jne V6_FOR_STEP_GOOD
    jmp COMPILE_SYNTAX
V6_FOR_STEP_GOOD:
    store_32 [37612], r6
V6_FOR_EMIT:
    store_8 [37620], r1
    load_32 r6, [36968]
    store_32 [37020], r6
    load_32 r4, [37616]
    cmp r4, 0
    je V6_FOR_JG
    mov r1, 21519          ; JL exit for descending
    jmp V6_FOR_EMIT_BRANCH

V6_FOR_JG:
    mov r1, 23823     ; JG exit when ascending x > bound
V6_FOR_EMIT_BRANCH:
    lsl r1, r1, 16
    call EMIT_WORD
    mov r4, 3
    call PUSH_BLOCK
    call PEEK_BLOCK
    add r4, r5, 12
    load_32 r6, [37600]
    store_32 [r4], r6
    add r4, r4, 4
    store_32 [r4], zr
    add r4, r4, 4
    load_32 r6, [37612]
    load_32 r13, [37616]
    cmp r13, 0
    je V6_FOR_STEP_POSITIVE
    neg r6, r6
V6_FOR_STEP_POSITIVE:
    store_32 [r4], r6
    load_8 r1, [37620]
    jmp END_STATEMENT

PARSE_NEXT_HEAD:
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 88
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    call GET_CHAR
    call PEEK_BLOCK
    cmp r6, 3
    jne COMPILE_UNMATCHED
    ; NEXT or NEXT A: optional matching variable
    cmp r1, 32
    jne V6_NEXT_READY
    call SKIP_SPACES
V6_NEXT_READY:
    cmp r1, 65
    jb V6_NEXT_BUILD
    cmp r1, 90
    ja V6_NEXT_BUILD
    call PARSE_VARIABLE
    call PEEK_BLOCK
    add r4, r5, 12
    load_32 r4, [r4]
    load_32 r6, [36980]
    cmp r6, r4
    jne COMPILE_UNMATCHED
    call GET_CHAR
V6_NEXT_BUILD:
    store_8 [37620], r1
    ; CONTINUE at NEXT should jump to increment, not compare
    call PEEK_BLOCK
    add r4, r5, 28
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_CHAIN
    ; increment by positive or negative step
    call PEEK_BLOCK
    add r4, r5, 12
    load_32 r6, [r4]
    store_32 [36980], r6
    add r4, r4, 8
    load_32 r6, [r4]    ; signed step
    cmp r6, 0
    jl V6_NEXT_SUB
    mov r4, 13329       ; ADD r1,r1,imm
    jmp V6_NEXT_OP_READY
V6_NEXT_SUB:
    neg r6, r6
    mov r4, 13585       ; SUB r1,r1,imm
V6_NEXT_OP_READY:
    store_32 [37612], r6
    store_32 [37616], r4
    call EMIT_LOAD_VAR
    load_32 r4, [37616]
    lsl r1, r4, 16
    load_32 r6, [37612]
    or r1, r1, r6
    call EMIT_WORD
    call EMIT_STORE_VAR
    call PEEK_BLOCK
    add r4, r5, 8
    load_32 r6, [r4]
    mov r1, 22543
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    ; patch false branch and every BREAK to after NEXT code
    call PEEK_BLOCK
    add r4, r5, 4
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_TARGET
    call PEEK_BLOCK
    add r4, r5, 24
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_CHAIN
    call POP_BLOCK
    load_8 r1, [37620]
    jmp END_STATEMENT

; DO ... LOOP WHILE <condition> / LOOP UNTIL <condition>
PARSE_LOOP_BODY:
    call PEEK_BLOCK
    cmp r6, 4
    jne COMPILE_UNMATCHED
    cmp r1, 32
    jne V6_LOOP_MODE
    call SKIP_SPACES
V6_LOOP_MODE:
    cmp r1, 87      ; WHILE
    je V6_LOOP_WHILE
    cmp r1, 85      ; UNTIL
    je V6_LOOP_UNTIL
    jmp COMPILE_SYNTAX
V6_LOOP_WHILE:
    call GET_UPPER
    cmp r1, 72
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 76
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    mov r4, 1
    store_32 [37616], r4
    jmp V6_LOOP_CONDITION
V6_LOOP_UNTIL:
    call GET_UPPER
    cmp r1, 78
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 76
    jne COMPILE_SYNTAX
    mov r4, 2
    store_32 [37616], r4
V6_LOOP_CONDITION:
    ; CONTINUE goes to the condition at bottom of loop
    call PEEK_BLOCK
    add r4, r5, 28
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_CHAIN
    call PARSE_CONDITION
    store_8 [37620], r1
    call EMIT_BRANCH_FALSE
    load_32 r4, [37616]
    cmp r4, 2
    je V6_LOOP_UNTIL_PATCH
    ; while true: skip loop-head jump if condition false
    load_32 r4, [37020]
    store_32 [37640], r4
    call PEEK_BLOCK
    add r4, r5, 8
    load_32 r6, [r4]
    mov r1, 22543
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    load_32 r4, [37640]
    load_32 r6, [36968]
    call PATCH_TARGET
    jmp V6_LOOP_END_PATCH_BREAK
V6_LOOP_UNTIL_PATCH:
    call PEEK_BLOCK
    add r4, r5, 8
    load_32 r6, [r4]
    load_32 r4, [37020]
    call PATCH_TARGET
V6_LOOP_END_PATCH_BREAK:
    call PEEK_BLOCK
    add r4, r5, 24
    load_32 r4, [r4]
    load_32 r6, [36968]
    call PATCH_CHAIN
    call POP_BLOCK
    load_8 r1, [37620]
    jmp END_STATEMENT

; BREAK / CONTINUE affect the nearest enclosing loop even inside IF.
PARSE_BREAK_HEAD:
    call GET_UPPER
    cmp r1, 82
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 65
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 75
    jne COMPILE_SYNTAX
    call GET_CHAR
    mov r13, 24
    jmp V6_LINK_JUMP
PARSE_CONTINUE_HEAD:
    call GET_UPPER
    cmp r1, 79
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 78
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 84
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 73
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 78
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 85
    jne COMPILE_SYNTAX
    call GET_UPPER
    cmp r1, 69
    jne COMPILE_SYNTAX
    call GET_CHAR
    mov r13, 28
V6_LINK_JUMP:
    store_8 [37620], r1
    store_32 [37636], r13
    call V6_FIND_LOOP
    cmp r6, 0
    je COMPILE_UNMATCHED
    load_32 r13, [37636]
    add r5, r5, r13
    load_32 r6, [r5]   ; previous JMP site, or zero
    store_32 [37632], r5
    load_32 r4, [36968]
    store_32 [37628], r4
    mov r1, 22543
    lsl r1, r1, 16
    or r1, r1, r6
    call EMIT_WORD
    load_32 r4, [37628]
    load_32 r5, [37632]
    store_32 [r5], r4
    load_8 r1, [37620]
    jmp END_STATEMENT

; find nearest loop, returns r5 frame base, r6 type or 0
V6_FIND_LOOP:
    load_32 r13, [37000]
V6_FIND_LOOP_ITER:
    cmp r13, 0
    je V6_FIND_LOOP_NONE
    sub r13, r13, 1
    lsl r5, r13, 5
    add r5, r5, 37024
    load_32 r6, [r5]
    cmp r6, 2
    je V6_FIND_LOOP_FOUND
    cmp r6, 3
    je V6_FIND_LOOP_FOUND
    cmp r6, 4
    je V6_FIND_LOOP_FOUND
    jmp V6_FIND_LOOP_ITER
V6_FIND_LOOP_NONE:
    mov r6, 0
V6_FIND_LOOP_FOUND:
    ret

; r4=linked list head, r6=patch target. Link in JMP's immediate U16.
PATCH_CHAIN:
    push r1
    push r3
    push r4
    push r5
    push r6
    push r13
V6_PATCH_NEXT:
    cmp r4, 0
    je V6_PATCH_DONE
    mov r13, r4
    add r4, r13, 2
    load_8 r5, [r4]
    lsl r5, r5, 8
    add r4, r4, 1
    load_8 r3, [r4]
    or r5, r5, r3
    push r5
    mov r4, r13
    call PATCH_TARGET
    pop r4
    jmp V6_PATCH_NEXT
V6_PATCH_DONE:
    pop r13
    pop r6
    pop r5
    pop r4
    pop r3
    pop r1
    ret

ERROR_DIV_MSG:
    call MSG_DIV_ZERO
    jmp REFRESH
MSG_DIV_ZERO:
    mov r1, 68
    call TERM_CHAR
    mov r1, 73
    call TERM_CHAR
    mov r1, 86
    call TERM_CHAR
    mov r1, 32
    call TERM_CHAR
    mov r1, 90
    call TERM_CHAR
    mov r1, 69
    call TERM_CHAR
    mov r1, 82
    call TERM_CHAR
    mov r1, 79
    call TERM_CHAR
    ret
MSG_RUNTIME_DIV_ZERO:
    call TERM_NEWLINE
    call MSG_DIV_ZERO
    ret

; =============================================================
; V7 EXPRESSION PARSER / CODE GENERATOR
;
; Grammar:
; expr    := product ((+|-) product)*
; product := unary ((*|/|%) unary)*
; unary   := (+|-) unary | atom
; atom    := literal | variable | '(' expr ')'
;
; r1 is the current SOURCE lookahead upon entry AND exit.
; r3 is the SOURCE cursor, r7 source length.
; Runtime expression result is in r1; r2 is temporary.
; Runtime temporary values are pushed onto the CPU stack.
; Compile-time operator state is pushed onto compiler stack.
; Division by zero resets runtime SP before escaping back to Vim.
; Signed comparisons are unchanged. Division/modulo follow hardware.
; =============================================================
E_EXPR:
    call E_PRODUCT
E_EXPR_LOOP:
    call E_SKIP_WS
    cmp r1, 43               ; '+'
    je E_EXPR_OPERATOR
    cmp r1, 45               ; '-'
    je E_EXPR_OPERATOR
    ret
E_EXPR_OPERATOR:
    push r1                  ; compile-time operator
    call E_GEN_PUSH_R1       ; preserve runtime lhs
    call GET_CHAR
    call E_PRODUCT           ; runtime r1 = rhs
    call E_GEN_POP_R2        ; runtime r2 = lhs
    pop r4                   ; compile-time operator
    cmp r4, 45
    je E_EXPR_SUB
    mov r6, 9234             ; 0x2412 ADD r1,r2,r1
    jmp E_EXPR_EMIT
E_EXPR_SUB:
    mov r6, 9490             ; 0x2512 SUB r1,r2,r1
E_EXPR_EMIT:
    call E_GEN_BINARY
    jmp E_EXPR_LOOP

E_PRODUCT:
    call E_UNARY
E_PRODUCT_LOOP:
    call E_SKIP_WS
    cmp r1, 42               ; '*'
    je E_PRODUCT_OPERATOR
    cmp r1, 47               ; '/'
    je E_PRODUCT_OPERATOR
    cmp r1, 37               ; '%'
    je E_PRODUCT_OPERATOR
    ret
E_PRODUCT_OPERATOR:
    push r1
    call E_GEN_PUSH_R1
    call GET_CHAR
    call E_UNARY
    call E_GEN_POP_R2
    pop r4
    cmp r4, 42
    je E_PRODUCT_MULTIPLY
    call E_GEN_TEST_R1_ZERO
    cmp r4, 37
    je E_PRODUCT_MOD
    mov r6, 11282             ; 0x2C12 DIV r1,r2,r1
    jmp E_PRODUCT_EMIT
E_PRODUCT_MOD:
    mov r6, 11538             ; 0x2D12 MOD r1,r2,r1
    jmp E_PRODUCT_EMIT
E_PRODUCT_MULTIPLY:
    mov r6, 11026             ; 0x2B12 MUL r1,r2,r1
E_PRODUCT_EMIT:
    call E_GEN_BINARY
    jmp E_PRODUCT_LOOP

E_UNARY:
    call E_SKIP_WS
    cmp r1, 43
    je E_UNARY_POS
    cmp r1, 45
    je E_UNARY_NEG
    jmp E_ATOM
E_UNARY_POS:
    call GET_CHAR
    jmp E_UNARY
E_UNARY_NEG:
    call GET_CHAR
    call E_UNARY
    push r1
    mov r1, 9488              ; 0x2510 NEG r1,r1
    lsl r1, r1, 16
    or r1, r1, 256
    call EMIT_WORD
    pop r1
    ret

E_ATOM:
    call E_SKIP_WS
    cmp r1, 40                ; '('
    je E_ATOM_GROUP
    cmp r1, 48
    jb E_ATOM_BAD
    cmp r1, 57
    jbe E_ATOM_NUMBER
    cmp r1, 65
    jb E_ATOM_BAD
    cmp r1, 90
    ja E_ATOM_BAD
    call PARSE_VARIABLE
    call GET_CHAR
    push r1
    call EMIT_LOAD_VAR
    pop r1
    ret
E_ATOM_NUMBER:
    call E_NUMBER32
    push r1
    call E_GEN_CONST32
    pop r1
    ret
E_ATOM_GROUP:
    call GET_CHAR
    call E_EXPR
    call E_SKIP_WS
    cmp r1, 41                ; ')'
    jne E_ATOM_BAD
    call GET_CHAR
    ret
E_ATOM_BAD:
    mov r4, 1
    store_32 [36972], r4
    ret
E_SKIP_WS:
    cmp r1, 32
    jne E_SKIP_DONE
    call GET_UPPER
    jmp E_SKIP_WS
E_SKIP_DONE:
    call TO_UPPER
    ret

; Generator helpers keep compiler r1 source lookahead untouched.
; Arithmetic reg format: opcode | dddd ssss | 0000 tttt | 0.
E_GEN_BINARY:
    push r1
    lsl r1, r6, 16
    or r1, r1, 256            ; source r1 in byte 3 low nibble
    call EMIT_WORD
    pop r1
    ret

E_GEN_PUSH_R1:
    push r1
    mov r1, 13806            ; 0x35EE0004 SUB sp,sp,4
    lsl r1, r1, 16
    or r1, r1, 4
    call EMIT_WORD
    mov r1, 26113            ; 0x66010E00 STORE_32 [sp],r1
    lsl r1, r1, 16
    or r1, r1, 3584
    call EMIT_WORD
    pop r1
    ret
E_GEN_POP_R2:
    push r1
    mov r1, 25120            ; 0x62200E00 LOAD_32 r2,[sp]
    lsl r1, r1, 16
    or r1, r1, 3584
    call EMIT_WORD
    mov r1, 13550            ; 0x34EE0004 ADD sp,sp,4
    lsl r1, r1, 16
    or r1, r1, 4
    call EMIT_WORD
    pop r1
    ret
E_GEN_MOV_R2_R1:
    push r1
    mov r1, 8480             ; 0x21200100 MOV r2,r1
    lsl r1, r1, 16
    or r1, r1, 256
    call EMIT_WORD
    pop r1
    ret
E_GEN_TEST_R1_ZERO:
    push r1
    mov r1, 15089            ; 0x3AF10000 CMP r1,0
    lsl r1, r1, 16
    call EMIT_WORD
    mov r1, 20751            ; 0x510FXXXX JE RUN_DIV_ZERO
    lsl r1, r1, 16
    mov r6, RUN_DIV_ZERO
    or r1, r1, r6
    call EMIT_WORD
    pop r1
    ret
E_GEN_TEST_R2_ZERO:
    push r1
    mov r1, 15090            ; 0x3AF20000 CMP r2,0
    lsl r1, r1, 16
    call EMIT_WORD
    mov r1, 20751            ; 0x510FXXXX JE RUN_DIV_ZERO
    lsl r1, r1, 16
    mov r6, RUN_DIV_ZERO
    or r1, r1, r6
    call EMIT_WORD
    pop r1
    ret

; Parse a full unsigned 32-bit decimal literal (0..4294967295).
E_NUMBER32:
    mov r6, 0
E_NUMBER32_LOOP:
    cmp r1, 48
    jb E_NUMBER32_DONE
    cmp r1, 57
    ja E_NUMBER32_DONE
    sub r4, r1, 48
    mov r5, 6553           ; upper half of floor(0xFFFFFFFF / 10)
    lsl r5, r5, 16
    or r5, r5, 39321       ; r5 = 0x19999999
    cmp r6, r5
    ja E_NUMBER32_OVER
    jne E_NUMBER32_SAFE
    cmp r4, 5
    ja E_NUMBER32_OVER
E_NUMBER32_SAFE:
    lsl r5, r6, 3
    lsl r6, r6, 1
    add r6, r6, r5
    add r6, r6, r4
    call GET_CHAR
    jmp E_NUMBER32_LOOP
E_NUMBER32_OVER:
    mov r4, 2
    store_32 [36972], r4
E_NUMBER32_DONE:
    ret

; Emit full 32-bit literal in native instructions to runtime r1.
E_GEN_CONST32:
    lsr r5, r6, 16
    cmp r5, 0
    jne E_GEN_CONST32_WIDE
    call EMIT_MOV_R1
    ret
E_GEN_CONST32_WIDE:
    push r6
    mov r6, r5
    call EMIT_MOV_R1
    pop r6
    mov r1, 14097         ; LSL r1,r1,16 : 0x37110010
    lsl r1, r1, 16
    or r1, r1, 16
    call EMIT_WORD
    mov r1, 12561         ; OR r1,r1,imm : 0x3111xxxx
    lsl r1, r1, 16
    and r6, r6, 65535
    or r1, r1, r6
    call EMIT_WORD
    ret
