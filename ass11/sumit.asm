section .data
msgFact: db 'Factorial is:',0xa
msgFactSize: equ $-msgFact
newLine: db 10
section .bss
fact: resb 8
num: resb 2

section .txt
global _start
_start:
 pop rbx ;Remove number of arguments 
 pop rbx ;Remove the program name
 
 pop rbx ;Remove the actual number whoes factorial is to be calculated (Address of number)
 
 mov [num],rbx

 ;print number accepted from command line
 
 mov rax,1
 mov rdi,1
 mov rsi,[num]  
 mov rdx,2
 syscall
 
 
 mov rsi,[num]
 mov rcx,02
 xor rbx,rbx
 call aToH
 
 mov rax,rbx
 
 call factP

 
 mov rcx,08
 mov rdi,fact
 xor bx,bx
 mov ebx,eax
 call hToA

 mov rax,1
 mov rdi,1
 mov rsi,newLine
 mov rdx,1
 syscall

 mov rax,1
 mov rdi,1
 mov rsi,fact
 mov rdx,8
 syscall
 
 mov rax,1
 mov rdi,1
 mov rsi,newLine
 mov rdx,1
 syscall

 mov rax,60
 mov rdi,0
 syscall

factP:
 dec rbx
 cmp rbx,01
 je comeOut
 cmp rbx,00
 je comeOut
 mul rbx
 call factP
comeOut:
 ret
aToH:
up1: rol bx,04
 mov al,[rsi]
 cmp al,39H
 jbe A2
 sub al,07H
A2: sub al,30H
 add bl,al
 inc rsi
 loop up1
ret


hToA:   
    d:  rol ebx,4
 mov ax,bx
 and ax,0fH 
 cmp ax,09H 
 jbe ii 
 add ax,07H
 
 ii: add ax,30H
 mov [rdi],ax
 inc rdi
 loop d

 ret
 
 
 
 
 ;*******output*******
 
;nasm -f elf64 ass9_rec.asm
; ld -o ass9_rec ass9_rec.o
;./ass9_rec 02
;02
;00000002

