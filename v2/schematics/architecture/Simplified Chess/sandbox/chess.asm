const SCREEN_ADDRESS = 0x0000040
const BOARD = 0x00000000

const ARROW_UP = 193
const ARROW_RIGHT = 210
const ARROW_DOWN = 209
const ARROW_LEFT = 208
const ENTER = 60

const SCREEN_WIDTH = 88
const SCREEN_WIDTH_8 = 704

mov r1, 2
screen zr, r1
mov r2, 21
screen r1, r2
mov r1, SCREEN_ADDRESS
mov r2, 1
screen r2, r1

start:
mov r1, BOARD
mov r2, 0x8D83
movt r2, r2
movb r2, 0x8486
store_32 [r1], r2
add r1, r1, 4
mov r2, 0x8984
movt r2, r2
movb r2, 0x838D
store_32 [r1], r2
add r1, r1, 4
mov r2, 0x8A8A
movt r2, r2
movb r2, 0x8A8A
store_32 [r1], r2
add r1, r1, 4
store_32 [r1], r2
add r1, r1, 4
mov r4, 8
empty_loop:
store_32 [r1], zr
add r1, r1, 4
dec r4
cmp r4, 0
jne empty_loop
mov r2, 0x0A0A
movt r2, r2
movb r2, 0x0A0A
store_32 [r1], r2
add r1, r1, 4
store_32 [r1], r2
add r1, r1, 4
mov r2, 0x0D03
movt r2, r2
movb r2, 0x0406
store_32 [r1], r2
add r1, r1, 4
mov r2, 0x0904
movt r2, r2
movb r2, 0x030D
store_32 [r1], r2

game_loop:
    mov r4, 0
    mov r5, 0
    mov r6, 0
    mov r7, 0
    mov r8, 0
    mov r9, 0
    mov r10, 0

main_loop:
    call draw_board

    mov r11, r4
    mov r12, r5
    call paint_cell_blue

    cmp r6, 0
    je skip_selected_highlight
    mov r11, r7
    mov r12, r8
    call paint_cell_blue
skip_selected_highlight:

get_keyboard:
    keyboard r1
    cmp r1, 0
    je get_keyboard
    and r2, r1, 0b000000001
    cmp r2, 0
    je get_keyboard

    mov r2, r1
    lsr r2, r2, 1

    cmp r2, ARROW_UP
    je key_up
    cmp r2, ARROW_RIGHT
    je key_right
    cmp r2, ARROW_DOWN
    je key_down
    cmp r2, ARROW_LEFT
    je key_left
    cmp r2, ENTER
    je key_enter

    jmp main_loop

key_up:
    cmp r5, 0
    je main_loop
    dec r5
    jmp main_loop

key_right:
    cmp r4, 7
    je main_loop
    inc r4
    jmp main_loop

key_down:
    cmp r5, 7
    je main_loop
    inc r5
    jmp main_loop

key_left:
    cmp r4, 0
    je main_loop
    dec r4
    jmp main_loop

key_enter:
    cmp r6, 0
    je select_piece

    mov r1, r4
    cmp r1, r7
    jne maybe_reselect
    mov r1, r5
    cmp r1, r8
    je deselect_piece

maybe_reselect:
    mov r1, r4
    mov r2, r5
    call get_piece_at_xy
    mov r13, r3
    cmp r13, 0
    je attempt_move
    mov r1, r13
    lsr r1, r1, 7
    cmp r1, r9
    je reselect_piece

attempt_move:
    mov r1, r4
    mov r2, r5
    call get_piece_at_xy
    mov r13, r3

    cmp r13, 0
    je destination_ok
    mov r1, r13
    lsr r1, r1, 7
    mov r2, r10
    lsr r2, r2, 7
    cmp r1, r2
    je main_loop
