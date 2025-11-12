
DATA SEGMENT
    num1 DW 32767  
    num2 DW 1          
    result DW ?         
    overflow_msg DB 'Error: Overflow occurred!', 0Dh, 0Ah, '$'
    success_msg DB 'Addition successful. Result: $'
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA

START:
    MOV AX, DATA
    MOV DS, AX         

    MOV AX, num1     
    ADD AX, num2       
    MOV result, AX     

    JO OVERFLOW_DETECTED 

    LEA DX, success_msg
    MOV AH, 09h
    INT 21h       
    
    MOV BX, result
    CALL DISPLAY_NUMBER
    JMP EXIT_PROGRAM

OVERFLOW_DETECTED:
    LEA DX, overflow_msg
    MOV AH, 09h
    INT 21h           

EXIT_PROGRAM:
    MOV AH, 4Ch      
    INT 21h


DISPLAY_NUMBER PROC
    MOV DL, 'R' 
    MOV AH, 02h
    INT 21h
    RET
DISPLAY_NUMBER ENDP

CODE ENDS
END START