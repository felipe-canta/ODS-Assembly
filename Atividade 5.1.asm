Title Ativ5
.Model SMALL
.DATA
msg1 db 10, 13, '*$'
.CODE
 main proc
 mov ax, @DATA
 mov ds, ax

mov cx, 50

 asterisco:
 mov ah, 9 
 lea dx, msg1
 int 21h

 dec cx
 jnz asterisco
 JMP Fim

fim:
 mov ax, 4Ch
 main endp 
 end main
