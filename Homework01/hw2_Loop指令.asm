DATA SEGMENT
    NEWLINE DB 0DH, 0AH, '$'    ; 回车换行符
    SPACE DB ' $'               ; 空格字符
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX                  ; 设置数据段
    
    MOV CL, 2                   ; 外层循环计数器（2行）
    MOV BL, 'a'                 ; 起始字符 'a'
    
OUTER_LOOP:
    MOV CH, 13                  ; 内层循环计数器（每行13个字符）
    
INNER_LOOP:
    ; 打印当前字符
    MOV DL, BL
    MOV AH, 02H
    INT 21H
    
    ; 打印空格
    MOV DX, OFFSET SPACE
    MOV AH, 09H
    INT 21H
    
    INC BL                      ; 移动到下一个字符
    DEC CH                      ; 内层循环计数器减1
    JNZ INNER_LOOP              ; 如果CH≠0，继续内层循环
    
    ; 打印换行
    MOV DX, OFFSET NEWLINE
    MOV AH, 09H
    INT 21H
    
    DEC CL                      ; 外层循环计数器减1
    JNZ OUTER_LOOP              ; 如果CL≠0，继续外层循环
    
    ; 程序结束
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START