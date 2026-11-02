mov sp, -1

loop:
in r1
cmp r1, 0
je output

store_32 [sp], r1
sub sp, sp, 4
jmp loop

output:
add sp, sp, 4
load_32 r3, [sp]
out r3
jmp loop