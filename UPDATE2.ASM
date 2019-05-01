.Model Small
.Stack 100h
.Data 
    a dw 60 
    b dw 40
    POS dw 1
    P1 dw -1
    P2 dw -1
    P3 dw -1
    P4 dw -1
    P5 dw -1
    P6 dw -1
    P7 dw -1
    P8 dw -1
    P9 dw -1 
    
    x111 dw -1
    y111 dw -1
    
    c dw ?
    d db ?
    E DW ?
    
    checkX dw 0
    checkO dw 0
    
    msg1 db 'P','L','A','Y','E','R',':','1',' ','W','I','N','S'
    msg2 db 'P','L','A','Y','E','R',':','2',' ','W','I','N','S'
    msg3 db 'P','R','E','S','S',' ','E','N','T','E','R',' ','T','O',' ','P','L','A','Y',' ','A','G','A','I','N','-','-','-'
    msg4 db 'P','L','A','Y','E','R',' ','1',' ','P','R','E','S','S',' ',':',' ','X'
    msg5 db 'P','L','A','Y','E','R',' ','2',' ','P','R','E','S','S',' ',':',' ','O'
    
    
    
    
    

.Code
main Proc 
    mov ax,@data
    mov ds,ax 
    
    
    
    
    
    
    
    
    
    
    CALL SET
    call borobox
    
    MOV AH, 0CH ;draw pixel
    MOV AL, 10  ;green for chotobox
    call chotobox
    
    call SCAN
    

    
    MOV AX, 3
    INT 10h
    MOV AH, 4CH
    INT 21h
  RET
    MAIN ENDP
    
SCAN PROC
     
     TOP:
     CALL DRAWX
     CALL DRAW0
     CALL CHECK
    ;//////////////////////////////////////////// 
    MOV SI,0
    MOV d,1
    L8:
    XOR DX,DX
    MOV DH,21   ;row number
    MOV DL,d  ;column number
    MOV AH, 02  
    MOV BH, 0  ;page number
    INT 10h    ;move cursor
    
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg4[si]  ;character code
    MOV BL,1
    MOV CX, 1    ;number of repetetion
    INT 10h
    
    INC SI
    INC d
    
    CMP d,19
    JL L8
    ;///////////////////////////////////////////////////////////////
    MOV SI,0
    MOV d,1
    L9:
    XOR DX,DX
    MOV DH,23   ;row number
    MOV DL,d  ;column number
    MOV AH, 02  
    MOV BH, 0  ;page number
    INT 10h    ;move cursor
    
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg5[si]  ;character code
    MOV BL,1
    MOV CX, 1    ;number of repetetion
    INT 10h
    
    INC SI
    INC d
    
    CMP d,19
    JL L9
    ;///////////////////////////////////////
     
     mov ah,0
     int 16h
     
     
     
     
     
     cmp ah,77
     je right
     cmp ah,75
     je left
     cmp ah,80
     JE Z
     cmp ah,72
     je up
     cmp ah,45
     JE X
     cmp ah,24
     JE Y
     JMP TOP
    RIGHT:
    
    CMP a,180
    JE STEP2
    ADD POS,1
    MOV AH,0CH
    MOV AL,3
    CALL CHOTOBOX
    ADD A,60
    MOV AH,0CH
    MOV AL,10
    CALL CHOTOBOX  
    JMP STEP1
    
    LEFT:
    
    CMP a,60
    JE STEP2
    SUB POS,1
    MOV AH,0CH
    MOV AL,3
    CALL CHOTOBOX
    sub A,60
    MOV AH,0CH
    MOV AL,10
    CALL CHOTOBOX
 
    JMP STEP1
    X:
    JMP XX
    Y:
    JMP X0
    
    Z:
    JMP DOWN 
    
    STEP2:
    JMP STEP1
    UP:
     CMP b,40
     JE STEP1
     SUB POS,3
    MOV AH,0CH
    MOV AL,3
    CALL CHOTOBOX
    sub b,40
    MOV AH,0CH
    MOV AL,10
    CALL CHOTOBOX 
    
    JMP STEP1
    down:
    cmp b,120
    je STEP1
    ADD POS,3
    MOV AH,0CH
    MOV AL,3
    CALL CHOTOBOX
    ADD b,40
    MOV AH,0CH
    MOV AL,10
    CALL CHOTOBOX
    JMP STEP1
    XX:
    
    CMP checkX,1
    JE STEP1
    
    CALL SETX
    CALL CHECK
    
    CMP X111,1
    JE  NEWSCREEN
    
    
    MOV checkX,1
    MOV checkO,0
    
    
    JMP TOP
    STEP1:
    JMP TOP
    
    X0:
    
    CMP checkO,1
    JE STEP1
    
    
    CALL SET0
    CALL CHECK
    
    
    CMP Y111,1
    JE NEWSCREEN
    
    MOV checkX,0
    MOV checkO,1
    
    
    JMP TOP
    
    
    NEWSCREEN:
         MOV AH,1H
         INT 21H
         
         CMP AL,13
         JE NEWSCREEN2
         JMP NEWSCREEN
    NEWSCREEN2:
         
         
         MOV a,60 
         MOV b,40
         MOV POS,1
         MOV P1,-1
         MOV P2,-1
         MOV P3,-1
         MOV P4 ,-1
         MOV P5,-1
         MOV P6,-1
         MOV P7,-1
         MOV P8,-1
         MOV P9,-1
         
         MOV x111,-1
         MOV y111,-2
         
         MOV E,0
         
         
         CALL SET
         call borobox
    
         MOV AH, 0CH ;draw pixel
         MOV AL, 10  ;green for chotobox
         call chotobox
         
         JMP TOP
     RET
    SCAN ENDP
    
