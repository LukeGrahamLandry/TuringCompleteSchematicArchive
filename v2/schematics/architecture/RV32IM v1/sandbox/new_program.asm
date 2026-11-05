//============================================
// Test 1: Basic Integer ALU Instructions
//============================================
tail test_alu


U32 0x11223344
U32 0xaabbccdd

@0x0000_0030
test_alu:
    addi x5,  x0, 5        // x5 = 5
    addi x6,  x0, -3       // x6 = 0xFFFFFFFD (-3)

    add  x7,  x5, x6       // x7 = 2
    sub  x8,  x5, x6       // x8 = 8
    and  x9,  x5, x6       // x9 = 5
    or   x10, x5, x6       // x10 = 0xFFFFFFFD (-3)
    xor  x11, x5, x6       // x11 = 0xFFFFFFF8 (-8)

    slt  x12, x6, x5       // x12 = 1   (signed: -3 < 5)
    sltu x13, x6, x5       // x13 = 0   (unsigned: 0xFFFFFFFD > 5)

    slti  x14, x5, 10      // x14 = 1   (5 < 10)
    sltiu x15, x6, 1       // x15 = 0   (0xFFFFFFFD > 1)

    andi x16, x6, 0xFF     // x16 = 0x000000FD (253)
    ori  x17, x5, 0xF0     // x17 = 0x000000F5
    xori x18, x5, -1       // x18 = 0xFFFFFFFA (-6)
    
    
    
    