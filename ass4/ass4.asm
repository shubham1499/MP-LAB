%macro print 4
        mov rax,%1
        mov rdi,%2
        mov rsi,%3
        mov rdx,%4
        syscall
%endmacro
;********************************************************************************************
section .data
	menu     db "        MENU           ",10
              db " 1]. Successive Addition: ",10
              db " 2]. Add and Shift Method ",10
              db " 3]. Exit \nEnter your choice",10
	len   equ  $-menu
	msg1 db "Enter HEX NUM ",10
	len1 equ $-msg1
	msg2 db "Enter Another HEX NUM ",10
	len2 equ $-msg2
	msg3 db "Result",10
	len3 equ $-msg3
	    	cnt db 00h 
		
;********************************************************************************************
section .bss
      num  resb 03
      num1 resb 01
      result resb 04
      read resb 2

;********************************************************************************************
section .text
    global _start
    _start: 
    menu1: 
mov rax,0
mov rbx,0
mov rcx,0
mov rdx,0
mov byte[num],0
mov byte[num1],0
mov byte[result],0

print 1,1,menu,len
print 0,0,read,2   
;*********MENU DRIVEN*******************************
cmp byte[read],31h
je a

cmp byte[read],32h
jmp b

cmp byte[read],33h
je d
;**********A** Successive Addition******************************

a: 
	print 1,1,msg1,len1
	print 0,0,num,3 
	call ah1
	mov [num1],bl
	print 1,1,msg2,len2
	print 0,0,num,3
	call ah1
	mov rcx,0
	mov rax,0
	mov rax,[num1]
repeat:
	add rcx,rax
	dec bl
	jnz repeat

	mov [result],rcx
	print 1,1,msg3,len3
	mov rbx,[result]
	call xyz

jmp c
;**********B** ADD AND SHIFT******************************
b:

print 1,1,msg1,len1
print 0,0,num,3

call ah1
mov [num1],bl

print 1,1,msg2,len2
print 0,0,num,3

call ah1
mov [num],bl

mov rbx,0
mov rcx,0
mov rdx,0
mov rax,0
mov dl,08
mov al,[num1]
mov bl,[num]

up3:
	shr bx,01
	jnc label1
	add cx,ax
label1:
	shl ax,01
	dec dl
	jnz up3

mov [result],rcx
print 1,1,msg3,len3

mov rbx,[result]
call xyz

jmp c 




;*****************************EXIT********************* 	
c:
	jmp menu1 
d:
	mov rax,60
	mov rdi,0
	syscall
	
xyz:
	mov rcx,4
	mov rdi,result
up2:
	rol bx,4
	mov al,bl
	and al,0fh
	cmp al,09h
	jg skip1
	add al,30h
	jmp label
skip1:
	add al,37h
label:
	mov [rdi],al
	inc rdi
	loop up2
	print 1,1,result,4
	ret





ah1:
	mov rcx,02
	mov rbx,0
	mov rax,0
	mov rsi,num
up:
	rol bl,4
	mov al,[rsi]
	cmp al,39h
	jbe skip
	sub al,7h
skip:
	sub al,30h
	add al,bl
	mov bl,al
	inc rsi
	loop up
	ret
