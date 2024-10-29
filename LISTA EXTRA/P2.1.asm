.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 10, 13, 'Digite um caracter: $'
    msg2 db 10, 13, 'A quantidade de bits 1 no ASCII eh: $'
    resultado db '0', 0      
    numBits db 0            

.CODE
main PROC
 ; Inicializa o segmento de dados
 mov ax, @DATA
 mov ds, ax

 ; Exibe a mensagem para digitar o caracter
 mov ah, 9
 mov dx, offset msg1
 int 21h

 ; Lê um caractere do teclado
 mov ah, 1
 int 21h  
 
 xor cx, cx

testarlsb:
test al, 1
JZ novobit
inc cx

novobit:
shr al, 1
test al, al
jnz testarlsb

fim:
mov ah, 9
mov dx, offset msg2
int 21h
add cl, '0'
mov dl, cl
mov ah, 2
int 21h

mov ah, 4Ch
main endp
end main