destination_ok:
    mov r2, r10
    and r2, r2, 0b111

    cmp r2, 2
    je move_pawn
    cmp r2, 3
    je move_knight
    cmp r2, 4
    je move_bishop
    cmp r2, 5
    je move_rook
    cmp r2, 6
    je move_queen
    cmp r2, 1
    je move_king

    jmp main_loop

select_piece:
    mov r1, r4
    mov r2, r5
    call get_piece_at_xy
    cmp r3, 0
    je main_loop

    mov r1, r3
    lsr r1, r1, 7
    cmp r1, r9
    jne main_loop

    mov r6, 1
    mov r7, r4
    mov r8, r5
    mov r10, r3
    jmp main_loop

reselect_piece:
    mov r6, 1
    mov r7, r4
    mov r8, r5
    mov r10, r13
    jmp main_loop

deselect_piece:
    mov r6, 0
    mov r10, 0
    jmp main_loop


move_pawn:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    mov r3, r10
    lsr r3, r3, 7
    cmp r3, 0
    je pawn_white
    jmp pawn_black

pawn_white:
    cmp r1, 0
    je pawn_white_file
    cmp r1, 1
    je pawn_white_diag
    neg r1, r1
    cmp r1, 1
    je pawn_white_diag
    jmp main_loop

pawn_white_file:
    cmp r13, 0
    jne main_loop
    
    neg r2, r2

    cmp r2, 1
    je pawn_ok_single

    cmp r2, 2
    jne main_loop
    cmp r8, 6
    jne main_loop

    mov r3, r10
    and r3, r3, 0b00001000
    cmp r3, 0b00001000
    jne main_loop

    mov r1, r7
    mov r2, r8
    dec r2
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop

    mov r11, 0
    jmp apply_move

pawn_ok_single:
    mov r11, 0
    jmp apply_move

pawn_white_diag:
    neg r2, r2
    cmp r2, 1
    jne main_loop

    cmp r13, 0
    jne pawn_ok_single

    mov r1, r4
    mov r2, r8
    call get_piece_at_xy

    cmp r3, 0
    je main_loop
    mov r1, r3
    and r1, r1, 0b111
    cmp r1, 2
    jne main_loop

    mov r1, r3
    lsr r1, r1, 7
    cmp r1, 1
    jne main_loop

    mov r1, r3
    and r1, r1, 0b01111000
    cmp r1, 0b00010000
    jne main_loop

    mov r11, 1
    jmp apply_move

pawn_black:
    cmp r1, 0
    je pawn_black_file
    cmp r1, 1
    je pawn_black_diag
    neg r1, r1
    cmp r1, 1
    je pawn_black_diag
    jmp main_loop

pawn_black_file:
    cmp r13, 0
    jne main_loop

    cmp r2, 1
    je pawn_black_single

    cmp r2, 2
    jne main_loop
    cmp r8, 1
    jne main_loop

    mov r3, r10
    and r3, r3, 0b00001000
    cmp r3, 0b00001000
    jne main_loop

    mov r1, r7
    mov r2, r8
    inc r2
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop

    mov r11, 0
    jmp apply_move

pawn_black_single:
    mov r11, 0
    jmp apply_move

pawn_black_diag:
    cmp r2, 1
    jne main_loop

    cmp r13, 0
    jne pawn_black_capture

    mov r1, r4
    mov r2, r8
    call get_piece_at_xy

    cmp r3, 0
    je main_loop
    mov r1, r3
    and r1, r1, 0b111
    cmp r1, 2
    jne main_loop

    mov r1, r3
    lsr r1, r1, 7
    cmp r1, 0
    jne main_loop

    mov r1, r3
    and r1, r1, 0b01111000
    cmp r1, 0b00010000
    jne main_loop

    mov r11, 1
    jmp apply_move

pawn_black_capture:
    mov r11, 0
    jmp apply_move


move_knight:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    cmp r1, 1
    je knight_dy_two	
    cmp r1, 2
    je knight_dy_one
    neg r1, r1
    cmp r1, 1
    je knight_dy_two
    cmp r1, 2
    je knight_dy_one
    jmp main_loop