SETX PROC
    
    E1:
    CMP POS,1
    JNE E2
    CMP P1,-1
    JNE STEP4
    MOV P1,1
    JMP STEP3
    
    E2:
    CMP POS,2
    JNE E3
    CMP P2,-1
    JNE STEP4
    MOV P2,1
    JMP STEP3
    
    E3:
    CMP POS,3
    JNE E4
    CMP P3,-1
    JNE STEP4
    MOV P3,1
    JMP STEP3
    
    E4:
    CMP POS,4
    JNE E5
    CMP P4,-1
    JNE STEP3
    MOV P4,1
    JMP STEP3
    
    E5:
    CMP POS,5
    JNE E6
    CMP P5,-1
    JNE STEP3
    MOV P5,1
    JMP STEP3
    
    E6:
    CMP POS,6
    JNE E7
    CMP P6,-1
    JNE STEP3
    MOV P6,1
    JMP STEP3
    
    STEP4:
    JMP STEP3
    
    E7:
    CMP POS,7
    JNE E8
    CMP P7,-1
    JNE STEP3
    MOV P7,1
    JMP STEP3
    
    E8:
    CMP POS,8
    JNE E9
    CMP P8,-1
    JNE STEP3
    MOV P8,1
    JMP STEP3
    
    E9:
    CMP POS,9
    JNE STEP3
    CMP P9,-1
    JNE STEP3
    MOV P9,1
    JMP STEP3
    
    STEP3:
    CALL DRAWX
    RET
    SETX ENDP
    
DRAWX PROC

    F1:
    CMP P1,1
    JNE F2
    MOV DH,7
    MOV DL,11
    CALL DRAWX1

    F2:
    CMP P2,1
    JNE F3
    MOV DH,7
    MOV DL,18
    CALL DRAWX1

    F3:
    CMP P3,1
    JNE F4
    MOV DH,7
    MOV DL,25
    CALL DRAWX1

    F4:
    CMP P4,1
    JNE F5
    MOV DH,12
    MOV DL,11
    CALL DRAWX1

    F5:
    CMP P5,1
    JNE F6
    MOV DH,12
    MOV DL,18
    CALL DRAWX1

    F6:
    CMP P6,1
    JNE F7
    MOV DH,12
    MOV DL,25
    CALL DRAWX1

    F7:
    CMP P7,1
    JNE F8
    MOV DH,17
    MOV DL,11
    CALL DRAWX1

    F8:
    CMP P8,1
    JNE F9
    MOV DH,17
    MOV DL,18
    CALL DRAWX1

    F9:
    CMP P9,1
    JNE STEP5
    MOV DH,17
    MOV DL,25
    CALL DRAWX1
    
    STEP5:
    RET 
    DRAWX ENDP
    
