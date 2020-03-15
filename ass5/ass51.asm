;=======================
section .data
;=======================
        frame: db 'abc.txt',0
	msg: db "file opened",0x0A
	len: equ $-msg
	
	msg1: db "error",0x0A
	len1: equ $-msg1

	msg2: db "this is the number of enter",0x0A
        len2: equ $-msg2

msg3: db" ",0x0A
len3: equ $-msg3

extern cnt1
extern cnt2
extern cnt3

cnt: db 00
;======================
section .bss
;======================
global ans,scount,ecount,buffer,fd,buf_len,chrr

ans: resb 04
scount: resb 02
chrr: resb 02
ecount: resb 02
buffer: resb 200
fd: resq 3
buf_len: resb 3 
	

%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro write 2
	mov rax,0
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

;=================
section .text
;=================

extern space
extern enters
extern hta
extern char
global _start
_start:




	mov rax,2
	mov rdi,frame
	mov rsi,2
	mov rdx,0777
	syscall

	mov qword[fd],rax
        BT rax,63
        
	jc next
	print msg,len
	jmp next2
	
next :
	print msg1,len1

next2 :
	mov rax,0
	mov rdi,[fd]
	mov rsi,buffer
	mov rdx,200
	syscall

	mov qword[buf_len],rax
	mov qword[cnt1],rax	
        mov qword[cnt3],rax	
       
       
	mov rax,1
	mov rdi,1
	mov rsi,buffer
	mov rdx,200
	syscall
	print msg3,len3
	print msg3,len3
	
call enters
call hta
	print msg3,len3
	print msg3,len3

call space
call hta
	print msg3,len3
	print msg3,len3
	
call char
call hta
   
    
    mov rax,60
	mov rdi,0
	syscall
	
	