knight_dy_two:
    cmp r2, 2
    je knight_ok
    neg r2, r2
    cmp r2, 2
    je knight_ok
    jmp main_loop

knight_dy_one:
    cmp r2, 1
    je knight_ok
    neg r2, r2
    cmp r2, 1
    je knight_ok
    jmp main_loop

knight_ok:
    mov r11, 0
    jmp apply_move


move_bishop:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    mov r11, r1
    cmp r11, 0
    jge bishop_abs_x_done
    neg r11, r11
bishop_abs_x_done:

    mov r12, r2
    cmp r12, 0
    jge bishop_abs_y_done
    neg r12, r12
bishop_abs_y_done:

    cmp r11, r12
    jne main_loop
    cmp r11, 0
    je main_loop

    mov r11, r1
    cmp r11, 0
    mov r11, 1
    jg bishop_step_x_done
    neg r11, r11
bishop_step_x_done:

    mov r12, r2
    cmp r12, 0
    mov r12, 1
    jg bishop_step_y_done
    neg r12, r12
bishop_step_y_done:

    mov r1, r7
    mov r2, r8

bishop_path_loop:
    add r1, r1, r11
    add r2, r2, r12

    cmp r1, r4
    jne bishop_check_cell
    cmp r2, r5
    je bishop_ok

bishop_check_cell:
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop
    jmp bishop_path_loop

bishop_ok:
    mov r11, 0
    jmp apply_move


move_rook:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    cmp r1, 0
    je rook_vertical
    cmp r2, 0
    je rook_horizontal
    jmp main_loop

rook_vertical:
    cmp r2, 0
    je main_loop

    mov r11, 0
    mov r12, 1
    jg rook_v_step_done
    neg r12, r12
rook_v_step_done:
    mov r1, r7
    mov r2, r8

rook_v_loop:
    add r2, r2, r12
    cmp r2, r5
    je rook_ok
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop
    jmp rook_v_loop

rook_horizontal:
    cmp r1, 0
    je main_loop

    mov r12, 0
    mov r11, 1
    jg rook_h_step_done
    neg r11, r11
rook_h_step_done:
    mov r1, r7
    mov r2, r8

rook_h_loop:
    add r1, r1, r11
    cmp r1, r4
    je rook_ok
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop
    jmp rook_h_loop

rook_ok:
    mov r11, 0
    jmp apply_move


move_queen:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    cmp r1, 0
    je move_rook
    cmp r2, 0
    je move_rook

    mov r3, 0
    sub r3, r3, r2

    cmp r1, r2
    je move_bishop
    cmp r1, r3
    je move_bishop
    jmp main_loop


move_king:
    mov r1, r4
    sub r1, r1, r7
    mov r2, r5
    sub r2, r2, r8

    mov r11, r1
    cmp r11, 0
    jge king_abs_x_done
    neg r11, r11
king_abs_x_done:

    mov r12, r2
    cmp r12, 0
    jge king_abs_y_done
    neg r12, r12
king_abs_y_done:
    cmp r2, 0
    jne king_normal

    cmp r13, 0
    jne king_normal

    mov r3, r10
    and r3, r3, 0b00001000
    cmp r3, 0b00001000
    jne king_normal

    cmp r7, 4
    jne king_normal

    cmp r1, 2
    je king_castle_kingside
    neg r1, r1
    cmp r1, 2
    je king_castle_queenside

king_normal:
    cmp r11, 1
    jg main_loop
    cmp r12, 1
    jg main_loop

    cmp r11, 0
    jne king_not_same_x
    cmp r12, 0
    je main_loop
king_not_same_x:

    mov r11, 0
    jmp apply_move