DRAWX1 PROC  
    
    ;INT 10H FUNCTION 02H -move cursor
    MOV AH, 02
    MOV BH, 0
    INT 10H 
    
    ;INT 10H FUNCTION 09H - write character to screen   
    MOV AH, 9
    MOV AL, 'X'
    MOV BL,1    ;character attribute for foreground color
    MOV CX, 1
    INT 10h
    RET
    DRAWX1 ENDP
    
SET0 PROC
    G1:
    CMP POS,1
    JNE G2
    CMP P1,-1
    JNE STEP7
    MOV P1,4
    JMP STEP6
    
    G2:
    CMP POS,2
    JNE G3
    CMP P2,-1
    JNE STEP7
    MOV P2,4
    JMP STEP6
    
    G3:
    CMP POS,3
    JNE G4
    CMP P3,-1
    JNE STEP7
    MOV P3,4
    JMP STEP6
    
    G4:
    CMP POS,4
    JNE G5
    CMP P4,-1
    JNE STEP6
    MOV P4,4
    JMP STEP6
    
    G5:
    CMP POS,5
    JNE G6
    CMP P5,-1
    JNE STEP6
    MOV P5,4
    JMP STEP6
    
    G6:
    CMP POS,6
    JNE G7
    CMP P6,-1
    JNE STEP6
    MOV P6,4
    JMP STEP6
    
    STEP7:
    JMP STEP6
    
    G7:
    CMP POS,7
    JNE G8
    CMP P7,-1
    JNE STEP6
    MOV P7,4
    JMP STEP6
    
    G8:
    CMP POS,8
    JNE G9
    CMP P8,-1
    JNE STEP6
    MOV P8,4
    JMP STEP6
    
    G9:
    CMP POS,9
    JNE STEP6
    CMP P9,-1
    JNE STEP6
    MOV P9,4
    JMP STEP6
    
    STEP6:
    CALL DRAW0
    RET
    SET0 ENDP
    
DRAW0 PROC

    H1:
    CMP P1,4
    JNE H2
    MOV DH,7
    MOV DL,11
    CALL DRAW01

    H2:
    CMP P2,4
    JNE H3
    MOV DH,7
    MOV DL,18
    CALL DRAW01

    H3:
    CMP P3,4
    JNE H4
    MOV DH,7
    MOV DL,25
    CALL DRAW01

    H4:
    CMP P4,4
    JNE H5
    MOV DH,12
    MOV DL,11
    CALL DRAW01

    H5:
    CMP P5,4
    JNE H6
    MOV DH,12
    MOV DL,18
    CALL DRAW01

    H6:
    CMP P6,4
    JNE H7
    MOV DH,12
    MOV DL,25
    CALL DRAW01

    H7:
    CMP P7,4
    JNE H8
    MOV DH,17
    MOV DL,11
    CALL DRAW01

    H8:
    CMP P8,4
    JNE H9
    MOV DH,17
    MOV DL,18
    CALL DRAW01

    H9:
    CMP P9,4
    JNE STEP8
    MOV DH,17
    MOV DL,25
    CALL DRAW01
    
    STEP8:
    RET 
    DRAW0 ENDP
    
DRAW01 PROC
    MOV AH, 02
    MOV BH, 0
    INT 10H 
    
    ;INT 10H FUNCTION 09H - write character to screen   
    MOV AH, 9
    MOV AL, 'O'  
    MOV CX, 1
    MOV BL,1
    INT 10h
    RET
    DRAW01 ENDP
    
    
