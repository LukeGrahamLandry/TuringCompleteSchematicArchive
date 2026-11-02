; =====================================================================
; SYMPHONY VIM MANUAL - SSD INITIALIZER
; Writes one RAW 96 x 40 ASCII-8 screen to an independent SSD.
; SSD BYTE address 0..3839, 32-bit words in big-endian byte order.
; This has NO V7 document-save header; do NOT run on source-code SSD.
; MUST connect pload + pstore to the intended GUIDE SSD.
; OUTPUT 501 = 960 words stored and verified; 598 = mismatch.
; Uses Main RAM 32768..36607 as scratch (standalone program only).
; =====================================================================
START:
    mov r8, 8224          ; 0x2020 = two spaces
    lsl r8, r8, 16
    or r8, r8, 8224    ; 0x20202020
    mov r9, 15677         ; 0x3D3D = two = signs
    lsl r9, r9, 16
    or r9, r9, 15677   ; 0x3D3D3D3D

    ; Generate the manual page (4 characters per pstore).
    pstore [0], r9
    store_32 [32768], r9
    pstore [4], r9
    store_32 [32772], r9
    pstore [8], r9
    store_32 [32776], r9
    pstore [12], r9
    store_32 [32780], r9
    pstore [16], r9
    store_32 [32784], r9
    pstore [20], r9
    store_32 [32788], r9
    pstore [24], r9
    store_32 [32792], r9
    pstore [28], r9
    store_32 [32796], r9
    pstore [32], r9
    store_32 [32800], r9
    pstore [36], r9
    store_32 [32804], r9
    pstore [40], r9
    store_32 [32808], r9
    pstore [44], r9
    store_32 [32812], r9
    pstore [48], r9
    store_32 [32816], r9
    pstore [52], r9
    store_32 [32820], r9
    pstore [56], r9
    store_32 [32824], r9
    pstore [60], r9
    store_32 [32828], r9
    pstore [64], r9
    store_32 [32832], r9
    pstore [68], r9
    store_32 [32836], r9
    pstore [72], r9
    store_32 [32840], r9
    pstore [76], r9
    store_32 [32844], r9
    pstore [80], r9
    store_32 [32848], r9
    pstore [84], r9
    store_32 [32852], r9
    pstore [88], r9
    store_32 [32856], r9
    pstore [92], r9
    store_32 [32860], r9
    pstore [96], r8
    store_32 [32864], r8
    pstore [100], r8
    store_32 [32868], r8
    pstore [104], r8
    store_32 [32872], r8
    pstore [108], r8
    store_32 [32876], r8
    pstore [112], r8
    store_32 [32880], r8
    pstore [116], r8
    store_32 [32884], r8
    pstore [120], r8
    store_32 [32888], r8
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [124], r1
    store_32 [32892], r1
    mov r1, 8275
    lsl r1, r1, 16
    or r1, r1, 22861
    pstore [128], r1
    store_32 [32896], r1
    mov r1, 20552
    lsl r1, r1, 16
    or r1, r1, 20302
    pstore [132], r1
    store_32 [32900], r1
    mov r1, 22816
    lsl r1, r1, 16
    or r1, r1, 22089
    pstore [136], r1
    store_32 [32904], r1
    mov r1, 19744
    lsl r1, r1, 16
    or r1, r1, 20821
    pstore [140], r1
    store_32 [32908], r1
    mov r1, 18755
    lsl r1, r1, 16
    or r1, r1, 19232
    pstore [144], r1
    store_32 [32912], r1
    mov r1, 18261
    lsl r1, r1, 16
    or r1, r1, 18756
    pstore [148], r1
    store_32 [32916], r1
    mov r1, 17696
    lsl r1, r1, 16
    or r1, r1, 23382
    pstore [152], r1
    store_32 [32920], r1
    mov r1, 14173
    lsl r1, r1, 16
    or r1, r1, 8252
    pstore [156], r1
    store_32 [32924], r1
    mov r1, 15420
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [160], r1
    store_32 [32928], r1
    pstore [164], r8
    store_32 [32932], r8
    pstore [168], r8
    store_32 [32936], r8
    pstore [172], r8
    store_32 [32940], r8
    pstore [176], r8
    store_32 [32944], r8
    pstore [180], r8
    store_32 [32948], r8
    pstore [184], r8
    store_32 [32952], r8
    pstore [188], r8
    store_32 [32956], r8
    pstore [192], r8
    store_32 [32960], r8
    pstore [196], r8
    store_32 [32964], r8
    pstore [200], r8
    store_32 [32968], r8
    pstore [204], r8
    store_32 [32972], r8
    pstore [208], r8
    store_32 [32976], r8
    mov r1, 8270
    lsl r1, r1, 16
    or r1, r1, 20306
    pstore [212], r1
    store_32 [32980], r1
    mov r1, 19777
    lsl r1, r1, 16
    or r1, r1, 19488
    pstore [216], r1
    store_32 [32984], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 18766
    pstore [220], r1
    store_32 [32988], r1
    mov r1, 21317
    lsl r1, r1, 16
    or r1, r1, 21076
    pstore [224], r1
    store_32 [32992], r1
    mov r1, 8239
    lsl r1, r1, 16
    or r1, r1, 8259
    pstore [228], r1
    store_32 [32996], r1
    mov r1, 20301
    lsl r1, r1, 16
    or r1, r1, 19777
    pstore [232], r1
    store_32 [33000], r1
    mov r1, 20036
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [236], r1
    store_32 [33004], r1
    pstore [240], r8
    store_32 [33008], r8
    mov r1, 8316
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [244], r1
    store_32 [33012], r1
    pstore [248], r8
    store_32 [33016], r8
    mov r1, 8249
    lsl r1, r1, 16
    or r1, r1, 13856
    pstore [252], r1
    store_32 [33020], r1
    mov r1, 30752
    lsl r1, r1, 16
    or r1, r1, 13360
    pstore [256], r1
    store_32 [33024], r1
    mov r1, 8257
    lsl r1, r1, 16
    or r1, r1, 21315
    pstore [260], r1
    store_32 [33028], r1
    mov r1, 18761
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [264], r1
    store_32 [33032], r1
    pstore [268], r8
    store_32 [33036], r8
    pstore [272], r8
    store_32 [33040], r8
    pstore [276], r8
    store_32 [33044], r8
    pstore [280], r8
    store_32 [33048], r8
    pstore [284], r8
    store_32 [33052], r8
    pstore [288], r9
    store_32 [33056], r9
    pstore [292], r9
    store_32 [33060], r9
    pstore [296], r9
    store_32 [33064], r9
    pstore [300], r9
    store_32 [33068], r9
    pstore [304], r9
    store_32 [33072], r9
    pstore [308], r9
    store_32 [33076], r9
    pstore [312], r9
    store_32 [33080], r9
    pstore [316], r9
    store_32 [33084], r9
    pstore [320], r9
    store_32 [33088], r9
    pstore [324], r9
    store_32 [33092], r9
    pstore [328], r9
    store_32 [33096], r9
    pstore [332], r9
    store_32 [33100], r9
    pstore [336], r9
    store_32 [33104], r9
    pstore [340], r9
    store_32 [33108], r9
    pstore [344], r9
    store_32 [33112], r9
    pstore [348], r9
    store_32 [33116], r9
    pstore [352], r9
    store_32 [33120], r9
    pstore [356], r9
    store_32 [33124], r9
    pstore [360], r9
    store_32 [33128], r9
    pstore [364], r9
    store_32 [33132], r9
    pstore [368], r9
    store_32 [33136], r9
    pstore [372], r9
    store_32 [33140], r9
    pstore [376], r9
    store_32 [33144], r9
    pstore [380], r9
    store_32 [33148], r9
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [384], r1
    store_32 [33152], r1
    mov r1, 23328
    lsl r1, r1, 16
    or r1, r1, 18245
    pstore [388], r1
    store_32 [33156], r1
    mov r1, 21536
    lsl r1, r1, 16
    or r1, r1, 21332
    pstore [392], r1
    store_32 [33160], r1
    mov r1, 16722
    lsl r1, r1, 16
    or r1, r1, 21573
    pstore [396], r1
    store_32 [33164], r1
    mov r1, 17440
    lsl r1, r1, 16
    or r1, r1, 23868
    pstore [400], r1
    store_32 [33168], r1
    mov r1, 15420
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [404], r1
    store_32 [33172], r1
    pstore [408], r8
    store_32 [33176], r8
    pstore [412], r8
    store_32 [33180], r8
    pstore [416], r8
    store_32 [33184], r8
    pstore [420], r8
    store_32 [33188], r8
    pstore [424], r8
    store_32 [33192], r8
    pstore [428], r8
    store_32 [33196], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [432], r1
    store_32 [33200], r1
    mov r1, 15963
    lsl r1, r1, 16
    or r1, r1, 8262
    pstore [436], r1
    store_32 [33204], r1
    mov r1, 18764
    lsl r1, r1, 16
    or r1, r1, 17696
    pstore [440], r1
    store_32 [33208], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 17231
    pstore [444], r1
    store_32 [33212], r1
    mov r1, 19792
    lsl r1, r1, 16
    or r1, r1, 18764
    pstore [448], r1
    store_32 [33216], r1
    mov r1, 17746
    lsl r1, r1, 16
    or r1, r1, 8285
    pstore [452], r1
    store_32 [33220], r1
    mov r1, 15420
    lsl r1, r1, 16
    or r1, r1, 15392
    pstore [456], r1
    store_32 [33224], r1
    pstore [460], r8
    store_32 [33228], r8
    pstore [464], r8
    store_32 [33232], r8
    pstore [468], r8
    store_32 [33236], r8
    pstore [472], r8
    store_32 [33240], r8
    pstore [476], r8
    store_32 [33244], r8
    mov r1, 8241
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [480], r1
    store_32 [33248], r1
    mov r1, 20594
    lsl r1, r1, 16
    or r1, r1, 25971
    pstore [484], r1
    store_32 [33252], r1
    mov r1, 29472
    lsl r1, r1, 16
    or r1, r1, 26912
    pstore [488], r1
    store_32 [33256], r1
    mov r1, 29807
    lsl r1, r1, 16
    or r1, r1, 8293
    pstore [492], r1
    store_32 [33260], r1
    mov r1, 28276
    lsl r1, r1, 16
    or r1, r1, 25970
    pstore [496], r1
    store_32 [33264], r1
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 20051
    pstore [500], r1
    store_32 [33268], r1
    mov r1, 17746
    lsl r1, r1, 16
    or r1, r1, 21536
    pstore [504], r1
    store_32 [33272], r1
    mov r1, 28015
    lsl r1, r1, 16
    or r1, r1, 25701
    pstore [508], r1
    store_32 [33276], r1
    mov r1, 11808
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [512], r1
    store_32 [33280], r1
    pstore [516], r8
    store_32 [33284], r8
    pstore [520], r8
    store_32 [33288], r8
    pstore [524], r8
    store_32 [33292], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14967
    pstore [528], r1
    store_32 [33296], r1
    pstore [532], r8
    store_32 [33300], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8275
    pstore [536], r1
    store_32 [33304], r1
    mov r1, 24950
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [540], r1
    store_32 [33308], r1
    mov r1, 29551
    lsl r1, r1, 16
    or r1, r1, 30066
    pstore [544], r1
    store_32 [33312], r1
    mov r1, 25445
    lsl r1, r1, 16
    or r1, r1, 8308
    pstore [548], r1
    store_32 [33316], r1
    mov r1, 28448
    lsl r1, r1, 16
    or r1, r1, 21331
    pstore [552], r1
    store_32 [33320], r1
    mov r1, 17440
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [556], r1
    store_32 [33324], r1
    pstore [560], r8
    store_32 [33328], r8
    pstore [564], r8
    store_32 [33332], r8
    pstore [568], r8
    store_32 [33336], r8
    pstore [572], r8
    store_32 [33340], r8
    mov r1, 8242
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [576], r1
    store_32 [33344], r1
    mov r1, 21625
    lsl r1, r1, 16
    or r1, r1, 28773
    pstore [580], r1
    store_32 [33348], r1
    mov r1, 8313
    lsl r1, r1, 16
    or r1, r1, 28533
    pstore [584], r1
    store_32 [33352], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 16961
    pstore [588], r1
    store_32 [33356], r1
    mov r1, 21321
    lsl r1, r1, 16
    or r1, r1, 17184
    pstore [592], r1
    store_32 [33360], r1
    mov r1, 28786
    lsl r1, r1, 16
    or r1, r1, 28519
    pstore [596], r1
    store_32 [33364], r1
    mov r1, 29281
    lsl r1, r1, 16
    or r1, r1, 27950
    pstore [600], r1
    store_32 [33368], r1
    pstore [604], r8
    store_32 [33372], r8
    pstore [608], r8
    store_32 [33376], r8
    pstore [612], r8
    store_32 [33380], r8
    pstore [616], r8
    store_32 [33384], r8
    pstore [620], r8
    store_32 [33388], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14949
    pstore [624], r1
    store_32 [33392], r1
    pstore [628], r8
    store_32 [33396], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8274
    pstore [632], r1
    store_32 [33400], r1
    mov r1, 25964
    lsl r1, r1, 16
    or r1, r1, 28513
    pstore [636], r1
    store_32 [33404], r1
    mov r1, 25632
    lsl r1, r1, 16
    or r1, r1, 29537
    pstore [640], r1
    store_32 [33408], r1
    mov r1, 30309
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [644], r1
    store_32 [33412], r1
    mov r1, 29551
    lsl r1, r1, 16
    or r1, r1, 30066
    pstore [648], r1
    store_32 [33416], r1
    mov r1, 25445
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [652], r1
    store_32 [33420], r1
    pstore [656], r8
    store_32 [33424], r8
    pstore [660], r8
    store_32 [33428], r8
    pstore [664], r8
    store_32 [33432], r8
    pstore [668], r8
    store_32 [33436], r8
    mov r1, 8243
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [672], r1
    store_32 [33440], r1
    mov r1, 20594
    lsl r1, r1, 16
    or r1, r1, 25971
    pstore [676], r1
    store_32 [33444], r1
    mov r1, 29472
    lsl r1, r1, 16
    or r1, r1, 17779
    pstore [680], r1
    store_32 [33448], r1
    mov r1, 25376
    lsl r1, r1, 16
    or r1, r1, 29807
    pstore [684], r1
    store_32 [33452], r1
    mov r1, 8306
    lsl r1, r1, 16
    or r1, r1, 25972
    pstore [688], r1
    store_32 [33456], r1
    mov r1, 30066
    lsl r1, r1, 16
    or r1, r1, 28192
    pstore [692], r1
    store_32 [33460], r1
    mov r1, 29807
    lsl r1, r1, 16
    or r1, r1, 8270
    pstore [696], r1
    store_32 [33464], r1
    mov r1, 20306
    lsl r1, r1, 16
    or r1, r1, 19777
    pstore [700], r1
    store_32 [33468], r1
    mov r1, 19502
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [704], r1
    store_32 [33472], r1
    pstore [708], r8
    store_32 [33476], r8
    pstore [712], r8
    store_32 [33480], r8
    pstore [716], r8
    store_32 [33484], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14947
    pstore [720], r1
    store_32 [33488], r1
    pstore [724], r8
    store_32 [33492], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8259
    pstore [728], r1
    store_32 [33496], r1
    mov r1, 28525
    lsl r1, r1, 16
    or r1, r1, 28777
    pstore [732], r1
    store_32 [33500], r1
    mov r1, 27749
    lsl r1, r1, 16
    or r1, r1, 8291
    pstore [736], r1
    store_32 [33504], r1
    mov r1, 30066
    lsl r1, r1, 16
    or r1, r1, 29285
    pstore [740], r1
    store_32 [33508], r1
    mov r1, 28276
    lsl r1, r1, 16
    or r1, r1, 8307
    pstore [744], r1
    store_32 [33512], r1
    mov r1, 28533
    lsl r1, r1, 16
    or r1, r1, 29283
    pstore [748], r1
    store_32 [33516], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [752], r1
    store_32 [33520], r1
    pstore [756], r8
    store_32 [33524], r8
    pstore [760], r8
    store_32 [33528], r8
    pstore [764], r8
    store_32 [33532], r8
    mov r1, 8244
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [768], r1
    store_32 [33536], r1
    mov r1, 21625
    lsl r1, r1, 16
    or r1, r1, 28773
    pstore [772], r1
    store_32 [33540], r1
    mov r1, 8250
    lsl r1, r1, 16
    or r1, r1, 25376
    pstore [776], r1
    store_32 [33544], r1
    mov r1, 29800
    lsl r1, r1, 16
    or r1, r1, 25966
    pstore [780], r1
    store_32 [33548], r1
    mov r1, 8304
    lsl r1, r1, 16
    or r1, r1, 29285
    pstore [784], r1
    store_32 [33552], r1
    mov r1, 29555
    lsl r1, r1, 16
    or r1, r1, 8261
    pstore [788], r1
    store_32 [33556], r1
    mov r1, 28276
    lsl r1, r1, 16
    or r1, r1, 25970
    pstore [792], r1
    store_32 [33560], r1
    mov r1, 11808
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [796], r1
    store_32 [33564], r1
    pstore [800], r8
    store_32 [33568], r8
    pstore [804], r8
    store_32 [33572], r8
    pstore [808], r8
    store_32 [33576], r8
    pstore [812], r8
    store_32 [33580], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14962
    pstore [816], r1
    store_32 [33584], r1
    pstore [820], r8
    store_32 [33588], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8274
    pstore [824], r1
    store_32 [33592], r1
    mov r1, 30062
    lsl r1, r1, 16
    or r1, r1, 8291
    pstore [828], r1
    store_32 [33596], r1
    mov r1, 28525
    lsl r1, r1, 16
    or r1, r1, 28777
    pstore [832], r1
    store_32 [33600], r1
    mov r1, 27749
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [836], r1
    store_32 [33604], r1
    mov r1, 28786
    lsl r1, r1, 16
    or r1, r1, 28519
    pstore [840], r1
    store_32 [33608], r1
    mov r1, 29281
    lsl r1, r1, 16
    or r1, r1, 27936
    pstore [844], r1
    store_32 [33612], r1
    pstore [848], r8
    store_32 [33616], r8
    pstore [852], r8
    store_32 [33620], r8
    pstore [856], r8
    store_32 [33624], r8
    pstore [860], r8
    store_32 [33628], r8
    mov r1, 8245
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [864], r1
    store_32 [33632], r1
    mov r1, 21625
    lsl r1, r1, 16
    or r1, r1, 28773
    pstore [868], r1
    store_32 [33636], r1
    mov r1, 8250
    lsl r1, r1, 16
    or r1, r1, 29216
    pstore [872], r1
    store_32 [33640], r1
    mov r1, 29800
    lsl r1, r1, 16
    or r1, r1, 25966
    pstore [876], r1
    store_32 [33644], r1
    mov r1, 8304
    lsl r1, r1, 16
    or r1, r1, 29285
    pstore [880], r1
    store_32 [33648], r1
    mov r1, 29555
    lsl r1, r1, 16
    or r1, r1, 8261
    pstore [884], r1
    store_32 [33652], r1
    mov r1, 28276
    lsl r1, r1, 16
    or r1, r1, 25970
    pstore [888], r1
    store_32 [33656], r1
    mov r1, 11808
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [892], r1
    store_32 [33660], r1
    pstore [896], r8
    store_32 [33664], r8
    pstore [900], r8
    store_32 [33668], r8
    pstore [904], r8
    store_32 [33672], r8
    pstore [908], r8
    store_32 [33676], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14967
    pstore [912], r1
    store_32 [33680], r1
    mov r1, 28960
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [916], r1
    store_32 [33684], r1
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8275
    pstore [920], r1
    store_32 [33688], r1
    mov r1, 24950
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [924], r1
    store_32 [33692], r1
    mov r1, 24942
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [928], r1
    store_32 [33696], r1
    mov r1, 29045
    lsl r1, r1, 16
    or r1, r1, 26996
    pstore [932], r1
    store_32 [33700], r1
    pstore [936], r8
    store_32 [33704], r8
    pstore [940], r8
    store_32 [33708], r8
    pstore [944], r8
    store_32 [33712], r8
    pstore [948], r8
    store_32 [33716], r8
    pstore [952], r8
    store_32 [33720], r8
    pstore [956], r8
    store_32 [33724], r8
    mov r1, 8246
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [960], r1
    store_32 [33728], r1
    mov r1, 21625
    lsl r1, r1, 16
    or r1, r1, 28773
    pstore [964], r1
    store_32 [33732], r1
    mov r1, 8250
    lsl r1, r1, 16
    or r1, r1, 30496
    pstore [968], r1
    store_32 [33736], r1
    mov r1, 29800
    lsl r1, r1, 16
    or r1, r1, 25966
    pstore [972], r1
    store_32 [33740], r1
    mov r1, 8261
    lsl r1, r1, 16
    or r1, r1, 28276
    pstore [976], r1
    store_32 [33744], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 8308
    pstore [980], r1
    store_32 [33748], r1
    mov r1, 28448
    lsl r1, r1, 16
    or r1, r1, 29537
    pstore [984], r1
    store_32 [33752], r1
    mov r1, 30309
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [988], r1
    store_32 [33756], r1
    pstore [992], r8
    store_32 [33760], r8
    pstore [996], r8
    store_32 [33764], r8
    pstore [1000], r8
    store_32 [33768], r8
    pstore [1004], r8
    store_32 [33772], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14961
    pstore [1008], r1
    store_32 [33776], r1
    pstore [1012], r8
    store_32 [33780], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 8273
    pstore [1016], r1
    store_32 [33784], r1
    mov r1, 30057
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1020], r1
    store_32 [33788], r1
    mov r1, 10355
    lsl r1, r1, 16
    or r1, r1, 29807
    pstore [1024], r1
    store_32 [33792], r1
    mov r1, 28787
    lsl r1, r1, 16
    or r1, r1, 8259
    pstore [1028], r1
    store_32 [33796], r1
    mov r1, 20565
    lsl r1, r1, 16
    or r1, r1, 10528
    pstore [1032], r1
    store_32 [33800], r1
    pstore [1036], r8
    store_32 [33804], r8
    pstore [1040], r8
    store_32 [33808], r8
    pstore [1044], r8
    store_32 [33812], r8
    pstore [1048], r8
    store_32 [33816], r8
    pstore [1052], r8
    store_32 [33820], r8
    pstore [1056], r8
    store_32 [33824], r8
    pstore [1060], r8
    store_32 [33828], r8
    pstore [1064], r8
    store_32 [33832], r8
    pstore [1068], r8
    store_32 [33836], r8
    pstore [1072], r8
    store_32 [33840], r8
    pstore [1076], r8
    store_32 [33844], r8
    pstore [1080], r8
    store_32 [33848], r8
    pstore [1084], r8
    store_32 [33852], r8
    pstore [1088], r8
    store_32 [33856], r8
    pstore [1092], r8
    store_32 [33860], r8
    pstore [1096], r8
    store_32 [33864], r8
    pstore [1100], r8
    store_32 [33868], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1104], r1
    store_32 [33872], r1
    pstore [1108], r8
    store_32 [33876], r8
    pstore [1112], r8
    store_32 [33880], r8
    pstore [1116], r8
    store_32 [33884], r8
    pstore [1120], r8
    store_32 [33888], r8
    pstore [1124], r8
    store_32 [33892], r8
    pstore [1128], r8
    store_32 [33896], r8
    pstore [1132], r8
    store_32 [33900], r8
    pstore [1136], r8
    store_32 [33904], r8
    pstore [1140], r8
    store_32 [33908], r8
    pstore [1144], r8
    store_32 [33912], r8
    pstore [1148], r8
    store_32 [33916], r8
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [1152], r1
    store_32 [33920], r1
    mov r1, 23328
    lsl r1, r1, 16
    or r1, r1, 19791
    pstore [1156], r1
    store_32 [33924], r1
    mov r1, 17477
    lsl r1, r1, 16
    or r1, r1, 21280
    pstore [1160], r1
    store_32 [33928], r1
    mov r1, 23868
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [1164], r1
    store_32 [33932], r1
    pstore [1168], r8
    store_32 [33936], r8
    pstore [1172], r8
    store_32 [33940], r8
    pstore [1176], r8
    store_32 [33944], r8
    pstore [1180], r8
    store_32 [33948], r8
    pstore [1184], r8
    store_32 [33952], r8
    pstore [1188], r8
    store_32 [33956], r8
    pstore [1192], r8
    store_32 [33960], r8
    pstore [1196], r8
    store_32 [33964], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [1200], r1
    store_32 [33968], r1
    mov r1, 15963
    lsl r1, r1, 16
    or r1, r1, 8265
    pstore [1204], r1
    store_32 [33972], r1
    mov r1, 20051
    lsl r1, r1, 16
    or r1, r1, 17746
    pstore [1208], r1
    store_32 [33976], r1
    mov r1, 21536
    lsl r1, r1, 16
    or r1, r1, 12064
    pstore [1212], r1
    store_32 [33980], r1
    mov r1, 16720
    lsl r1, r1, 16
    or r1, r1, 20549
    pstore [1216], r1
    store_32 [33984], r1
    mov r1, 20036
    lsl r1, r1, 16
    or r1, r1, 8232
    pstore [1220], r1
    store_32 [33988], r1
    mov r1, 20047
    lsl r1, r1, 16
    or r1, r1, 21069
    pstore [1224], r1
    store_32 [33992], r1
    mov r1, 16716
    lsl r1, r1, 16
    or r1, r1, 10528
    pstore [1228], r1
    store_32 [33996], r1
    mov r1, 23868
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [1232], r1
    store_32 [34000], r1
    pstore [1236], r8
    store_32 [34004], r8
    pstore [1240], r8
    store_32 [34008], r8
    pstore [1244], r8
    store_32 [34012], r8
    mov r1, 8270
    lsl r1, r1, 16
    or r1, r1, 20306
    pstore [1248], r1
    store_32 [34016], r1
    mov r1, 19777
    lsl r1, r1, 16
    or r1, r1, 19488
    pstore [1252], r1
    store_32 [34020], r1
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 20065
    pstore [1256], r1
    store_32 [34024], r1
    mov r1, 30313
    lsl r1, r1, 16
    or r1, r1, 26465
    pstore [1260], r1
    store_32 [34028], r1
    mov r1, 29797
    lsl r1, r1, 16
    or r1, r1, 8289
    pstore [1264], r1
    store_32 [34032], r1
    mov r1, 28260
    lsl r1, r1, 16
    or r1, r1, 8293
    pstore [1268], r1
    store_32 [34036], r1
    mov r1, 25705
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1272], r1
    store_32 [34040], r1
    pstore [1276], r8
    store_32 [34044], r8
    pstore [1280], r8
    store_32 [34048], r8
    pstore [1284], r8
    store_32 [34052], r8
    pstore [1288], r8
    store_32 [34056], r8
    pstore [1292], r8
    store_32 [34060], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 26912
    pstore [1296], r1
    store_32 [34064], r1
    pstore [1300], r8
    store_32 [34068], r8
    pstore [1304], r8
    store_32 [34072], r8
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 28275
    pstore [1308], r1
    store_32 [34076], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1312], r1
    store_32 [34080], r1
    mov r1, 24948
    lsl r1, r1, 16
    or r1, r1, 8291
    pstore [1316], r1
    store_32 [34084], r1
    mov r1, 30066
    lsl r1, r1, 16
    or r1, r1, 29551
    pstore [1320], r1
    store_32 [34088], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1324], r1
    store_32 [34092], r1
    pstore [1328], r8
    store_32 [34096], r8
    pstore [1332], r8
    store_32 [34100], r8
    pstore [1336], r8
    store_32 [34104], r8
    pstore [1340], r8
    store_32 [34108], r8
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 20051
    pstore [1344], r1
    store_32 [34112], r1
    mov r1, 17746
    lsl r1, r1, 16
    or r1, r1, 21536
    pstore [1348], r1
    store_32 [34116], r1
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 21625
    pstore [1352], r1
    store_32 [34120], r1
    mov r1, 28773
    lsl r1, r1, 16
    or r1, r1, 8308
    pstore [1356], r1
    store_32 [34124], r1
    mov r1, 25976
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1360], r1
    store_32 [34128], r1
    pstore [1364], r8
    store_32 [34132], r8
    pstore [1368], r8
    store_32 [34136], r8
    pstore [1372], r8
    store_32 [34140], r8
    pstore [1376], r8
    store_32 [34144], r8
    pstore [1380], r8
    store_32 [34148], r8
    pstore [1384], r8
    store_32 [34152], r8
    pstore [1388], r8
    store_32 [34156], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 24864
    pstore [1392], r1
    store_32 [34160], r1
    pstore [1396], r8
    store_32 [34164], r8
    pstore [1400], r8
    store_32 [34168], r8
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 28275
    pstore [1404], r1
    store_32 [34172], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1408], r1
    store_32 [34176], r1
    mov r1, 24934
    lsl r1, r1, 16
    or r1, r1, 29797
    pstore [1412], r1
    store_32 [34180], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 25461
    pstore [1416], r1
    store_32 [34184], r1
    mov r1, 29299
    lsl r1, r1, 16
    or r1, r1, 28530
    pstore [1420], r1
    store_32 [34188], r1
    pstore [1424], r8
    store_32 [34192], r8
    pstore [1428], r8
    store_32 [34196], r8
    pstore [1432], r8
    store_32 [34200], r8
    pstore [1436], r8
    store_32 [34204], r8
    mov r1, 8259
    lsl r1, r1, 16
    or r1, r1, 20301
    pstore [1440], r1
    store_32 [34208], r1
    mov r1, 19777
    lsl r1, r1, 16
    or r1, r1, 20036
    pstore [1444], r1
    store_32 [34212], r1
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 21625
    pstore [1448], r1
    store_32 [34216], r1
    mov r1, 28773
    lsl r1, r1, 16
    or r1, r1, 8250
    pstore [1452], r1
    store_32 [34220], r1
    mov r1, 8294
    lsl r1, r1, 16
    or r1, r1, 29295
    pstore [1456], r1
    store_32 [34224], r1
    mov r1, 27936
    lsl r1, r1, 16
    or r1, r1, 20047
    pstore [1460], r1
    store_32 [34228], r1
    mov r1, 21069
    lsl r1, r1, 16
    or r1, r1, 16716
    pstore [1464], r1
    store_32 [34232], r1
    pstore [1468], r8
    store_32 [34236], r8
    pstore [1472], r8
    store_32 [34240], r8
    pstore [1476], r8
    store_32 [34244], r8
    pstore [1480], r8
    store_32 [34248], r8
    pstore [1484], r8
    store_32 [34252], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 18720
    pstore [1488], r1
    store_32 [34256], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 16672
    pstore [1492], r1
    store_32 [34260], r1
    pstore [1496], r8
    store_32 [34264], r8
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 28275
    pstore [1500], r1
    store_32 [34268], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1504], r1
    store_32 [34272], r1
    mov r1, 24948
    lsl r1, r1, 16
    or r1, r1, 8300
    pstore [1508], r1
    store_32 [34276], r1
    mov r1, 26990
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [1512], r1
    store_32 [34280], r1
    mov r1, 29556
    lsl r1, r1, 16
    or r1, r1, 24946
    pstore [1516], r1
    store_32 [34284], r1
    mov r1, 29728
    lsl r1, r1, 16
    or r1, r1, 12064
    pstore [1520], r1
    store_32 [34288], r1
    mov r1, 25966
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [1524], r1
    store_32 [34292], r1
    pstore [1528], r8
    store_32 [34296], r8
    pstore [1532], r8
    store_32 [34300], r8
    mov r1, 8261
    lsl r1, r1, 16
    or r1, r1, 29539
    pstore [1536], r1
    store_32 [34304], r1
    pstore [1540], r8
    store_32 [34308], r8
    mov r1, 8224
    lsl r1, r1, 16
    or r1, r1, 21093
    pstore [1544], r1
    store_32 [34312], r1
    mov r1, 29813
    lsl r1, r1, 16
    or r1, r1, 29294
    pstore [1548], r1
    store_32 [34316], r1
    mov r1, 8308
    lsl r1, r1, 16
    or r1, r1, 28448
    pstore [1552], r1
    store_32 [34320], r1
    mov r1, 20047
    lsl r1, r1, 16
    or r1, r1, 21069
    pstore [1556], r1
    store_32 [34324], r1
    mov r1, 16716
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1560], r1
    store_32 [34328], r1
    pstore [1564], r8
    store_32 [34332], r8
    pstore [1568], r8
    store_32 [34336], r8
    pstore [1572], r8
    store_32 [34340], r8
    pstore [1576], r8
    store_32 [34344], r8
    pstore [1580], r8
    store_32 [34348], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 28448
    pstore [1584], r1
    store_32 [34352], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 20256
    pstore [1588], r1
    store_32 [34356], r1
    pstore [1592], r8
    store_32 [34360], r8
    mov r1, 8270
    lsl r1, r1, 16
    or r1, r1, 25975
    pstore [1596], r1
    store_32 [34364], r1
    mov r1, 8300
    lsl r1, r1, 16
    or r1, r1, 26990
    pstore [1600], r1
    store_32 [34368], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 25189
    pstore [1604], r1
    store_32 [34372], r1
    mov r1, 27759
    lsl r1, r1, 16
    or r1, r1, 30496
    pstore [1608], r1
    store_32 [34376], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 24930
    pstore [1612], r1
    store_32 [34380], r1
    mov r1, 28534
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [1616], r1
    store_32 [34384], r1
    pstore [1620], r8
    store_32 [34388], r8
    pstore [1624], r8
    store_32 [34392], r8
    pstore [1628], r8
    store_32 [34396], r8
    pstore [1632], r8
    store_32 [34400], r8
    pstore [1636], r8
    store_32 [34404], r8
    pstore [1640], r8
    store_32 [34408], r8
    pstore [1644], r8
    store_32 [34412], r8
    pstore [1648], r8
    store_32 [34416], r8
    pstore [1652], r8
    store_32 [34420], r8
    pstore [1656], r8
    store_32 [34424], r8
    pstore [1660], r8
    store_32 [34428], r8
    pstore [1664], r8
    store_32 [34432], r8
    pstore [1668], r8
    store_32 [34436], r8
    pstore [1672], r8
    store_32 [34440], r8
    pstore [1676], r8
    store_32 [34444], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1680], r1
    store_32 [34448], r1
    pstore [1684], r8
    store_32 [34452], r8
    pstore [1688], r8
    store_32 [34456], r8
    pstore [1692], r8
    store_32 [34460], r8
    pstore [1696], r8
    store_32 [34464], r8
    pstore [1700], r8
    store_32 [34468], r8
    pstore [1704], r8
    store_32 [34472], r8
    pstore [1708], r8
    store_32 [34476], r8
    pstore [1712], r8
    store_32 [34480], r8
    pstore [1716], r8
    store_32 [34484], r8
    pstore [1720], r8
    store_32 [34488], r8
    pstore [1724], r8
    store_32 [34492], r8
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [1728], r1
    store_32 [34496], r1
    mov r1, 23328
    lsl r1, r1, 16
    or r1, r1, 19791
    pstore [1732], r1
    store_32 [34500], r1
    mov r1, 22085
    lsl r1, r1, 16
    or r1, r1, 19781
    pstore [1736], r1
    store_32 [34504], r1
    mov r1, 20052
    lsl r1, r1, 16
    or r1, r1, 8232
    pstore [1740], r1
    store_32 [34508], r1
    mov r1, 20047
    lsl r1, r1, 16
    or r1, r1, 21069
    pstore [1744], r1
    store_32 [34512], r1
    mov r1, 16716
    lsl r1, r1, 16
    or r1, r1, 10528
    pstore [1748], r1
    store_32 [34516], r1
    mov r1, 23868
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [1752], r1
    store_32 [34520], r1
    pstore [1756], r8
    store_32 [34524], r8
    pstore [1760], r8
    store_32 [34528], r8
    pstore [1764], r8
    store_32 [34532], r8
    pstore [1768], r8
    store_32 [34536], r8
    pstore [1772], r8
    store_32 [34540], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [1776], r1
    store_32 [34544], r1
    mov r1, 15963
    lsl r1, r1, 16
    or r1, r1, 8260
    pstore [1780], r1
    store_32 [34548], r1
    mov r1, 17740
    lsl r1, r1, 16
    or r1, r1, 17748
    pstore [1784], r1
    store_32 [34552], r1
    mov r1, 17696
    lsl r1, r1, 16
    or r1, r1, 12064
    pstore [1788], r1
    store_32 [34556], r1
    mov r1, 21838
    lsl r1, r1, 16
    or r1, r1, 17487
    pstore [1792], r1
    store_32 [34560], r1
    mov r1, 8232
    lsl r1, r1, 16
    or r1, r1, 20047
    pstore [1796], r1
    store_32 [34564], r1
    mov r1, 21069
    lsl r1, r1, 16
    or r1, r1, 16716
    pstore [1800], r1
    store_32 [34568], r1
    mov r1, 10528
    lsl r1, r1, 16
    or r1, r1, 23868
    pstore [1804], r1
    store_32 [34572], r1
    mov r1, 15420
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1808], r1
    store_32 [34576], r1
    pstore [1812], r8
    store_32 [34580], r8
    pstore [1816], r8
    store_32 [34584], r8
    pstore [1820], r8
    store_32 [34588], r8
    mov r1, 8296
    lsl r1, r1, 16
    or r1, r1, 8239
    pstore [1824], r1
    store_32 [34592], r1
    mov r1, 8300
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1828], r1
    store_32 [34596], r1
    pstore [1832], r8
    store_32 [34600], r8
    mov r1, 19557
    lsl r1, r1, 16
    or r1, r1, 26228
    pstore [1836], r1
    store_32 [34604], r1
    mov r1, 8239
    lsl r1, r1, 16
    or r1, r1, 8274
    pstore [1840], r1
    store_32 [34608], r1
    mov r1, 26983
    lsl r1, r1, 16
    or r1, r1, 26740
    pstore [1844], r1
    store_32 [34612], r1
    pstore [1848], r8
    store_32 [34616], r8
    pstore [1852], r8
    store_32 [34620], r8
    pstore [1856], r8
    store_32 [34624], r8
    pstore [1860], r8
    store_32 [34628], r8
    pstore [1864], r8
    store_32 [34632], r8
    pstore [1868], r8
    store_32 [34636], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 30752
    pstore [1872], r1
    store_32 [34640], r1
    pstore [1876], r8
    store_32 [34644], r8
    pstore [1880], r8
    store_32 [34648], r8
    mov r1, 8260
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [1884], r1
    store_32 [34652], r1
    mov r1, 25972
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [1888], r1
    store_32 [34656], r1
    mov r1, 25461
    lsl r1, r1, 16
    or r1, r1, 29298
    pstore [1892], r1
    store_32 [34660], r1
    mov r1, 25966
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [1896], r1
    store_32 [34664], r1
    mov r1, 25448
    lsl r1, r1, 16
    or r1, r1, 24946
    pstore [1900], r1
    store_32 [34668], r1
    mov r1, 24931
    lsl r1, r1, 16
    or r1, r1, 29797
    pstore [1904], r1
    store_32 [34672], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1908], r1
    store_32 [34676], r1
    pstore [1912], r8
    store_32 [34680], r8
    pstore [1916], r8
    store_32 [34684], r8
    mov r1, 8298
    lsl r1, r1, 16
    or r1, r1, 8239
    pstore [1920], r1
    store_32 [34688], r1
    mov r1, 8299
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1924], r1
    store_32 [34692], r1
    pstore [1928], r8
    store_32 [34696], r8
    mov r1, 17519
    lsl r1, r1, 16
    or r1, r1, 30574
    pstore [1932], r1
    store_32 [34700], r1
    mov r1, 8239
    lsl r1, r1, 16
    or r1, r1, 8277
    pstore [1936], r1
    store_32 [34704], r1
    mov r1, 28704
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1940], r1
    store_32 [34708], r1
    pstore [1944], r8
    store_32 [34712], r8
    pstore [1948], r8
    store_32 [34716], r8
    pstore [1952], r8
    store_32 [34720], r8
    pstore [1956], r8
    store_32 [34724], r8
    pstore [1960], r8
    store_32 [34728], r8
    pstore [1964], r8
    store_32 [34732], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 22560
    pstore [1968], r1
    store_32 [34736], r1
    pstore [1972], r8
    store_32 [34740], r8
    pstore [1976], r8
    store_32 [34744], r8
    mov r1, 8258
    lsl r1, r1, 16
    or r1, r1, 24931
    pstore [1980], r1
    store_32 [34748], r1
    mov r1, 27507
    lsl r1, r1, 16
    or r1, r1, 28769
    pstore [1984], r1
    store_32 [34752], r1
    mov r1, 25445
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [1988], r1
    store_32 [34756], r1
    pstore [1992], r8
    store_32 [34760], r8
    pstore [1996], r8
    store_32 [34764], r8
    pstore [2000], r8
    store_32 [34768], r8
    pstore [2004], r8
    store_32 [34772], r8
    pstore [2008], r8
    store_32 [34776], r8
    pstore [2012], r8
    store_32 [34780], r8
    mov r1, 8240
    lsl r1, r1, 16
    or r1, r1, 8239
    pstore [2016], r1
    store_32 [34784], r1
    mov r1, 8228
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2020], r1
    store_32 [34788], r1
    pstore [2024], r8
    store_32 [34792], r8
    mov r1, 21364
    lsl r1, r1, 16
    or r1, r1, 24946
    pstore [2028], r1
    store_32 [34796], r1
    mov r1, 29728
    lsl r1, r1, 16
    or r1, r1, 12064
    pstore [2032], r1
    store_32 [34800], r1
    mov r1, 25966
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [2036], r1
    store_32 [34804], r1
    mov r1, 28518
    lsl r1, r1, 16
    or r1, r1, 8300
    pstore [2040], r1
    store_32 [34808], r1
    mov r1, 26990
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2044], r1
    store_32 [34812], r1
    pstore [2048], r8
    store_32 [34816], r8
    pstore [2052], r8
    store_32 [34820], r8
    pstore [2056], r8
    store_32 [34824], r8
    pstore [2060], r8
    store_32 [34828], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 25700
    pstore [2064], r1
    store_32 [34832], r1
    pstore [2068], r8
    store_32 [34836], r8
    pstore [2072], r8
    store_32 [34840], r8
    mov r1, 8260
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2076], r1
    store_32 [34844], r1
    mov r1, 25972
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2080], r1
    store_32 [34848], r1
    mov r1, 25461
    lsl r1, r1, 16
    or r1, r1, 29298
    pstore [2084], r1
    store_32 [34852], r1
    mov r1, 25966
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [2088], r1
    store_32 [34856], r1
    mov r1, 27753
    lsl r1, r1, 16
    or r1, r1, 28261
    pstore [2092], r1
    store_32 [34860], r1
    pstore [2096], r8
    store_32 [34864], r8
    pstore [2100], r8
    store_32 [34868], r8
    pstore [2104], r8
    store_32 [34872], r8
    pstore [2108], r8
    store_32 [34876], r8
    mov r1, 8295
    lsl r1, r1, 16
    or r1, r1, 26400
    pstore [2112], r1
    store_32 [34880], r1
    mov r1, 12064
    lsl r1, r1, 16
    or r1, r1, 18208
    pstore [2116], r1
    store_32 [34884], r1
    pstore [2120], r8
    store_32 [34888], r8
    mov r1, 21364
    lsl r1, r1, 16
    or r1, r1, 24946
    pstore [2124], r1
    store_32 [34892], r1
    mov r1, 29728
    lsl r1, r1, 16
    or r1, r1, 12064
    pstore [2128], r1
    store_32 [34896], r1
    mov r1, 25966
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [2132], r1
    store_32 [34900], r1
    mov r1, 28518
    lsl r1, r1, 16
    or r1, r1, 8294
    pstore [2136], r1
    store_32 [34904], r1
    mov r1, 26988
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2140], r1
    store_32 [34908], r1
    pstore [2144], r8
    store_32 [34912], r8
    pstore [2148], r8
    store_32 [34916], r8
    pstore [2152], r8
    store_32 [34920], r8
    pstore [2156], r8
    store_32 [34924], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 29216
    pstore [2160], r1
    store_32 [34928], r1
    mov r1, 11040
    lsl r1, r1, 16
    or r1, r1, 27493
    pstore [2164], r1
    store_32 [34932], r1
    mov r1, 31008
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2168], r1
    store_32 [34936], r1
    mov r1, 8274
    lsl r1, r1, 16
    or r1, r1, 25968
    pstore [2172], r1
    store_32 [34940], r1
    mov r1, 27745
    lsl r1, r1, 16
    or r1, r1, 25445
    pstore [2176], r1
    store_32 [34944], r1
    mov r1, 8303
    lsl r1, r1, 16
    or r1, r1, 28261
    pstore [2180], r1
    store_32 [34948], r1
    mov r1, 8291
    lsl r1, r1, 16
    or r1, r1, 26721
    pstore [2184], r1
    store_32 [34952], r1
    mov r1, 29281
    lsl r1, r1, 16
    or r1, r1, 25460
    pstore [2188], r1
    store_32 [34956], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2192], r1
    store_32 [34960], r1
    pstore [2196], r8
    store_32 [34964], r8
    pstore [2200], r8
    store_32 [34968], r8
    pstore [2204], r8
    store_32 [34972], r8
    mov r1, 8257
    lsl r1, r1, 16
    or r1, r1, 29298
    pstore [2208], r1
    store_32 [34976], r1
    mov r1, 28535
    lsl r1, r1, 16
    or r1, r1, 8299
    pstore [2212], r1
    store_32 [34980], r1
    mov r1, 25977
    lsl r1, r1, 16
    or r1, r1, 29472
    pstore [2216], r1
    store_32 [34984], r1
    mov r1, 24940
    lsl r1, r1, 16
    or r1, r1, 29551
    pstore [2220], r1
    store_32 [34988], r1
    mov r1, 8307
    lsl r1, r1, 16
    or r1, r1, 30064
    pstore [2224], r1
    store_32 [34992], r1
    mov r1, 28783
    lsl r1, r1, 16
    or r1, r1, 29300
    pstore [2228], r1
    store_32 [34996], r1
    mov r1, 25956
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2232], r1
    store_32 [35000], r1
    pstore [2236], r8
    store_32 [35004], r8
    pstore [2240], r8
    store_32 [35008], r8
    pstore [2244], r8
    store_32 [35012], r8
    pstore [2248], r8
    store_32 [35016], r8
    pstore [2252], r8
    store_32 [35020], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 29984
    pstore [2256], r1
    store_32 [35024], r1
    pstore [2260], r8
    store_32 [35028], r8
    pstore [2264], r8
    store_32 [35032], r8
    mov r1, 8277
    lsl r1, r1, 16
    or r1, r1, 28260
    pstore [2268], r1
    store_32 [35036], r1
    mov r1, 28448
    lsl r1, r1, 16
    or r1, r1, 10351
    pstore [2272], r1
    store_32 [35040], r1
    mov r1, 28261
    lsl r1, r1, 16
    or r1, r1, 8300
    pstore [2276], r1
    store_32 [35044], r1
    mov r1, 25974
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2280], r1
    store_32 [35048], r1
    mov r1, 10528
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2284], r1
    store_32 [35052], r1
    pstore [2288], r8
    store_32 [35056], r8
    pstore [2292], r8
    store_32 [35060], r8
    pstore [2296], r8
    store_32 [35064], r8
    pstore [2300], r8
    store_32 [35068], r8
    pstore [2304], r8
    store_32 [35072], r8
    pstore [2308], r8
    store_32 [35076], r8
    pstore [2312], r8
    store_32 [35080], r8
    pstore [2316], r8
    store_32 [35084], r8
    pstore [2320], r8
    store_32 [35088], r8
    pstore [2324], r8
    store_32 [35092], r8
    pstore [2328], r8
    store_32 [35096], r8
    pstore [2332], r8
    store_32 [35100], r8
    pstore [2336], r8
    store_32 [35104], r8
    pstore [2340], r8
    store_32 [35108], r8
    pstore [2344], r8
    store_32 [35112], r8
    pstore [2348], r8
    store_32 [35116], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 17268
    pstore [2352], r1
    store_32 [35120], r1
    mov r1, 29292
    lsl r1, r1, 16
    or r1, r1, 11090
    pstore [2356], r1
    store_32 [35124], r1
    pstore [2360], r8
    store_32 [35128], r8
    mov r1, 8274
    lsl r1, r1, 16
    or r1, r1, 25956
    pstore [2364], r1
    store_32 [35132], r1
    mov r1, 28448
    lsl r1, r1, 16
    or r1, r1, 10351
    pstore [2368], r1
    store_32 [35136], r1
    mov r1, 28261
    lsl r1, r1, 16
    or r1, r1, 8300
    pstore [2372], r1
    store_32 [35140], r1
    mov r1, 25974
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2376], r1
    store_32 [35144], r1
    mov r1, 10528
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2380], r1
    store_32 [35148], r1
    pstore [2384], r8
    store_32 [35152], r8
    pstore [2388], r8
    store_32 [35156], r8
    pstore [2392], r8
    store_32 [35160], r8
    pstore [2396], r8
    store_32 [35164], r8
    pstore [2400], r8
    store_32 [35168], r8
    pstore [2404], r8
    store_32 [35172], r8
    pstore [2408], r8
    store_32 [35176], r8
    pstore [2412], r8
    store_32 [35180], r8
    pstore [2416], r8
    store_32 [35184], r8
    pstore [2420], r8
    store_32 [35188], r8
    pstore [2424], r8
    store_32 [35192], r8
    pstore [2428], r8
    store_32 [35196], r8
    pstore [2432], r8
    store_32 [35200], r8
    pstore [2436], r8
    store_32 [35204], r8
    pstore [2440], r8
    store_32 [35208], r8
    pstore [2444], r8
    store_32 [35212], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2448], r1
    store_32 [35216], r1
    pstore [2452], r8
    store_32 [35220], r8
    pstore [2456], r8
    store_32 [35224], r8
    pstore [2460], r8
    store_32 [35228], r8
    pstore [2464], r8
    store_32 [35232], r8
    pstore [2468], r8
    store_32 [35236], r8
    pstore [2472], r8
    store_32 [35240], r8
    pstore [2476], r8
    store_32 [35244], r8
    pstore [2480], r8
    store_32 [35248], r8
    pstore [2484], r8
    store_32 [35252], r8
    pstore [2488], r8
    store_32 [35256], r8
    pstore [2492], r8
    store_32 [35260], r8
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [2496], r1
    store_32 [35264], r1
    mov r1, 23328
    lsl r1, r1, 16
    or r1, r1, 22344
    pstore [2500], r1
    store_32 [35268], r1
    mov r1, 18764
    lsl r1, r1, 16
    or r1, r1, 17696
    pstore [2504], r1
    store_32 [35272], r1
    mov r1, 21593
    lsl r1, r1, 16
    or r1, r1, 20553
    pstore [2508], r1
    store_32 [35276], r1
    mov r1, 20039
    lsl r1, r1, 16
    or r1, r1, 8232
    pstore [2512], r1
    store_32 [35280], r1
    mov r1, 18766
    lsl r1, r1, 16
    or r1, r1, 21317
    pstore [2516], r1
    store_32 [35284], r1
    mov r1, 21076
    lsl r1, r1, 16
    or r1, r1, 10528
    pstore [2520], r1
    store_32 [35288], r1
    mov r1, 23868
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [2524], r1
    store_32 [35292], r1
    pstore [2528], r8
    store_32 [35296], r8
    pstore [2532], r8
    store_32 [35300], r8
    pstore [2536], r8
    store_32 [35304], r8
    pstore [2540], r8
    store_32 [35308], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [2544], r1
    store_32 [35312], r1
    mov r1, 15963
    lsl r1, r1, 16
    or r1, r1, 8265
    pstore [2548], r1
    store_32 [35316], r1
    mov r1, 19792
    lsl r1, r1, 16
    or r1, r1, 20306
    pstore [2552], r1
    store_32 [35320], r1
    mov r1, 21569
    lsl r1, r1, 16
    or r1, r1, 20052
    pstore [2556], r1
    store_32 [35324], r1
    mov r1, 8276
    lsl r1, r1, 16
    or r1, r1, 18768
    pstore [2560], r1
    store_32 [35328], r1
    mov r1, 21280
    lsl r1, r1, 16
    or r1, r1, 23868
    pstore [2564], r1
    store_32 [35332], r1
    mov r1, 15420
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2568], r1
    store_32 [35336], r1
    pstore [2572], r8
    store_32 [35340], r8
    pstore [2576], r8
    store_32 [35344], r8
    pstore [2580], r8
    store_32 [35348], r8
    pstore [2584], r8
    store_32 [35352], r8
    pstore [2588], r8
    store_32 [35356], r8
    mov r1, 8261
    lsl r1, r1, 16
    or r1, r1, 28276
    pstore [2592], r1
    store_32 [35360], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2596], r1
    store_32 [35364], r1
    pstore [2600], r8
    store_32 [35368], r8
    mov r1, 8270
    lsl r1, r1, 16
    or r1, r1, 25975
    pstore [2604], r1
    store_32 [35372], r1
    mov r1, 8300
    lsl r1, r1, 16
    or r1, r1, 26990
    pstore [2608], r1
    store_32 [35376], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2612], r1
    store_32 [35380], r1
    pstore [2616], r8
    store_32 [35384], r8
    pstore [2620], r8
    store_32 [35388], r8
    pstore [2624], r8
    store_32 [35392], r8
    pstore [2628], r8
    store_32 [35396], r8
    pstore [2632], r8
    store_32 [35400], r8
    pstore [2636], r8
    store_32 [35404], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 20594
    pstore [2640], r1
    store_32 [35408], r1
    mov r1, 25971
    lsl r1, r1, 16
    or r1, r1, 29472
    pstore [2644], r1
    store_32 [35412], r1
    mov r1, 17774
    lsl r1, r1, 16
    or r1, r1, 29797
    pstore [2648], r1
    store_32 [35416], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 24934
    pstore [2652], r1
    store_32 [35420], r1
    mov r1, 29797
    lsl r1, r1, 16
    or r1, r1, 29216
    pstore [2656], r1
    store_32 [35424], r1
    mov r1, 14880
    lsl r1, r1, 16
    or r1, r1, 25455
    pstore [2660], r1
    store_32 [35428], r1
    mov r1, 28013
    lsl r1, r1, 16
    or r1, r1, 24942
    pstore [2664], r1
    store_32 [35432], r1
    mov r1, 25715
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [2668], r1
    store_32 [35436], r1
    pstore [2672], r8
    store_32 [35440], r8
    pstore [2676], r8
    store_32 [35444], r8
    pstore [2680], r8
    store_32 [35448], r8
    pstore [2684], r8
    store_32 [35452], r8
    mov r1, 8276
    lsl r1, r1, 16
    or r1, r1, 24930
    pstore [2688], r1
    store_32 [35456], r1
    pstore [2692], r8
    store_32 [35460], r8
    pstore [2696], r8
    store_32 [35464], r8
    mov r1, 8265
    lsl r1, r1, 16
    or r1, r1, 28275
    pstore [2700], r1
    store_32 [35468], r1
    mov r1, 25970
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [2704], r1
    store_32 [35472], r1
    mov r1, 13344
    lsl r1, r1, 16
    or r1, r1, 29552
    pstore [2708], r1
    store_32 [35476], r1
    mov r1, 24931
    lsl r1, r1, 16
    or r1, r1, 25971
    pstore [2712], r1
    store_32 [35480], r1
    pstore [2716], r8
    store_32 [35484], r8
    pstore [2720], r8
    store_32 [35488], r8
    pstore [2724], r8
    store_32 [35492], r8
    pstore [2728], r8
    store_32 [35496], r8
    pstore [2732], r8
    store_32 [35500], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 17263
    pstore [2736], r1
    store_32 [35504], r1
    mov r1, 28016
    lsl r1, r1, 16
    or r1, r1, 26988
    pstore [2740], r1
    store_32 [35508], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 24935
    pstore [2744], r1
    store_32 [35512], r1
    mov r1, 24937
    lsl r1, r1, 16
    or r1, r1, 28192
    pstore [2748], r1
    store_32 [35516], r1
    mov r1, 24934
    lsl r1, r1, 16
    or r1, r1, 29797
    pstore [2752], r1
    store_32 [35520], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 25956
    pstore [2756], r1
    store_32 [35524], r1
    mov r1, 26996
    lsl r1, r1, 16
    or r1, r1, 26990
    pstore [2760], r1
    store_32 [35528], r1
    mov r1, 26414
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2764], r1
    store_32 [35532], r1
    pstore [2768], r8
    store_32 [35536], r8
    pstore [2772], r8
    store_32 [35540], r8
    pstore [2776], r8
    store_32 [35544], r8
    pstore [2780], r8
    store_32 [35548], r8
    mov r1, 8258
    lsl r1, r1, 16
    or r1, r1, 24931
    pstore [2784], r1
    store_32 [35552], r1
    mov r1, 27507
    lsl r1, r1, 16
    or r1, r1, 28769
    pstore [2788], r1
    store_32 [35556], r1
    mov r1, 25445
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2792], r1
    store_32 [35560], r1
    mov r1, 8260
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2796], r1
    store_32 [35564], r1
    mov r1, 25972
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2800], r1
    store_32 [35568], r1
    mov r1, 28786
    lsl r1, r1, 16
    or r1, r1, 25974
    pstore [2804], r1
    store_32 [35572], r1
    mov r1, 26991
    lsl r1, r1, 16
    or r1, r1, 30067
    pstore [2808], r1
    store_32 [35576], r1
    mov r1, 8291
    lsl r1, r1, 16
    or r1, r1, 26721
    pstore [2812], r1
    store_32 [35580], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2816], r1
    store_32 [35584], r1
    pstore [2820], r8
    store_32 [35588], r8
    pstore [2824], r8
    store_32 [35592], r8
    pstore [2828], r8
    store_32 [35596], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 20341
    pstore [2832], r1
    store_32 [35600], r1
    mov r1, 29808
    lsl r1, r1, 16
    or r1, r1, 30068
    pstore [2836], r1
    store_32 [35604], r1
    mov r1, 8289
    lsl r1, r1, 16
    or r1, r1, 28260
    pstore [2840], r1
    store_32 [35608], r1
    mov r1, 8293
    lsl r1, r1, 16
    or r1, r1, 29298
    pstore [2844], r1
    store_32 [35612], r1
    mov r1, 28530
    lsl r1, r1, 16
    or r1, r1, 29472
    pstore [2848], r1
    store_32 [35616], r1
    mov r1, 24944
    lsl r1, r1, 16
    or r1, r1, 28773
    pstore [2852], r1
    store_32 [35620], r1
    mov r1, 24946
    lsl r1, r1, 16
    or r1, r1, 8297
    pstore [2856], r1
    store_32 [35624], r1
    mov r1, 28192
    lsl r1, r1, 16
    or r1, r1, 21605
    pstore [2860], r1
    store_32 [35628], r1
    mov r1, 29293
    lsl r1, r1, 16
    or r1, r1, 26990
    pstore [2864], r1
    store_32 [35632], r1
    mov r1, 24940
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [2868], r1
    store_32 [35636], r1
    pstore [2872], r8
    store_32 [35640], r8
    pstore [2876], r8
    store_32 [35644], r8
    mov r1, 8260
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2880], r1
    store_32 [35648], r1
    mov r1, 25972
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2884], r1
    store_32 [35652], r1
    pstore [2888], r8
    store_32 [35656], r8
    mov r1, 8260
    lsl r1, r1, 16
    or r1, r1, 25964
    pstore [2892], r1
    store_32 [35660], r1
    mov r1, 25972
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [2896], r1
    store_32 [35664], r1
    mov r1, 28261
    lsl r1, r1, 16
    or r1, r1, 30836
    pstore [2900], r1
    store_32 [35668], r1
    mov r1, 8291
    lsl r1, r1, 16
    or r1, r1, 26721
    pstore [2904], r1
    store_32 [35672], r1
    mov r1, 29216
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [2908], r1
    store_32 [35676], r1
    pstore [2912], r8
    store_32 [35680], r8
    pstore [2916], r8
    store_32 [35684], r8
    pstore [2920], r8
    store_32 [35688], r8
    pstore [2924], r8
    store_32 [35692], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 17256
    pstore [2928], r1
    store_32 [35696], r1
    mov r1, 24942
    lsl r1, r1, 16
    or r1, r1, 26469
    pstore [2932], r1
    store_32 [35700], r1
    mov r1, 29472
    lsl r1, r1, 16
    or r1, r1, 29537
    pstore [2936], r1
    store_32 [35704], r1
    mov r1, 30309
    lsl r1, r1, 16
    or r1, r1, 25632
    pstore [2940], r1
    store_32 [35708], r1
    mov r1, 20302
    lsl r1, r1, 16
    or r1, r1, 19545
    pstore [2944], r1
    store_32 [35712], r1
    mov r1, 8311
    lsl r1, r1, 16
    or r1, r1, 26996
    pstore [2948], r1
    store_32 [35716], r1
    mov r1, 26656
    lsl r1, r1, 16
    or r1, r1, 14967
    pstore [2952], r1
    store_32 [35720], r1
    mov r1, 8239
    lsl r1, r1, 16
    or r1, r1, 8250
    pstore [2956], r1
    store_32 [35724], r1
    mov r1, 30577
    lsl r1, r1, 16
    or r1, r1, 11808
    pstore [2960], r1
    store_32 [35728], r1
    pstore [2964], r8
    store_32 [35732], r8
    pstore [2968], r8
    store_32 [35736], r8
    pstore [2972], r8
    store_32 [35740], r8
    mov r1, 8275
    lsl r1, r1, 16
    or r1, r1, 26729
    pstore [2976], r1
    store_32 [35744], r1
    mov r1, 26228
    lsl r1, r1, 16
    or r1, r1, 12099
    pstore [2980], r1
    store_32 [35748], r1
    mov r1, 24944
    lsl r1, r1, 16
    or r1, r1, 29472
    pstore [2984], r1
    store_32 [35752], r1
    mov r1, 8276
    lsl r1, r1, 16
    or r1, r1, 31088
    pstore [2988], r1
    store_32 [35756], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 30064
    pstore [2992], r1
    store_32 [35760], r1
    mov r1, 28773
    lsl r1, r1, 16
    or r1, r1, 29283
    pstore [2996], r1
    store_32 [35764], r1
    mov r1, 24947
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [3000], r1
    store_32 [35768], r1
    pstore [3004], r8
    store_32 [35772], r8
    pstore [3008], r8
    store_32 [35776], r8
    pstore [3012], r8
    store_32 [35780], r8
    pstore [3016], r8
    store_32 [35784], r8
    pstore [3020], r8
    store_32 [35788], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 21331
    pstore [3024], r1
    store_32 [35792], r1
    mov r1, 17440
    lsl r1, r1, 16
    or r1, r1, 25455
    pstore [3028], r1
    store_32 [35796], r1
    mov r1, 28276
    lsl r1, r1, 16
    or r1, r1, 25966
    pstore [3032], r1
    store_32 [35800], r1
    mov r1, 29811
    lsl r1, r1, 16
    or r1, r1, 8289
    pstore [3036], r1
    store_32 [35804], r1
    mov r1, 30068
    lsl r1, r1, 16
    or r1, r1, 28461
    pstore [3040], r1
    store_32 [35808], r1
    mov r1, 27759
    lsl r1, r1, 16
    or r1, r1, 24932
    pstore [3044], r1
    store_32 [35812], r1
    mov r1, 8289
    lsl r1, r1, 16
    or r1, r1, 29728
    pstore [3048], r1
    store_32 [35816], r1
    mov r1, 29556
    lsl r1, r1, 16
    or r1, r1, 24946
    pstore [3052], r1
    store_32 [35820], r1
    mov r1, 29813
    lsl r1, r1, 16
    or r1, r1, 28718
    pstore [3056], r1
    store_32 [35824], r1
    pstore [3060], r8
    store_32 [35828], r8
    pstore [3064], r8
    store_32 [35832], r8
    pstore [3068], r8
    store_32 [35836], r8
    pstore [3072], r8
    store_32 [35840], r8
    pstore [3076], r8
    store_32 [35844], r8
    pstore [3080], r8
    store_32 [35848], r8
    pstore [3084], r8
    store_32 [35852], r8
    pstore [3088], r8
    store_32 [35856], r8
    pstore [3092], r8
    store_32 [35860], r8
    pstore [3096], r8
    store_32 [35864], r8
    pstore [3100], r8
    store_32 [35868], r8
    pstore [3104], r8
    store_32 [35872], r8
    pstore [3108], r8
    store_32 [35876], r8
    pstore [3112], r8
    store_32 [35880], r8
    pstore [3116], r8
    store_32 [35884], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3120], r1
    store_32 [35888], r1
    pstore [3124], r8
    store_32 [35892], r8
    pstore [3128], r8
    store_32 [35896], r8
    pstore [3132], r8
    store_32 [35900], r8
    pstore [3136], r8
    store_32 [35904], r8
    pstore [3140], r8
    store_32 [35908], r8
    pstore [3144], r8
    store_32 [35912], r8
    pstore [3148], r8
    store_32 [35916], r8
    pstore [3152], r8
    store_32 [35920], r8
    pstore [3156], r8
    store_32 [35924], r8
    pstore [3160], r8
    store_32 [35928], r8
    pstore [3164], r8
    store_32 [35932], r8
    mov r1, 8254
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [3168], r1
    store_32 [35936], r1
    mov r1, 23328
    lsl r1, r1, 16
    or r1, r1, 17993
    pstore [3172], r1
    store_32 [35940], r1
    mov r1, 21075
    lsl r1, r1, 16
    or r1, r1, 21536
    pstore [3176], r1
    store_32 [35944], r1
    mov r1, 21573
    lsl r1, r1, 16
    or r1, r1, 21332
    pstore [3180], r1
    store_32 [35948], r1
    mov r1, 8272
    lsl r1, r1, 16
    or r1, r1, 21071
    pstore [3184], r1
    store_32 [35952], r1
    mov r1, 18258
    lsl r1, r1, 16
    or r1, r1, 16717
    pstore [3188], r1
    store_32 [35956], r1
    mov r1, 8285
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [3192], r1
    store_32 [35960], r1
    mov r1, 15392
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3196], r1
    store_32 [35964], r1
    pstore [3200], r8
    store_32 [35968], r8
    pstore [3204], r8
    store_32 [35972], r8
    pstore [3208], r8
    store_32 [35976], r8
    pstore [3212], r8
    store_32 [35980], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 15934
    pstore [3216], r1
    store_32 [35984], r1
    mov r1, 15963
    lsl r1, r1, 16
    or r1, r1, 8279
    pstore [3220], r1
    store_32 [35988], r1
    mov r1, 20306
    lsl r1, r1, 16
    or r1, r1, 19270
    pstore [3224], r1
    store_32 [35992], r1
    mov r1, 19535
    lsl r1, r1, 16
    or r1, r1, 22304
    pstore [3228], r1
    store_32 [35996], r1
    mov r1, 23868
    lsl r1, r1, 16
    or r1, r1, 15420
    pstore [3232], r1
    store_32 [36000], r1
    pstore [3236], r8
    store_32 [36004], r8
    pstore [3240], r8
    store_32 [36008], r8
    pstore [3244], r8
    store_32 [36012], r8
    pstore [3248], r8
    store_32 [36016], r8
    pstore [3252], r8
    store_32 [36020], r8
    pstore [3256], r8
    store_32 [36024], r8
    pstore [3260], r8
    store_32 [36028], r8
    mov r1, 8268
    lsl r1, r1, 16
    or r1, r1, 17748
    pstore [3264], r1
    store_32 [36032], r1
    mov r1, 8257
    lsl r1, r1, 16
    or r1, r1, 8253
    pstore [3268], r1
    store_32 [36036], r1
    mov r1, 8242
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3272], r1
    store_32 [36040], r1
    pstore [3276], r8
    store_32 [36044], r8
    pstore [3280], r8
    store_32 [36048], r8
    pstore [3284], r8
    store_32 [36052], r8
    pstore [3288], r8
    store_32 [36056], r8
    pstore [3292], r8
    store_32 [36060], r8
    pstore [3296], r8
    store_32 [36064], r8
    pstore [3300], r8
    store_32 [36068], r8
    pstore [3304], r8
    store_32 [36072], r8
    pstore [3308], r8
    store_32 [36076], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 26912
    pstore [3312], r1
    store_32 [36080], r1
    mov r1, 11582
    lsl r1, r1, 16
    or r1, r1, 8311
    pstore [3316], r1
    store_32 [36084], r1
    mov r1, 29289
    lsl r1, r1, 16
    or r1, r1, 29797
    pstore [3320], r1
    store_32 [36088], r1
    mov r1, 8291
    lsl r1, r1, 16
    or r1, r1, 28516
    pstore [3324], r1
    store_32 [36092], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 11582
    pstore [3328], r1
    store_32 [36096], r1
    mov r1, 8261
    lsl r1, r1, 16
    or r1, r1, 29539
    pstore [3332], r1
    store_32 [36100], r1
    pstore [3336], r8
    store_32 [36104], r8
    pstore [3340], r8
    store_32 [36108], r8
    pstore [3344], r8
    store_32 [36112], r8
    pstore [3348], r8
    store_32 [36116], r8
    pstore [3352], r8
    store_32 [36120], r8
    pstore [3356], r8
    store_32 [36124], r8
    mov r1, 8272
    lsl r1, r1, 16
    or r1, r1, 21065
    pstore [3360], r1
    store_32 [36128], r1
    mov r1, 20052
    lsl r1, r1, 16
    or r1, r1, 8257
    pstore [3364], r1
    store_32 [36132], r1
    mov r1, 8234
    lsl r1, r1, 16
    or r1, r1, 8243
    pstore [3368], r1
    store_32 [36136], r1
    pstore [3372], r8
    store_32 [36140], r8
    pstore [3376], r8
    store_32 [36144], r8
    pstore [3380], r8
    store_32 [36148], r8
    pstore [3384], r8
    store_32 [36152], r8
    pstore [3388], r8
    store_32 [36156], r8
    pstore [3392], r8
    store_32 [36160], r8
    pstore [3396], r8
    store_32 [36164], r8
    pstore [3400], r8
    store_32 [36168], r8
    pstore [3404], r8
    store_32 [36172], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14947
    pstore [3408], r1
    store_32 [36176], r1
    mov r1, 8237
    lsl r1, r1, 16
    or r1, r1, 15904
    pstore [3412], r1
    store_32 [36180], r1
    mov r1, 30561
    lsl r1, r1, 16
    or r1, r1, 26996
    pstore [3416], r1
    store_32 [36184], r1
    mov r1, 8294
    lsl r1, r1, 16
    or r1, r1, 28530
    pstore [3420], r1
    store_32 [36188], r1
    mov r1, 8291
    lsl r1, r1, 16
    or r1, r1, 28525
    pstore [3424], r1
    store_32 [36192], r1
    mov r1, 28777
    lsl r1, r1, 16
    or r1, r1, 27749
    pstore [3428], r1
    store_32 [36196], r1
    mov r1, 8271
    lsl r1, r1, 16
    or r1, r1, 19232
    pstore [3432], r1
    store_32 [36200], r1
    pstore [3436], r8
    store_32 [36204], r8
    pstore [3440], r8
    store_32 [36208], r8
    pstore [3444], r8
    store_32 [36212], r8
    pstore [3448], r8
    store_32 [36216], r8
    pstore [3452], r8
    store_32 [36220], r8
    mov r1, 8261
    lsl r1, r1, 16
    or r1, r1, 20036
    pstore [3456], r1
    store_32 [36224], r1
    pstore [3460], r8
    store_32 [36228], r8
    pstore [3464], r8
    store_32 [36232], r8
    pstore [3468], r8
    store_32 [36236], r8
    pstore [3472], r8
    store_32 [36240], r8
    pstore [3476], r8
    store_32 [36244], r8
    pstore [3480], r8
    store_32 [36248], r8
    pstore [3484], r8
    store_32 [36252], r8
    pstore [3488], r8
    store_32 [36256], r8
    pstore [3492], r8
    store_32 [36260], r8
    pstore [3496], r8
    store_32 [36264], r8
    pstore [3500], r8
    store_32 [36268], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14962
    pstore [3504], r1
    store_32 [36272], r1
    mov r1, 8237
    lsl r1, r1, 16
    or r1, r1, 15904
    pstore [3508], r1
    store_32 [36276], r1
    mov r1, 29541
    lsl r1, r1, 16
    or r1, r1, 25888
    pstore [3512], r1
    store_32 [36280], r1
    mov r1, 21605
    lsl r1, r1, 16
    or r1, r1, 29293
    pstore [3516], r1
    store_32 [36284], r1
    mov r1, 26990
    lsl r1, r1, 16
    or r1, r1, 24940
    pstore [3520], r1
    store_32 [36288], r1
    mov r1, 8306
    lsl r1, r1, 16
    or r1, r1, 25971
    pstore [3524], r1
    store_32 [36292], r1
    mov r1, 30060
    lsl r1, r1, 16
    or r1, r1, 29754
    pstore [3528], r1
    store_32 [36296], r1
    mov r1, 8246
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3532], r1
    store_32 [36300], r1
    pstore [3536], r8
    store_32 [36304], r8
    pstore [3540], r8
    store_32 [36308], r8
    pstore [3544], r8
    store_32 [36312], r8
    pstore [3548], r8
    store_32 [36316], r8
    pstore [3552], r8
    store_32 [36320], r8
    pstore [3556], r8
    store_32 [36324], r8
    pstore [3560], r8
    store_32 [36328], r8
    pstore [3564], r8
    store_32 [36332], r8
    pstore [3568], r8
    store_32 [36336], r8
    pstore [3572], r8
    store_32 [36340], r8
    pstore [3576], r8
    store_32 [36344], r8
    pstore [3580], r8
    store_32 [36348], r8
    pstore [3584], r8
    store_32 [36352], r8
    pstore [3588], r8
    store_32 [36356], r8
    pstore [3592], r8
    store_32 [36360], r8
    pstore [3596], r8
    store_32 [36364], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 14967
    pstore [3600], r1
    store_32 [36368], r1
    mov r1, 8237
    lsl r1, r1, 16
    or r1, r1, 15904
    pstore [3604], r1
    store_32 [36372], r1
    mov r1, 29537
    lsl r1, r1, 16
    or r1, r1, 30309
    pstore [3608], r1
    store_32 [36376], r1
    mov r1, 8308
    lsl r1, r1, 16
    or r1, r1, 28448
    pstore [3612], r1
    store_32 [36380], r1
    mov r1, 21331
    lsl r1, r1, 16
    or r1, r1, 17440
    pstore [3616], r1
    store_32 [36384], r1
    pstore [3620], r8
    store_32 [36388], r8
    pstore [3624], r8
    store_32 [36392], r8
    pstore [3628], r8
    store_32 [36396], r8
    pstore [3632], r8
    store_32 [36400], r8
    pstore [3636], r8
    store_32 [36404], r8
    pstore [3640], r8
    store_32 [36408], r8
    pstore [3644], r8
    store_32 [36412], r8
    pstore [3648], r8
    store_32 [36416], r8
    pstore [3652], r8
    store_32 [36420], r8
    pstore [3656], r8
    store_32 [36424], r8
    pstore [3660], r8
    store_32 [36428], r8
    pstore [3664], r8
    store_32 [36432], r8
    pstore [3668], r8
    store_32 [36436], r8
    pstore [3672], r8
    store_32 [36440], r8
    pstore [3676], r8
    store_32 [36444], r8
    pstore [3680], r8
    store_32 [36448], r8
    pstore [3684], r8
    store_32 [36452], r8
    pstore [3688], r8
    store_32 [36456], r8
    pstore [3692], r8
    store_32 [36460], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3696], r1
    store_32 [36464], r1
    pstore [3700], r8
    store_32 [36468], r8
    pstore [3704], r8
    store_32 [36472], r8
    pstore [3708], r8
    store_32 [36476], r8
    pstore [3712], r8
    store_32 [36480], r8
    pstore [3716], r8
    store_32 [36484], r8
    pstore [3720], r8
    store_32 [36488], r8
    pstore [3724], r8
    store_32 [36492], r8
    pstore [3728], r8
    store_32 [36496], r8
    pstore [3732], r8
    store_32 [36500], r8
    pstore [3736], r8
    store_32 [36504], r8
    pstore [3740], r8
    store_32 [36508], r8
    mov r1, 8275
    lsl r1, r1, 16
    or r1, r1, 31085
    pstore [3744], r1
    store_32 [36512], r1
    mov r1, 28776
    lsl r1, r1, 16
    or r1, r1, 28526
    pstore [3748], r1
    store_32 [36516], r1
    mov r1, 31008
    lsl r1, r1, 16
    or r1, r1, 22121
    pstore [3752], r1
    store_32 [36520], r1
    mov r1, 27936
    lsl r1, r1, 16
    or r1, r1, 26995
    pstore [3756], r1
    store_32 [36524], r1
    mov r1, 8289
    lsl r1, r1, 16
    or r1, r1, 8307
    pstore [3760], r1
    store_32 [36528], r1
    mov r1, 28001
    lsl r1, r1, 16
    or r1, r1, 27756
    pstore [3764], r1
    store_32 [36532], r1
    mov r1, 8278
    lsl r1, r1, 16
    or r1, r1, 26989
    pstore [3768], r1
    store_32 [36536], r1
    mov r1, 11628
    lsl r1, r1, 16
    or r1, r1, 26987
    pstore [3772], r1
    store_32 [36540], r1
    mov r1, 25888
    lsl r1, r1, 16
    or r1, r1, 29557
    pstore [3776], r1
    store_32 [36544], r1
    mov r1, 25203
    lsl r1, r1, 16
    or r1, r1, 25972
    pstore [3780], r1
    store_32 [36548], r1
    mov r1, 11808
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3784], r1
    store_32 [36552], r1
    pstore [3788], r8
    store_32 [36556], r8
    mov r1, 31776
    lsl r1, r1, 16
    or r1, r1, 20584
    pstore [3792], r1
    store_32 [36560], r1
    mov r1, 31091
    lsl r1, r1, 16
    or r1, r1, 26979
    pstore [3796], r1
    store_32 [36564], r1
    mov r1, 24940
    lsl r1, r1, 16
    or r1, r1, 8268
    pstore [3800], r1
    store_32 [36568], r1
    mov r1, 28515
    lsl r1, r1, 16
    or r1, r1, 24948
    pstore [3804], r1
    store_32 [36572], r1
    mov r1, 26991
    lsl r1, r1, 16
    or r1, r1, 28192
    pstore [3808], r1
    store_32 [36576], r1
    mov r1, 27493
    lsl r1, r1, 16
    or r1, r1, 31074
    pstore [3812], r1
    store_32 [36580], r1
    mov r1, 28513
    lsl r1, r1, 16
    or r1, r1, 29284
    pstore [3816], r1
    store_32 [36584], r1
    mov r1, 8306
    lsl r1, r1, 16
    or r1, r1, 25969
    pstore [3820], r1
    store_32 [36588], r1
    mov r1, 30057
    lsl r1, r1, 16
    or r1, r1, 29285
    pstore [3824], r1
    store_32 [36592], r1
    mov r1, 25646
    lsl r1, r1, 16
    or r1, r1, 8224
    pstore [3828], r1
    store_32 [36596], r1
    pstore [3832], r8
    store_32 [36600], r8
    pstore [3836], r8
    store_32 [36604], r8

    ; Verify every saved 32-bit word using pload.
    mov r3, 0           ; SSD read address, bytes
    mov r4, 32768       ; expected RAM copy
CHECK_LOOP:
    pload r5, [r3]
    add r6, r4, r3
    load_32 r7, [r6]
    cmp r5, r7
    jne VERIFY_FAIL
    add r3, r3, 4
    cmp r3, 3840
    jb CHECK_LOOP
    out 501
HALT:
    jmp HALT
VERIFY_FAIL:
    out 598
FAIL_HALT:
    jmp FAIL_HALT
