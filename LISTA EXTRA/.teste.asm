somar PROC
    xor ah, ah
    mov al, soma
    mov cx, 10
    xor dx, dx
    divi:
    inc contador
    cmp cx, ax
    JBE FIM
    div cx
    push dx
    test ax, ax
    JNZ divi

    fim:
    push ax
    escreverr:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21H
    dec contador
    JNZ escreverr
somar ENDP