king_castle_kingside:
    mov r1, 5
    mov r2, r8
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop

    mov r1, 7
    mov r2, r8
    call get_piece_at_xy
    cmp r3, 0
    je main_loop
    mov r1, r3
    and r1, r1, 0b111
    cmp r1, 5
    jne main_loop
    mov r1, r3
    lsr r1, r1, 7
    mov r2, r10
    lsr r2, r2, 7
    cmp r1, r2
    jne main_loop
    mov r1, r3
    and r1, r1, 0b00001000
    cmp r1, 0b00001000
    jne main_loop

    mov r11, 2
    jmp apply_move

king_castle_queenside:
    mov r1, 3
    mov r2, r8
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop

    mov r1, 1
    mov r2, r8
    call get_piece_at_xy
    cmp r3, 0
    jne main_loop

    mov r1, 0
    mov r2, r8
    call get_piece_at_xy
    cmp r3, 0
    je main_loop
    mov r1, r3
    and r1, r1, 0b111
    cmp r1, 5
    jne main_loop
    mov r1, r3
    lsr r1, r1, 7
    mov r2, r10
    lsr r2, r2, 7
    cmp r1, r2
    jne main_loop
    mov r1, r3
    and r1, r1, 0b00001000
    cmp r1, 0b00001000
    jne main_loop

    mov r11, 3
    jmp apply_move


apply_move:
    mov r12, r9

    mov r2, r10
    and r2, r2, 0b111

    cmp r2, 2
    je build_pawn_piece
    cmp r2, 1
    je build_king_piece
    cmp r2, 5
    je build_rook_piece

    mov r1, r10
    jmp piece_ready

build_king_piece:
    mov r1, r10
    and r1, r1, 0b10000111
    jmp piece_ready

build_rook_piece:
    mov r1, r10
    and r1, r1, 0b10000111
    jmp piece_ready

build_pawn_piece:
    cmp r9, 0
    je pawn_white_promo_check
    cmp r5, 7
    je pawn_promote
    jmp pawn_pawn_check
pawn_white_promo_check:
    cmp r5, 0
    je pawn_promote

pawn_pawn_check:
    mov r2, r5
    sub r2, r2, r8
    cmp r2, 2
    je pawn_double
    neg r2, r2
    cmp r2, 2
    je pawn_double

    mov r1, r10
    and r1, r1, 0b10000111
    jmp piece_ready

pawn_double:
    mov r1, r10
    and r1, r1, 0b10000111
    add r1, r1, 0b00010000
    jmp piece_ready

pawn_promote:
    mov r1, r10
    and r1, r1, 0b10000000
    add r1, r1, 6
    jmp piece_ready

piece_ready:
    cmp r11, 1
    jne write_main_piece

    mov r2, r8
    lsl r2, r2, 3
    add r2, r2, BOARD
    add r2, r2, r4
    mov r3, 0
    store_8 [r2], r3

write_main_piece:
    mov r2, r5
    lsl r2, r2, 3
    add r2, r2, BOARD
    add r2, r2, r4
    store_8 [r2], r1

    mov r2, r8
    lsl r2, r2, 3
    add r2, r2, BOARD
    add r2, r2, r7
    mov r3, 0
    store_8 [r2], r3

    cmp r11, 2
    je castle_kingside
    cmp r11, 3
    je castle_queenside
    jmp after_special_moves

castle_kingside:
    mov r2, r8
    lsl r2, r2, 3
    add r2, r2, BOARD
    add r2, r2, 7
    load_8 r3, [r2]
    and r3, r3, 0b10000111
    mov r1, 0
    store_8 [r2], r1

    mov r1, r8
    lsl r1, r1, 3
    add r1, r1, BOARD
    add r1, r1, 5
    store_8 [r1], r3
    jmp after_special_moves

castle_queenside:
    mov r2, r8
    lsl r2, r2, 3
    add r2, r2, BOARD
    add r2, r2, 0
    load_8 r3, [r2]
    and r3, r3, 0b10000111
    mov r1, 0
    store_8 [r2], r1

    mov r1, r8
    lsl r1, r1, 3
    add r1, r1, BOARD
    add r1, r1, 3
    store_8 [r1], r3
    jmp after_special_moves

