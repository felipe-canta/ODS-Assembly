Title Ativ5.2
.Model SMALL
.DATA
msg1 db 10, 13, '*$'
.CODE
 main proc
 mov ax, @DATA
 mov ds, ax

 mov cx, 50

 loop_asterisco:
 mov ah, 9 
 lea dx, msg1
 int 21h
 loop loop_asterisco
 JMP Fim

fim:
 mov ax, 4Ch
 main endp 
 end main
