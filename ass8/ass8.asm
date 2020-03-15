%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro
;============
section  .data
;============
msg: db "File opened successfully",0x0A
len: equ $-msg

msg2: db "Error in opening file",0x0A
len2: equ $-msg2

bufferfortypecommand : times 100 db ' '
;===============
section  .bss
;===============
fname: resb 100
fname1: resb 120
fname2: resb 120
fd: resb 100
buffer: resb 100
fd1:resb 100
fd2:resb 100
;===============
section  .text
;===============
global _start
_start:

pop rbx ;pop no. of arguments
pop rbx ;pop ./ass8
pop rbx ;pop command name

cmp byte[rbx],116 ;'t' type command
je c1
cmp byte[rbx],99  ;'c' copy command
je c2
cmp byte[rbx],100 ;'d' delete command
je c3

exit:
mov rax,60
mov rdi,0
syscall

c1:
	 scall 1,1,msg,len
	 pop rbx
	 call tc
	 mov rax,3
	 mov rdi,[fd]
	 syscall
	 jmp exit 
 
 
c2:
	 pop rbx
	 call cc
	 pop rbx
	 call x
	 ;read from file1
	 scall 0,[fd],buffer,20
	 ;write to file2
	 scall 1,[fd1],buffer,20
	
	 ;close file1	 
         mov rax,3
	 mov rdi,[fd]
	 syscall
	 ;close file2
	 mov rax,3
	 mov rdi,[fd1]
	 syscall
	 jmp exit 
 
c3:
	 pop rbx
	 call dc
	 mov rax,3
	 mov rdi,[fd2]
	 syscall
	 jmp exit 
;=======================
;====TYPE PROCEDURES====
;=======================
tc:

mov rsi,fname
up:
	mov dl,byte[rbx]
	mov byte[rsi],dl
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jne up

mov rax,2
mov rdi,fname
mov rsi,2
mov rdx,0777
syscall

mov qword[fd],rax
BT rax,63
jc next2
scall 1,1,msg,len
jmp next1

next2:
	scall 1,1,msg2,len2
	ret
next1:
	scall 0,0,bufferfortypecommand,100
	scall 1,[fd],bufferfortypecommand,100
ret
;=========================
;=====COPY PROCEDURES=====
;=========================

;==for file1==
cc:
	mov rsi,fname
up2:
	mov dl,byte[rbx]
	mov byte[rsi],dl
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jne up2

mov rax,2
mov rdi,fname
mov rsi,2
mov rdx,0777
syscall

mov qword[fd],rax
BT rax,63
jc next4
scall 1,1,msg,len
jmp next5
next4:
	scall 1,1,msg2,len2
next5:
ret

;==for file2==
x:
	mov rsi,fname1
up3:
	mov dl,byte[rbx]
	mov byte[rsi],dl
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jne up3

mov rax,2
mov rdi,fname1
mov rsi,2
mov rdx,0777
syscall

mov qword[fd1],rax
BT rax,63
jc next7
scall 1,1,msg,len
jmp next6

next7:
	scall 1,1,msg2,len2
next6:
	ret


;=======================
;===Delete Procedures===
;=======================
dc:
	mov rsi,fname2
up4:
	mov dl,byte[rbx]
	mov byte[rsi],dl
	inc rsi
	inc rbx
	cmp byte[rbx],0
	jne up4

;==open fname2==
mov rax,2
mov rdi,fname2
mov rsi,2
mov rdx,0777
syscall

mov qword[fd2],rax

BT rax,63
jc next9
scall 1,1,msg,len
jmp next10

next9:
	scall 1,1,msg2,len2
;==delete proc==
next10: 
	mov rax,87
	mov rdi,fname2
	syscall
	ret
