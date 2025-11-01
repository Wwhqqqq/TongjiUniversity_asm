data segment
    msg db 'The 9mu19 table:', 0dh, 0ah, '$'
    buffer db 20 dup('$')
data ends

code segment
    assume cs:code, ds:data

main proc far
    mov ax, data
    mov ds, ax
    
  
    mov dx, offset msg
    mov ah, 09h
    int 21h
    
  
    mov cx, 9
outer_loop:
    push cx      
    

    call print_multiplication_row
    
   
    mov dl, 0dh
    mov ah, 02h
    int 21h
    mov dl, 0ah
    mov ah, 02h
    int 21h
    
    pop cx        
    loop outer_loop
    
   
    mov ah, 4ch
    int 21h
main endp


print_multiplication_row proc near
    push ax      
    push bx
    push cx
    push dx
    push si
    
    mov bx, cx    
    mov cx, 1      
    
inner_loop:
    ; 计算乘积
    mov ax, bx    
    mul cx         
    push ax       
    
    mov dl, bl
    add dl, '0'
    mov ah, 02h
    int 21h

    mov dl, 'x'
    int 21h

    mov dl, cl
    add dl, '0'
    int 21h

    mov dl, '='
    int 21h
  
    pop ax       

    call number_to_string

    mov dl, ' '
    mov ah, 02h
    int 21h
    int 21h
    int 21h
    int 21h
    
    inc cx        
    cmp cx, bx    
    jle inner_loop
    
    pop si     
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_multiplication_row endp

number_to_string proc near
    push ax
    push bx
    push cx
    push dx
    push si
    
    mov si, offset buffer
    mov cx, 0

    cmp ax, 10
    jb single_digit

    mov bl, 10
    div bl        

    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h

    mov dl, ah
    add dl, '0'
    int 21h
    jmp done_output
    
single_digit:
    ; 一位数处理
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    mov dl, ' '    
    int 21h
    
done_output:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
number_to_string endp

code ends
end main