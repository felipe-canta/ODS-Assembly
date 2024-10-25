title ativ1
.model SMALL
.DATA
msg1 db 10, 13, "Digite um caracter minusculo:$"
msg2 db 10, 13, "Caracter em maiusculo:$"
.CODE
main proc

;chama @data p o main
 mov ax, @DATA
 mov ds, ax

;exibe a msg1 na tela
 mov ah, 9
 lea dx, msg1
 int 21h

;le um caracter do teclado
 mov ah, 1
 int 21h
 
 ;transforma em maiusculo
 sub al, 32

; move para bl
 mov bl, al

;exibe a msg2 na tela
 mov ah, 9
 lea dx, msg2
 int 21h

;exibe o caracter lido e maiusculo
 mov ah,2
 mov dl, bl
 int 21h

;termina o progreama
main endp 
end main


 