after_special_moves:
    mov r1, r13
    and r1, r1, 0b111
    cmp r1, 1
    je end

    cmp r12, 0
    je clear_row_3
    mov r2, 4
    jmp clear_row_start
clear_row_3:
    mov r2, 3

clear_row_start:
    mov r1, 0
clear_row_loop:
    mov r3, r2
    lsl r3, r3, 3
    add r3, r3, BOARD
    add r3, r3, r1
    load_8 r3, [r3]

    mov r11, r3
    and r11, r11, 0b111
    cmp r11, 2
    jne clear_row_skip

    and r3, r3, 0b10000111
    mov r11, r2
    lsl r11, r11, 3
    add r11, r11, BOARD
    add r11, r11, r1
    store_8 [r11], r3

clear_row_skip:
    inc r1
    cmp r1, 8
    jne clear_row_loop

    cmp r12, 0
    je set_turn_black
    mov r9, 0
    jmp turn_done
set_turn_black:
    mov r9, 1

turn_done:
    mov r6, 0
    mov r10, 0
    jmp main_loop

get_piece_at_xy:
    mov r3, r2
    lsl r3, r3, 3
    add r3, r3, BOARD
    add r3, r3, r1
    load_8 r3, [r3]
    ret
    jmp main_loop


paint_cell_blue:
    mov r1, SCREEN_ADDRESS
    
    push r11
    push r12
    push r13

    mov r2, r12
    lsl r2, r2, 9
    add r1, r1, r2

    lsr r2, r2, 2
    add r1, r1, r2

    lsr r2, r2, 1
    add r1, r1, r2

    mov r2, r11
    lsl r2, r2, 3
    add r1, r1, r2

    mov r13, 8
    
    mov r3, 0x7777
    movt r3, r3
    movb r3, 0x7777
paint_cell_blue_row_loop:
    
    load_32 r2, [r1]
    and r2, r2, r3
    store_32 [r1], r2
    add r1, r1, 4

    load_32 r2, [r1]
    and r2, r2, r3
    store_32 [r1], r2

    sub r1, r1, 4
    add r1, r1, SCREEN_WIDTH

    dec r13
    cmp r13, 0
    jne paint_cell_blue_row_loop
    
    pop r13
    pop r12
    pop r11
    
    ret

draw_board:
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    mov r4, BOARD
    mov r5, SCREEN_ADDRESS
    mov r6, 8

board_row_loop:
    mov r7, 8
    mov r8, r5

board_col_loop:
    load_8 r9, [r4]
    cmp r9, 0
    jne not_empty
    
    lsr r3, r4, 3
    and r3, r3, 1
    and r1, r4, 1
    xor r1, r3, r1
    lsl r9, r1, 7
    
not_empty:

    mov r12, r9
    and r11, r12, 0b111
    lsr r12, r12, 7
    lsl r11, r11, 1
    add r11, r11, r12
    lsl r11, r11, 6

    mov r10, r11
    mov r11, r8
    mov r13, 8

piece_row_loop:
    pload r1, [r10]
    store_32 [r11], r1
    add r10, r10, 4
    pload r2, [r10]
    add r11, r11, 4
    store_32 [r11], r2

    add r10, r10, 4
    sub r11, r11, 4
    add r11, r11, SCREEN_WIDTH
    dec r13
    cmp r13, 0
    jne piece_row_loop

tile_done:
    inc r4
    add r8, r8, 8
    dec r7
    cmp r7, 0
    jne board_col_loop

    add r5, r5, SCREEN_WIDTH_8
    dec r6
    cmp r6, 0
    jne board_row_loop
    
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4

    ret
    
end:
call draw_board
time_0 r1
time_1 r1
add r1, r1, 1
wait:
time_0 r2
time_1 r2
cmp r1, r2
jae wait
jmp start