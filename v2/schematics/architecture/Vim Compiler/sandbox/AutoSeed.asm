; ============================================================
; Symphony BASIC V7 SSD Seeder (run this ALONE first)
; Writes TWO compatible SSD slots using native pstore/pload.
; SSD address units = bytes. Keep the SSD connected when
; switching back to Symphony_Vim_Compiler_V7.asm.
; Slot A = 0, Slot B = 16416. Each payload starts at +16.
; V7: magic 29510, generations 1/2, checksum = XOR(shift).
; Main RAM text scratch = 28672.
; Output 501 = successful write and byte-by-byte verification.
; Output 598 = persistent readback mismatch.
; ============================================================

START:
    mov sp, 15625
    lsl sp, sp, 6
    mov r7, 254
    ; Write BASIC content as bytes into Main RAM.
    mov r1, 59
    store_8 [28672], r1
    mov r1, 32
    store_8 [28673], r1
    mov r1, 86
    store_8 [28674], r1
    mov r1, 55
    store_8 [28675], r1
    mov r1, 32
    store_8 [28676], r1
    mov r1, 83
    store_8 [28677], r1
    mov r1, 83
    store_8 [28678], r1
    mov r1, 68
    store_8 [28679], r1
    mov r1, 32
    store_8 [28680], r1
    mov r1, 65
    store_8 [28681], r1
    mov r1, 85
    store_8 [28682], r1
    mov r1, 84
    store_8 [28683], r1
    mov r1, 79
    store_8 [28684], r1
    mov r1, 32
    store_8 [28685], r1
    mov r1, 84
    store_8 [28686], r1
    mov r1, 69
    store_8 [28687], r1
    mov r1, 83
    store_8 [28688], r1
    mov r1, 84
    store_8 [28689], r1
    mov r1, 10
    store_8 [28690], r1
    mov r1, 76
    store_8 [28691], r1
    mov r1, 69
    store_8 [28692], r1
    mov r1, 84
    store_8 [28693], r1
    mov r1, 32
    store_8 [28694], r1
    mov r1, 65
    store_8 [28695], r1
    mov r1, 32
    store_8 [28696], r1
    mov r1, 61
    store_8 [28697], r1
    mov r1, 32
    store_8 [28698], r1
    mov r1, 53
    store_8 [28699], r1
    mov r1, 10
    store_8 [28700], r1
    mov r1, 76
    store_8 [28701], r1
    mov r1, 69
    store_8 [28702], r1
    mov r1, 84
    store_8 [28703], r1
    mov r1, 32
    store_8 [28704], r1
    mov r1, 66
    store_8 [28705], r1
    mov r1, 32
    store_8 [28706], r1
    mov r1, 61
    store_8 [28707], r1
    mov r1, 32
    store_8 [28708], r1
    mov r1, 51
    store_8 [28709], r1
    mov r1, 10
    store_8 [28710], r1
    mov r1, 80
    store_8 [28711], r1
    mov r1, 82
    store_8 [28712], r1
    mov r1, 73
    store_8 [28713], r1
    mov r1, 78
    store_8 [28714], r1
    mov r1, 84
    store_8 [28715], r1
    mov r1, 32
    store_8 [28716], r1
    mov r1, 40
    store_8 [28717], r1
    mov r1, 65
    store_8 [28718], r1
    mov r1, 32
    store_8 [28719], r1
    mov r1, 43
    store_8 [28720], r1
    mov r1, 32
    store_8 [28721], r1
    mov r1, 66
    store_8 [28722], r1
    mov r1, 41
    store_8 [28723], r1
    mov r1, 32
    store_8 [28724], r1
    mov r1, 42
    store_8 [28725], r1
    mov r1, 32
    store_8 [28726], r1
    mov r1, 40
    store_8 [28727], r1
    mov r1, 65
    store_8 [28728], r1
    mov r1, 32
    store_8 [28729], r1
    mov r1, 45
    store_8 [28730], r1
    mov r1, 32
    store_8 [28731], r1
    mov r1, 66
    store_8 [28732], r1
    mov r1, 41
    store_8 [28733], r1
    mov r1, 10
    store_8 [28734], r1
    mov r1, 80
    store_8 [28735], r1
    mov r1, 82
    store_8 [28736], r1
    mov r1, 73
    store_8 [28737], r1
    mov r1, 78
    store_8 [28738], r1
    mov r1, 84
    store_8 [28739], r1
    mov r1, 32
    store_8 [28740], r1
    mov r1, 49
    store_8 [28741], r1
    mov r1, 48
    store_8 [28742], r1
    mov r1, 48
    store_8 [28743], r1
    mov r1, 32
    store_8 [28744], r1
    mov r1, 47
    store_8 [28745], r1
    mov r1, 32
    store_8 [28746], r1
    mov r1, 40
    store_8 [28747], r1
    mov r1, 50
    store_8 [28748], r1
    mov r1, 32
    store_8 [28749], r1
    mov r1, 43
    store_8 [28750], r1
    mov r1, 32
    store_8 [28751], r1
    mov r1, 51
    store_8 [28752], r1
    mov r1, 41
    store_8 [28753], r1
    mov r1, 10
    store_8 [28754], r1
    mov r1, 80
    store_8 [28755], r1
    mov r1, 82
    store_8 [28756], r1
    mov r1, 73
    store_8 [28757], r1
    mov r1, 78
    store_8 [28758], r1
    mov r1, 84
    store_8 [28759], r1
    mov r1, 32
    store_8 [28760], r1
    mov r1, 49
    store_8 [28761], r1
    mov r1, 48
    store_8 [28762], r1
    mov r1, 48
    store_8 [28763], r1
    mov r1, 32
    store_8 [28764], r1
    mov r1, 37
    store_8 [28765], r1
    mov r1, 32
    store_8 [28766], r1
    mov r1, 55
    store_8 [28767], r1
    mov r1, 10
    store_8 [28768], r1
    mov r1, 73
    store_8 [28769], r1
    mov r1, 70
    store_8 [28770], r1
    mov r1, 32
    store_8 [28771], r1
    mov r1, 65
    store_8 [28772], r1
    mov r1, 32
    store_8 [28773], r1
    mov r1, 42
    store_8 [28774], r1
    mov r1, 32
    store_8 [28775], r1
    mov r1, 66
    store_8 [28776], r1
    mov r1, 32
    store_8 [28777], r1
    mov r1, 62
    store_8 [28778], r1
    mov r1, 61
    store_8 [28779], r1
    mov r1, 32
    store_8 [28780], r1
    mov r1, 49
    store_8 [28781], r1
    mov r1, 50
    store_8 [28782], r1
    mov r1, 32
    store_8 [28783], r1
    mov r1, 84
    store_8 [28784], r1
    mov r1, 72
    store_8 [28785], r1
    mov r1, 69
    store_8 [28786], r1
    mov r1, 78
    store_8 [28787], r1
    mov r1, 10
    store_8 [28788], r1
    mov r1, 32
    store_8 [28789], r1
    mov r1, 32
    store_8 [28790], r1
    mov r1, 32
    store_8 [28791], r1
    mov r1, 32
    store_8 [28792], r1
    mov r1, 80
    store_8 [28793], r1
    mov r1, 82
    store_8 [28794], r1
    mov r1, 73
    store_8 [28795], r1
    mov r1, 78
    store_8 [28796], r1
    mov r1, 84
    store_8 [28797], r1
    mov r1, 32
    store_8 [28798], r1
    mov r1, 49
    store_8 [28799], r1
    mov r1, 10
    store_8 [28800], r1
    mov r1, 69
    store_8 [28801], r1
    mov r1, 76
    store_8 [28802], r1
    mov r1, 83
    store_8 [28803], r1
    mov r1, 69
    store_8 [28804], r1
    mov r1, 10
    store_8 [28805], r1
    mov r1, 32
    store_8 [28806], r1
    mov r1, 32
    store_8 [28807], r1
    mov r1, 32
    store_8 [28808], r1
    mov r1, 32
    store_8 [28809], r1
    mov r1, 80
    store_8 [28810], r1
    mov r1, 82
    store_8 [28811], r1
    mov r1, 73
    store_8 [28812], r1
    mov r1, 78
    store_8 [28813], r1
    mov r1, 84
    store_8 [28814], r1
    mov r1, 32
    store_8 [28815], r1
    mov r1, 48
    store_8 [28816], r1
    mov r1, 10
    store_8 [28817], r1
    mov r1, 69
    store_8 [28818], r1
    mov r1, 78
    store_8 [28819], r1
    mov r1, 68
    store_8 [28820], r1
    mov r1, 73
    store_8 [28821], r1
    mov r1, 70
    store_8 [28822], r1
    mov r1, 10
    store_8 [28823], r1
    mov r1, 70
    store_8 [28824], r1
    mov r1, 79
    store_8 [28825], r1
    mov r1, 82
    store_8 [28826], r1
    mov r1, 32
    store_8 [28827], r1
    mov r1, 67
    store_8 [28828], r1
    mov r1, 32
    store_8 [28829], r1
    mov r1, 61
    store_8 [28830], r1
    mov r1, 32
    store_8 [28831], r1
    mov r1, 49
    store_8 [28832], r1
    mov r1, 32
    store_8 [28833], r1
    mov r1, 84
    store_8 [28834], r1
    mov r1, 79
    store_8 [28835], r1
    mov r1, 32
    store_8 [28836], r1
    mov r1, 52
    store_8 [28837], r1
    mov r1, 10
    store_8 [28838], r1
    mov r1, 32
    store_8 [28839], r1
    mov r1, 32
    store_8 [28840], r1
    mov r1, 32
    store_8 [28841], r1
    mov r1, 32
    store_8 [28842], r1
    mov r1, 80
    store_8 [28843], r1
    mov r1, 82
    store_8 [28844], r1
    mov r1, 73
    store_8 [28845], r1
    mov r1, 78
    store_8 [28846], r1
    mov r1, 84
    store_8 [28847], r1
    mov r1, 32
    store_8 [28848], r1
    mov r1, 67
    store_8 [28849], r1
    mov r1, 32
    store_8 [28850], r1
    mov r1, 42
    store_8 [28851], r1
    mov r1, 32
    store_8 [28852], r1
    mov r1, 67
    store_8 [28853], r1
    mov r1, 10
    store_8 [28854], r1
    mov r1, 78
    store_8 [28855], r1
    mov r1, 69
    store_8 [28856], r1
    mov r1, 88
    store_8 [28857], r1
    mov r1, 84
    store_8 [28858], r1
    mov r1, 32
    store_8 [28859], r1
    mov r1, 67
    store_8 [28860], r1
    mov r1, 10
    store_8 [28861], r1
    mov r1, 76
    store_8 [28862], r1
    mov r1, 69
    store_8 [28863], r1
    mov r1, 84
    store_8 [28864], r1
    mov r1, 32
    store_8 [28865], r1
    mov r1, 68
    store_8 [28866], r1
    mov r1, 32
    store_8 [28867], r1
    mov r1, 61
    store_8 [28868], r1
    mov r1, 32
    store_8 [28869], r1
    mov r1, 48
    store_8 [28870], r1
    mov r1, 10
    store_8 [28871], r1
    mov r1, 87
    store_8 [28872], r1
    mov r1, 72
    store_8 [28873], r1
    mov r1, 73
    store_8 [28874], r1
    mov r1, 76
    store_8 [28875], r1
    mov r1, 69
    store_8 [28876], r1
    mov r1, 32
    store_8 [28877], r1
    mov r1, 68
    store_8 [28878], r1
    mov r1, 32
    store_8 [28879], r1
    mov r1, 60
    store_8 [28880], r1
    mov r1, 32
    store_8 [28881], r1
    mov r1, 51
    store_8 [28882], r1
    mov r1, 10
    store_8 [28883], r1
    mov r1, 32
    store_8 [28884], r1
    mov r1, 32
    store_8 [28885], r1
    mov r1, 32
    store_8 [28886], r1
    mov r1, 32
    store_8 [28887], r1
    mov r1, 80
    store_8 [28888], r1
    mov r1, 82
    store_8 [28889], r1
    mov r1, 73
    store_8 [28890], r1
    mov r1, 78
    store_8 [28891], r1
    mov r1, 84
    store_8 [28892], r1
    mov r1, 32
    store_8 [28893], r1
    mov r1, 68
    store_8 [28894], r1
    mov r1, 32
    store_8 [28895], r1
    mov r1, 43
    store_8 [28896], r1
    mov r1, 32
    store_8 [28897], r1
    mov r1, 50
    store_8 [28898], r1
    mov r1, 48
    store_8 [28899], r1
    mov r1, 10
    store_8 [28900], r1
    mov r1, 32
    store_8 [28901], r1
    mov r1, 32
    store_8 [28902], r1
    mov r1, 32
    store_8 [28903], r1
    mov r1, 32
    store_8 [28904], r1
    mov r1, 65
    store_8 [28905], r1
    mov r1, 68
    store_8 [28906], r1
    mov r1, 68
    store_8 [28907], r1
    mov r1, 32
    store_8 [28908], r1
    mov r1, 68
    store_8 [28909], r1
    mov r1, 32
    store_8 [28910], r1
    mov r1, 49
    store_8 [28911], r1
    mov r1, 10
    store_8 [28912], r1
    mov r1, 69
    store_8 [28913], r1
    mov r1, 78
    store_8 [28914], r1
    mov r1, 68
    store_8 [28915], r1
    mov r1, 87
    store_8 [28916], r1
    mov r1, 72
    store_8 [28917], r1
    mov r1, 73
    store_8 [28918], r1
    mov r1, 76
    store_8 [28919], r1
    mov r1, 69
    store_8 [28920], r1
    mov r1, 10
    store_8 [28921], r1
    mov r1, 69
    store_8 [28922], r1
    mov r1, 78
    store_8 [28923], r1
    mov r1, 68
    store_8 [28924], r1
    mov r1, 10
    store_8 [28925], r1
    mov r1, 0
    store_8 [28926], r1
    mov r1, 0
    store_8 [28927], r1

    ; Overwrite BOTH slots to avoid prior generation conflicts.
    mov r3, 0
    mov r5, 1
    call WRITE_SLOT
    call VERIFY_SLOT
    mov r3, 16416
    mov r5, 2
    call WRITE_SLOT
    call VERIFY_SLOT
    out 501