CHECK PROC
    

    XOR BX,BX      ;1
    ADD BX,P1
    ADD BX,P2
    ADD BX,P3
    CMP BX,3
    JNE LPX1
    MOV E,1
    JMP STEP99
    LPX1:
    CMP BX,12
    JNE LPO1
    MOV E,1
    JMP STEP100
    LPO1:


    XOR BX, BX        ;2
    ADD BX,P4
    ADD BX,P5
    ADD BX,P6
    CMP BX,3
    JNE LPX2
    MOV E,2
    JMP STEP99
    LPX2:
    CMP BX,12
    JNE LPO2
    MOV E,2
    JMP STEP100
    LPO2:

    XOR BX, BX       ;3
    ADD BX,P7
    ADD BX,P8
    ADD BX,P9
    CMP BX,3
    JNE LPX3
    MOV E,3
    JMP STEP9
    LPX3:
    CMP BX,12
    JNE LPO3
    MOV E,3
    JMP STEP10
    LPO3:
    JMP N1
    
    STEP99:
    JMP STEP9
    STEP100:
    JMP STEP10
    
    N1:
    XOR BX, BX      ;4
    ADD BX,P1
    ADD BX,P4
    ADD BX,P7
    CMP BX,3
    JNE LPX4
    MOV E,4
    JMP STEP9
    LPX4:
    CMP BX,12
    JNE LPO4
    MOV E,4
    JMP STEP10
    LPO4:
    JMP N2

    STEP9:
    JMP WIN1 
    STEP10:
    JMP WIN2

    N2:                         ;5
    XOR BX, BX
    ADD BX,P2
    ADD BX,P5
    ADD BX,P8
    CMP BX,3
    JNE LPX5
    MOV E,5
    JMP WIN11
    LPX5:
    CMP BX,12
    JNE LPO5
    MOV E,5
    JMP WIN22
    LPO5:
    
    

    XOR BX, BX        ;6
    ADD BX,P3
    ADD BX,P6
    ADD BX,P9
    CMP BX,3
    JNE LPX6
    MOV E,6
    JMP WIN11
    LPX6:
    CMP BX,12
    JNE LPO6
    MOV E,6
    JMP WIN22
    LPO6:

    XOR BX, BX        ;7
    ADD BX,P1
    ADD BX,P5
    ADD BX,P9
    CMP BX,3
    JNE LPX7
    MOV E,7     
    JMP WIN1
    LPX7:
    CMP BX,12
    JNE LPO7
    MOV E,7
    JMP WIN2
    LPO7:
    JMP N3
    
    WIN11:
    JE WIN1
    WIN22:
    JE WIN2
    
     
    N3:
    XOR BX, BX          ;8
    ADD BX,P3
    ADD BX,P5
    ADD BX,P7    
    CMP BX,3
    JNE LPX8
    MOV E,8
    JMP WIN1
    LPX8:
    CMP BX,12
    JNE LPO8
    MOV E,8
    JMP WIN2
    LPO8:
    JMP STEP12
    
    
    
    
    WIN1:
      CALL PRINT1 
    JMP STEP12 
    
    WIN2:
     CALL PRINT2
    JMP STEP12 
    
    STEP12:
    RET 
    CHECK ENDP
    
