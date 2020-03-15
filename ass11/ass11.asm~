%macro print 2
	mov rax,01
	mov rdi,01
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
section .data

	msgm db "The mean of Numbers is",0x0a
	lenm equ $-msgm
	
	msgv db "The variance of Numbers is",0x0a
	lenv equ $-msgv
	
	dot db "."
	lend equ $-dot

	new db "",0x0A
	
	msgs db "The Standard Deviation of Numbers is",0x0a
	lens equ $-msgs

	array dd 10.00,20.00,30.00,40.00,50.00
	cnt dw 05
	hun dw 100
	counter db 00H

	

section .bss

	mean resb 10
	variance resb 10
	sd resb 10
	resbuff resb 10
	result resb 16
	count resb 1


section .text
global _start
_start:

FINIT

	mov rsi,array
	mov byte[counter],5
	
	FLDZ
up:
	FADD dword[rsi]
	add rsi,4
	dec byte[counter]
	jnz up
	
	FIDIV word[cnt]
	FST dword[mean]
	
	print msgm,lenm   ;##MEAN##

	call printp

	
	mov rsi,array
	mov byte[counter],5
	FLDZ				
up3:
	
	
	FLD dword[rsi]		
	FSUB dword[mean]
	FMUL ST0			
		
	FADD  				
	
	FST ST1				
	
	ADD rsi,4
	dec byte[counter]
	jnz up3
	
	FIDIV word[cnt]
	
	FST dword[variance]

	print new,1
	print msgv,lenv   
	
	call printp

	FLDZ
	FLD dword[variance]
	FSQRT 
	FST dword[sd]
	
	print new,1
	print msgs,lens
	

	call printp
	
	mov rax,60
	mov rdi,0
	syscall	


exit:

	mov rax,60
	mov rdi,00
	syscall

;##Print Function##
printp:

	FIMUL word[hun]
	FBSTP [resbuff]
	mov rsi,resbuff+9
	mov byte[counter],9
up2:

	mov bl,byte[rsi]
	push rsi
	;push cx
	
	call HTA
	print result,2
	;pop cx	
	pop rsi
	dec rsi
	dec byte[counter]
	jnz up2
	
	print dot,lend
	
	mov bl,byte[resbuff]
	call HTA
	print result,2

	ret

HTA:
	mov rsi,result
	mov byte[count],2
above:
	rol bl,04
	mov dl,bl
	AND dl,0FH
	cmp dl,09
	jbe next2
	
	add dl,07H
	
next2:  add dl,30H
	mov byte[rsi],dl
	
	inc rsi
	dec byte[count]                                 
	jnz above
	
	ret			
