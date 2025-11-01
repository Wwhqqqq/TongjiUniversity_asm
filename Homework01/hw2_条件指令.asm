DATA SEGMENT
    NEWLINE DB 0DH, 0AH, '$'    ; 回车换行符
    SPACE DB ' $'               ; 空格字符
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX                  ; 设置数据段
    
    MOV CX, 2                   ; 外层循环计数器（2行）
    MOV BL, 'a'                 ; 起始字符 'a'
    
OUTER_LOOP:
    PUSH CX                     ; 保存外层循环计数器
    MOV CX, 13                  ; 内层循环计数器（每行13个字符）
    
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
    
    ; 条件跳转实现循环
    DEC CX                      ; 内层循环计数器减1
    CMP CX, 0                   ; 比较CX与0
    JNE INNER_LOOP              ; 如果CX≠0，跳转到INNER_LOOP
    
    ; 打印换行
    MOV DX, OFFSET NEWLINE
    MOV AH, 09H
    INT 21H
    
    POP CX                      ; 恢复外层循环计数器
    
    ; 条件跳转实现循环
    DEC CX                      ; 外层循环计数器减1
    CMP CX, 0                   ; 比较CX与0
    JNE OUTER_LOOP              ; 如果CX≠0，跳转到OUTER_LOOP
    
    ; 程序结束
    MOV AH, 4CH
    INT 21H
CODE ENDS
END START