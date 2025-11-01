; 作业3：求和程序
; 文件名：Sum5050.asm

DATA SEGMENT
    RESULT_MSG DB '1+2+...+100 = $'
    NEWLINE DB 13,10,'$'  ; 回车换行
    RESULT DW 0           ; 存放结果的变量
DATA ENDS

STACK SEGMENT STACK
    DW 100H DUP(0)       ; 栈空间
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:STACK

START:
    ; 初始化数据段
    MOV AX, DATA
    MOV DS, AX
    
    ; 方法1：结果放在寄存器中
    CALL SUM_IN_REGISTER
    
    ; 显示结果
    CALL DISPLAY_RESULT
    
    ; 方法2：结果放在数据段中
    CALL SUM_IN_DATA_SEGMENT
    
    ; 显示结果
    CALL DISPLAY_RESULT
    
    ; 方法3：结果放在栈中
    CALL SUM_IN_STACK
    
    ; 显示结果
    CALL DISPLAY_RESULT_FROM_STACK
    
    ; 程序结束
    MOV AH, 4CH
    INT 21H

; 方法1：结果放在寄存器AX中
SUM_IN_REGISTER PROC
    XOR AX, AX           ; 清空AX
    MOV CX, 100          ; 循环100次
    MOV BX, 1            ; 从1开始
    
SUM_LOOP1:
    ADD AX, BX           ; AX = AX + BX
    INC BX               ; BX加1
    LOOP SUM_LOOP1       ; 循环直到CX=0
    
    MOV RESULT, AX       ; 保存结果到数据段
    RET
SUM_IN_REGISTER ENDP

; 方法2：结果直接放在数据段变量中
SUM_IN_DATA_SEGMENT PROC
    MOV RESULT, 0        ; 初始化结果为0
    MOV CX, 100          ; 循环100次
    MOV BX, 1            ; 从1开始
    
SUM_LOOP2:
    ADD RESULT, BX       ; 直接加到数据段变量
    INC BX               ; BX加1
    LOOP SUM_LOOP2       ; 循环
    
    RET
SUM_IN_DATA_SEGMENT ENDP

; 方法3：结果放在栈中
SUM_IN_STACK PROC
    PUSH BP              ; 保存基址指针
    MOV BP, SP
    SUB SP, 2            ; 在栈中分配2字节空间
    
    MOV WORD PTR [BP-2], 0  ; 初始化栈中结果为0
    MOV CX, 100          ; 循环100次
    MOV BX, 1            ; 从1开始
    
SUM_LOOP3:
    ADD [BP-2], BX       ; 加到栈中的变量
    INC BX               ; BX加1
    LOOP SUM_LOOP3       ; 循环
    
    MOV AX, [BP-2]       ; 将结果从栈中移到AX
    MOV RESULT, AX       ; 保存到数据段
    
    ADD SP, 2            ; 恢复栈指针
    POP BP               ; 恢复基址指针
    RET
SUM_IN_STACK ENDP

; 显示结果（从数据段）
DISPLAY_RESULT PROC
    ; 显示提示信息
    MOV AH, 09H
    LEA DX, RESULT_MSG
    INT 21H
    
    ; 将数字转换为字符串并显示
    MOV AX, RESULT
    CALL DISPLAY_NUMBER
    
    ; 换行
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    
    RET
DISPLAY_RESULT ENDP

; 显示结果（从栈中，演示用）
DISPLAY_RESULT_FROM_STACK PROC
    ; 显示提示信息
    MOV AH, 09H
    LEA DX, RESULT_MSG
    INT 21H
    
    ; 直接从寄存器显示（之前已保存）
    MOV AX, RESULT
    CALL DISPLAY_NUMBER
    
    ; 换行
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    
    RET
DISPLAY_RESULT_FROM_STACK ENDP

; 将AX中的数字以十进制显示
DISPLAY_NUMBER PROC
    MOV CX, 0            ; 计数器清零
    MOV BX, 10           ; 除数为10
    
CONVERT_LOOP:
    XOR DX, DX           ; 清空DX
    DIV BX               ; AX ÷ 10, 商在AX, 余数在DX
    PUSH DX              ; 保存余数（数字位）
    INC CX               ; 位数加1
    TEST AX, AX          ; 检查商是否为0
    JNZ CONVERT_LOOP     ; 不为0则继续
    
DISPLAY_LOOP:
    POP DX               ; 取出数字位
    ADD DL, '0'          ; 转换为ASCII字符
    MOV AH, 02H          ; 显示字符功能
    INT 21H
    LOOP DISPLAY_LOOP    ; 循环显示所有位
    
    RET
DISPLAY_NUMBER ENDP

CODE ENDS
END START