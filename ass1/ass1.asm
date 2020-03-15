section .data
	msg1 db "positive no's is"
	len1 equ $-msg1
	msg2 db 10,"Negative no's is"
	len2 equ $-msg2
	
	pc db 00h
	nc db 00h
	cnt db 0xA	
	
	array dq 0xA123456789123456,1231231231231231h,0xABCDABCDABCDABCD,151526264949ABABh,1234123412341234h,0xA123456789123456,1231231231231231h,0xABCDABCDABCDABCD,151526264949ABABh,1234123412341234h
	
section .text
	global _start
	_start:	
	mov rbx,array
	up:mov rax,qword[rbx]
	BT rax,63
	JC L1
	inc byte[pc]
	jmp L2
	
	L1:inc byte[nc]
	L2:ADD rbx,8h
	dec byte[cnt]
	jnz up
	
	ADD byte[pc],30h
	ADD byte[nc],30h
	

	mov rax,1            
	mov rdi,1           
	mov rsi,msg1  
	mov rdx,len1
	syscall
	
	mov rax,1            
	mov rdi,1           
	mov rsi,pc  
	mov rdx,1
	syscall
	

	mov rax,1            
	mov rdi,1           
	mov rsi,msg2  
	mov rdx,len2
	syscall
	
	mov rax,1            
	mov rdi,1           
	mov rsi,nc  
	mov rdx,1
	syscall
	
	mov rax,60            
	mov rdi,0            
	syscall             

	