PRINT1 PROC
    
    ;INT 10H FUNCTION 02H -move cursor
    MOV SI,0
    MOV d,1
    L1:
    XOR DX,DX
    MOV DH,1   ;row number
    MOV DL,d  ;column number
    MOV AH, 02  
    MOV BH, 0  ;page number
    INT 10h    ;move cursor
    
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg1[si]  ;character code
    MOV CX, 1    ;number of repetetion
    INT 10h
    
    INC SI
    INC d
    
    CMP d,14
    JL L1
    
    ;///////////////////
    
    MOV SI,0
    MOV d,1
    L3:
    XOR DX,DX
    MOV DH,3   ;row number
    MOV DL,d  ;column number
    MOV AH, 02  
    MOV BH, 0  ;page number
    INT 10h    ;move cursor
    
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg3[si]  ;character code
    MOV CX, 1    ;number of repetetion
    INT 10h
    
    INC SI
    INC d
    
    CMP d,29
    JL L3
    
    
    MOV X111,1
    
    ;///////////////////////////
    ;FOR LINE PRINT OVER THE RESULT
    MOV AH, 0CH
    MOV AL, 3
    
    ;;MOV E,8
    CMP E,1
    JNE LINE2
    LINE1:
    MOV CX,70
    MOV DX,60
    R11: INT 10h
    INC CX
    
    CMP CX,230
    JLE R11
    JMP END__1
    
    LINE2:
    
    CMP E,2
    JNE LINE3
    
    MOV CX,70
    MOV DX,100
    R12: INT 10h
    INC CX
    CMP CX,230
    JLE R12
    JMP END__1
    
    LINE3:
    CMP E,3
    JNE LINE4
    
    MOV CX,70
    MOV DX,140
    R13: INT 10h
    INC CX
    CMP CX,230
    JLE R13
    JMP END__1
    
    LINE4:
    CMP E,4
    JNE LINE5
    
    MOV CX,90
    MOV DX,50
    R14: INT 10h
    INC DX
    CMP DX,150
    JLE R14
    JMP END__1
    
    LINE5:
    CMP E,5
    JNE LINE6
    
    MOV CX,150
    MOV DX,50
    R15: INT 10h
    INC DX
    CMP DX,150
    JLE R15
    JMP END__1
    
    LINE6:
    CMP E,6
    JNE LINE7
    
    MOV CX,205
    MOV DX,50
    R16: INT 10h
    INC DX
    CMP DX,150
    JLE R16
    JMP END__1
    
    LINE7:
    CMP E,7
    JNE LINE8
    
    MOV CX, 60 ; beginning col
    MOV DX, 40 ; beginning row
    ; mov BX,a
    ;   add BX,60
    MOV c,0
    R17: INT 10h
    INC CX
    INC DX
    INC c
        CMP CX, 240
        JLE R18
        JMP END__1
    R18:
    CMP C,2
    JL R17
    INC CX
    MOV C,0
    JMP R17
    
    LINE8:
    MOV CX, 240 ; beginning col
    MOV DX, 40 ; beginning row
    ; mov BX,a
    ;   add BX,60
    MOV c,0
    R19: INT 10h
    DEC CX
    INC DX
    INC c
    CMP CX, 60
    JGE R20
        JMP END__1
        R20:
    CMP C,2
    JL R19
    DEC CX
    MOV C,0
    JMP R19
    
    
    END__1:
    RET
    PRINT1 ENDP
    
PRINT2 PROC  
    
    ;INT 10H FUNCTION 02H -move cursor
    MOV SI,0
    MOV d,1
    L2:    
    XOR DX,DX
    MOV DH,1
    MOV DL,d 
    MOV AH, 02
    MOV BH, 0
    INT 10h 
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg2[SI]
    MOV CX, 1
    INT 10h
    
    INC SI
    INC d
    
    CMP d,14
    JL L2
    ;/////////////////
    
    MOV SI,0
    MOV d,1
    L4:
    XOR DX,DX
    MOV DH,3   ;row number
    MOV DL,d  ;column number
    MOV AH, 02  
    MOV BH, 0  ;page number
    INT 10h    ;move cursor
    
    
    ;INT 10H FUNCTION 09H - write character to screen
    MOV AH, 9
    MOV AL, msg3[si]  ;character code
    MOV CX, 1    ;number of repetetion
    INT 10h
    
    INC SI
    INC d
    
    CMP d,29
    JL L4
    
    
    mov y111,1
    ;////////////////////////
    ;///////////////////////////
    ;FOR LINE PRINT OVER THE RESULT
    MOV AH, 0CH
    MOV AL, 3
    
    ;;MOV E,8
    CMP E,1
    JNE LINE12
    LINE11:
    MOV CX,70
    MOV DX,60
    R31: INT 10h
    INC CX
    
    CMP CX,230
    JLE R31
    JMP END__2
    
    LINE12:
    
    CMP E,2
    JNE LINE13
    
    MOV CX,70
    MOV DX,100
    R32: INT 10h
    INC CX
    CMP CX,230
    JLE R32
    JMP END__2
    
    LINE13:
    CMP E,3
    JNE LINE14
    
    MOV CX,70
    MOV DX,140
    R33: INT 10h
    INC CX
    CMP CX,230
    JLE R33
    JMP END__2
    
    LINE14:
    CMP E,4
    JNE LINE15
    
    MOV CX,90
    MOV DX,50
    R34: INT 10h
    INC DX
    CMP DX,150
    JLE R34
     JMP END__2
    
     LINE15:
    CMP E,5
    JNE LINE16
    
    MOV CX,150
    MOV DX,50
    R35: INT 10h
    INC DX
    CMP DX,150
    JLE R35
    JMP END__2
    
    LINE16:
    CMP E,6
    JNE LINE17
    
    MOV CX,205
    MOV DX,50
    R36: INT 10h
    INC DX
    CMP DX,150
    JLE R36
    JMP END__2
    
    LINE17:
    CMP E,7
    JNE LINE18
    
    MOV CX, 60 ; beginning col
    MOV DX, 40 ; beginning row
    ; mov BX,a
    ;   add BX,60
    MOV c,0
    R37: INT 10h
    INC CX
    INC DX
    INC c
        CMP CX, 240
        JLE R38
        JMP END__2
        R38:
    CMP C,2
    JL R37
    INC CX
    MOV C,0
    JMP R37
    
    LINE18:
    MOV CX, 240 ; beginning col
    MOV DX, 40 ; beginning row
    ; mov BX,a
    ;   add BX,60
    MOV c,0
    R39: INT 10h
    DEC CX
    INC DX
    INC c
    CMP CX, 60
    JGE R30
    JMP END__2
    R30:
    CMP C,2
    JL R39
    DEC CX
    MOV C,0
    JMP R39
    
    
    END__2:
    
    RET
    PRINT2 ENDP
    
    
