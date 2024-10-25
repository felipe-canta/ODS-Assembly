Title Ativ5.2
.Model SMALL
.stack 100h
.DATA
.CODE
 main proc

mov cx, 25

mov dl, 'A'

 imprimir:
mov ah,2
int 21h
inc dl
loop imprimir

mov dl, 'a'
mov cx, 25

maiusculo:
mov ah,2 
int 21h
inc dl
loop maiusculo

mov ah, 4Ch
int 21h
main endp 
end main