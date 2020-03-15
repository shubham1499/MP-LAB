;-------------------------macro for printing and reading data----------------------

	%macro print 2
	mov rax,1
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	%macro read 2
	mov rax,0
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	
;------------------------------------------------------------------------------------

section .data
file db "num.txt",0
file2 db "num1.txt",0
msg db "Works",10
len equ $-msg


section .bss
fin resq 8
fin2 resq 8
cnt resb 2
ocnt resb 2
icnt resb 2
num resb 8

var resb 10

section .text

global _start
 _start:
 
 	mov rax,2
 	mov rdi,file
 	mov rsi,2
	mov rdx,777
	syscall
	
	mov qword[fin],rax
	
	
	mov rax,0
	mov rdi,[fin]
	mov rsi,var
	mov rdx,10
	syscall
	
	print msg,len
	print var,100
	
	mov rsi,var
	mov rdi,var
	inc rdi
	mov byte[cnt],08h
	mov byte[ocnt],08h
	mov al,byte[ocnt]
	mov byte[icnt],al
;----ocnt is kept so tht we knw how much times internal loop is to be run-----	
	
Bubbletest:
	;mov al,byte[rdi]
	;cmp byte[rsi],al
	;je l2
	;jmp exit
	;l2:
	;  print msg,len
	
bubble:

;---loop1 is outer loop and extloop is external-------

loop1:
	mov al,byte[rsi]
	cmp byte[rdi],al
	jb exchange
	
;----------exchange :- exchanges the number tht is smaller------------
ex1:
	inc rdi	
	dec byte[icnt]
	jnz loop1
	
extloop:
	inc rsi
	mov rdi,rsi
	inc rdi	
	dec byte[ocnt]
	jmp exloopcnt
ex2:
	dec byte[cnt]
	jnz loop1
	
	print var,100
		
;-----------------writing to newfile---------
write:
	mov rax,2
 	mov rdi,file2
 	mov rsi,2
	mov rdx,777
	syscall
	
	mov qword[fin2],rax




	mov rax, 01 ; 
	mov rdi, [fin2] 
	mov rsi, var 
	mov rdx, 10
	Syscall

	
	
exit:
 
	mov rax,3
	mov rdi,[fin]
	syscall
	
	mov rax,3
	mov rdi,[fin2]
	syscall
	
	
	
	mov rax,60
	mov rdi,0h
	syscall

;---exchange numbers--------	
exchange:
	mov bl,byte[rdi]
	mov byte[rsi],bl
	mov byte[rdi],al
	mov al,byte[rsi]
	jmp ex1	
;----put the loop cnt after completion of internal loop----------	
exloopcnt:
	mov al,byte[ocnt]
	mov byte[icnt],al
	jmp ex2
	
 
 	
 
 
 
 
 
 
 

