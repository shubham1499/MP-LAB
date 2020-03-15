
msgg db "GDTR IS",0x0A
leng :equ $-msgg
msgl db "LDTR is",0x0A
lenl :equ $-msgl
msgi db "IDTR is",0x0A
leni :equ $-msgi

msg db "",0x0A
len :equ $-msg

section .bss
g resw 1
  resd 1
l resw 1
i resw 1
  resd 1
result :resb 8
cnt :resb 4

%macro print 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .text
global _start
_start:
sgdt [g]
sldt [l]
sidt [i]

;****************GDT CONTENT**********************

print 1,1,msgg,leng
mov bx,word[g+4]
call convertHtoA
print 1,1,result,4
mov bx,word[g+2]
call convertHtoA
print 1,1,result,4
mov bx,word[g]
call convertHtoA
print 1,1,result,4
print 1,1,msg,len

;****************LDT CONTENT**********************

print 1,1,msgl,lenl
mov bx,word[l] 
call convertHtoA
print 1,1,result,4
print 1,1,msg,len

;****************IDT CONTENT**********************

print 1,1,msgi,leni
mov bx,word[i+4]
call convertHtoA
print 1,1,result,4
mov bx,word[i+2]
call convertHtoA
print 1,1,result,4
mov bx,word[i]   ;---------- changed this from g to i
call convertHtoA
print 1,1,result,4
print 1,1,msg,len

;****************EXIT**********************

mov rax,60
mov rdi,0
syscall

;****************CONVERT HEX TO ASCII**********************

convertHtoA:
	mov rsi,result
	mov byte[cnt],04H		
ab:	rol bx,04H
	mov dl,bl
	AND dl,0FH
	cmp dl,09H
	jbe next1
	add dl,07H
next1:	add dl,30H
	mov byte[rsi],dl
	inc rsi
	dec byte[cnt]
	jnz ab
	ret