HALT:
    jmp HALT

; Input: r3 slot base, r5 generation, r7 logical file length.
; Save checksum exactly as Symphony Vim V7 SAVE_DOC does.
WRITE_SLOT:
    pstore [r3], zr          ; Invalidate old slot first.
    add r13, r3, 4
    pstore [r13], r5        ; Generation.
    add r13, r3, 8
    pstore [r13], r7        ; Length.
    xor r1, r7, r5         ; Checksum seed.
    mov r4, 0
WRITE_WORD_LOOP:
    cmp r4, r7
    jae WRITE_COMMIT
    add r13, r4, 28672
    load_32 r6, [r13]
    lsl r1, r1, 1
    xor r1, r1, r6
    add r13, r3, r4
    add r13, r13, 16
    pstore [r13], r6
    add r4, r4, 4
    jmp WRITE_WORD_LOOP
WRITE_COMMIT:
    add r13, r3, 12
    pstore [r13], r1       ; Commit checksum first.
    mov r6, 29510
    pstore [r3], r6        ; Magic LAST: make slot valid.
    ret

; Verify header + each 32-bit payload word against Main RAM.
; If anything differs, print failure and STOP.
VERIFY_SLOT:
    pload r6, [r3]
    cmp r6, 29510
    jne FAIL
    add r13, r3, 4
    pload r6, [r13]
    cmp r6, r5
    jne FAIL
    add r13, r3, 8
    pload r6, [r13]
    cmp r6, r7
    jne FAIL
    add r13, r3, 12
    pload r6, [r13]
    xor r1, r7, r5
    mov r4, 0
VERIFY_CHECKSUM_LOOP:
    cmp r4, r7
    jae VERIFY_CHECKSUM_DONE
    add r13, r3, r4
    add r13, r13, 16
    pload r6, [r13]
    lsl r1, r1, 1
    xor r1, r1, r6
    add r4, r4, 4
    jmp VERIFY_CHECKSUM_LOOP
VERIFY_CHECKSUM_DONE:
    ; Reload checksum for proper verification.
    add r13, r3, 12
    pload r6, [r13]
    cmp r1, r6
    jne FAIL
    mov r4, 0
VERIFY_WORD_LOOP:
    cmp r4, r7
    jae VERIFY_OK
    add r13, r3, r4
    add r13, r13, 16
    pload r6, [r13]
    add r13, r4, 28672
    load_32 r1, [r13]
    cmp r6, r1
    jne FAIL
    add r4, r4, 4
    jmp VERIFY_WORD_LOOP
VERIFY_OK:
    ret

FAIL:
    out 598
FAIL_HALT:
    jmp FAIL_HALT