SET PROC

; set CGA 640x200 high res mode
    MOV AX,13h
    INT 10h
    ;/////////////////////////////////////////
    ;INT 10H FUNCTION 02H -move cursor
    
    
; draw line pixel by pixel  
    MOV AH, 0BH
    MOV AL, 0
    
    RET
SET ENDP
  
borobox proc 
    
    


    MOV AH, 0CH
    MOV AL, 3
       
    MOV CX, 60 ; beginning col
    MOV DX, 40 ; beginning row
    
    R1: INT 10h
        INC CX
        CMP CX, 240
        JLE R1
        
        MOV CX, 60 ; beginning col
        MOV DX, 80 ; beginning row
    
        R2: INT 10h
        INC CX
        CMP CX, 240
        JLE R2
        
        MOV CX, 60 ; beginning col
        MOV DX, 120 ; beginning row
    
        R3: INT 10h
        INC CX
        CMP CX, 240
        JLE R3
        
        MOV CX, 60 ; beginning col
        MOV DX, 160 ; beginning row
    
        R4: INT 10h
        INC CX
        CMP CX, 240
        JLE R4
        
        MOV CX, 60 ; beginning col
        MOV DX, 40 ; beginning row
    
        C1: INT 10h
        INC DX
        CMP DX, 160
        JLE C1
        
        MOV CX, 120 ; beginning col
        MOV DX, 40 ; beginning row
    
        C2: INT 10h
        INC DX
        CMP DX, 160
        JLE C2
            
        MOV CX, 180 ; beginning col
        MOV DX, 40 ; beginning row
        
        C3: INT 10h
        INC DX
        CMP DX, 160
        JLE C3
            
        MOV CX, 240 ; beginning col
        MOV DX, 40 ; beginning row
        
        C4: INT 10h
        INC DX
        CMP DX, 160
        JLE C4
        ret
        borobox ENDP
        
        
chotobox proc
        
        
        MOV CX, a ; beginning col
        MOV DX, b ; beginning row
        mov BX,a
        add BX,60
    
        S1: INT 10h
        INC CX
        CMP CX, BX
        JLE S1
        
        
        MOV CX, a ; beginning col
        MOV DX, b ; beginning row
        ADD DX,40
        
        S2: INT 10h
        INC CX
        CMP CX, BX
        JLE S2
        
        MOV CX, a ; beginning col
        MOV DX, b ; beginning row
        mov BX,b
        add BX,40    
        D1: INT 10h
        INC DX
        CMP DX, BX
        JLE D1
        
        MOV CX, a ; beginning col
        add cx,60
        MOV DX, b ; beginning row
    
        D2: INT 10h
        INC DX
        CMP DX, BX
        JLE D2
        ret
        chotobox ENDP
        
        
        end main  