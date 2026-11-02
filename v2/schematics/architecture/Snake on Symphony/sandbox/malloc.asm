

;malloc will push all registers it uses, except return values

;simple array malloc
;no fragment protection or defrag
;no overflow protection

;a malloc call returns a pointer, 0 if failed
;malloc requires its own address space, will designate 0x0001 0000 to 0x0001 ffff
;stack grows down from top, dynamic allocation grows up from 0x0002 0000
;no os, so malloc controls all memory. no need to worry about other programs

;allocated list: 32 bit size, 32 bit pointer to alloc memory,
;	64 bits / 8 bytes total per item

const malloc_list_start = 0x00010000
const malloc_list_size = 0x00010000

const malloc_entry_size = 8 ;in bytes



test_malloc:
mov r1, 16
call malloc
mov r2, !0xf23a02f1

store_32 [r1], r2
add r1, r1, 4
store_32 [r1], r2
add r1, r1, 4
store_32 [r1], r2
add r1, r1, 4
store_32 [r1], r2

mov r1, 1
call malloc
mov r2, 0xff
store_8 [r1], r2

mov r1, 4
call malloc
jmp test_malloc


;returns pointer to last entry in r1
get_end_of_list:
push r2

;while arr[i] != 0
mov r1, !malloc_list_start ;start of list
traverse_loop:
load_32 r2, [r1]
cmp r2, 0
add r1, r1, malloc_entry_size ;next entry
jmpif neq, traverse_loop ;if size is 0, empty entry, end found
sub r1, r1, 16 ;current entry is empty so get last entry

pop r2
ret




;takes size in r1, in bytes
;returns pointer in r1
pub malloc:
cmp r1, 0
jmpif neq, malloc_size_checked
ret ;early return 0 since can't alloc 0 bytes

malloc_size_checked:
push r2
push r3
push r4

push r1

call get_end_of_list

load_32 r2, [r1] ;get size
cmp r2, 0
jmpif neq, malloc_start_list_checked
;no first entry, allocate malloc as first entry

mov r2, !malloc_list_size
store_32 [r1], r2
add r1, r1, 4 ;malloc pointer
mov r3, !malloc_list_start
store_32 [r1], r3 ;malloc allocated
sub r1, r1, 4 ;back to start of entry

malloc_start_list_checked:
add r1, r1, 4 ;pointer
load_32 r3, [r1] ;get pointer

pop r4 ;alloc size
add r3, r3, r2 ;new pointer, last pointer plus last size
add r1, r1, 4 ;next entry in list, empty
store_32 [r1], r4 ;store size
add r1, r1, 4 ;pointer entry
store_32 [r1], r3 ;store pointer

mov r1, r3 ;return pointer

pop r4
pop r3
pop r2
ret

















