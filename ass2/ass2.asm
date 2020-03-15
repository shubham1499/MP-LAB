section .data
	array: dq 0x0123456789012345, 0x1234567890123456, 0x2345678901234567, 0x3456789012345678, 0x4567890123456789, 0x00, 0x00


	menu: 	db 10, "1. Show original block", 10
		db "2. Display using non-overlapping method", 10
		db "3. Display using overlapping method", 10
		db "4. Display using non-overlapping method with string",10
		db "5. Display using overlapping method with string",10
		db "6. Exit", 10
		db "Enter your choice", 10
	lmenu: equ $-menu
	
	count: db 1
	col: db ": "
	newline: db "", 10

section .bss
	choice: ResB 2
	asc: ResB 16

section .text
	global _start
	_start:

show:	mov rax, 1
	mov rdi, 1
	mov rsi, menu
	mov rdx, lmenu
	syscall

	mov rax, 0
	mov rdi, 2
	mov rsi, choice
	mov rdx, 2
	syscall

	CMP byte[choice], 31H
	je origin
	CMP byte[choice], 32H
	je nonov
	CMP byte[choice], 33H
	je ov
	CMP byte[choice], 34H
	je strnon
	CMP byte[choice], 35H
	je strov
	CMP byte[choice], 36H
	je exit

origin:	mov byte[count], 05H 
	mov rsi, array

o:	mov rdx, rsi
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, col
	mov rdx, 2
	syscall	

	pop rsi
	mov rdx, qword[rsi]
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall
	pop rsi
	add rsi,08
	dec byte[count]
	jnz o

	jmp show

nonov:	mov byte[count], 05H
	mov rsi, array
	mov rdi, array+999H

n1:	mov rax, qword[rsi]
	mov qword[rdi], rax

	add rsi, 8
	add rdi, 8
	dec byte[count]
	jnz n1

	mov byte[count], 05H
	mov rsi, array+999H

n2:	mov rdx, rsi
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, col
	mov rdx, 2
	syscall

	pop rsi
	mov rdx, qword[rsi]
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall

	pop rsi
	add rsi, 8
	dec byte[count]
	jnz n2

	jmp show

ov:	;copying 100 locations away
	mov byte[count], 05H
	mov rsi, array
	mov rdi, array+600H

c:	mov rax, qword[rsi]
	mov qword[rdi], rax
	add rsi, 8
	add rdi, 8
	dec byte[count]
	jnz c

	;overlapping
	mov byte[count], 05H
	mov rsi, array+600H
	mov rdi, array+16

ov1:	mov rax, qword[rsi]
	mov qword[rdi], rax

	add rsi, 8
	add rdi, 8
	dec byte[count]
	jnz ov1

	;printing
	mov byte[count], 07H
	mov rsi, array

ov2:	mov rdx, rsi
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, col
	mov rdx, 2
	syscall

	pop rsi
	mov rdx, qword[rsi]
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall

	pop rsi
	add rsi, 8
	dec byte[count]
	jnz ov2

	jmp show

strnon:	;copying using string
	mov rsi, array
	mov rdi, array+999H
	mov rcx, 05H
	rep movsq

	;printing
	mov byte[count], 05H
	mov rsi, array+999H

sn1:	mov rdx, rsi
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, col
	mov rdx, 2
	syscall

	pop rsi
	mov rdx, qword[rsi]
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall

	pop rsi
	add rsi, 8
	dec byte[count]
	jnz sn1
	jmp show

strov:	;copying using string to temporary location
	mov rsi, array
	mov rdi, array+500H
	mov rcx, 05H
	rep movsq

	;copying using string to overlapped location
	mov rsi, array+500H
	mov rdi, array+16
	mov rcx, 05H
	rep movsq

	;printing
	mov byte[count], 07H
	mov rsi, array

so1:	mov rdx, rsi
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, col
	mov rdx, 2
	syscall

	pop rsi
	mov rdx, qword[rsi]
	push rsi
	call htoaw

	mov rax, 1
	mov rdi, 1
	mov rsi, newline
	mov rdx, 1
	syscall

	pop rsi
	add rsi, 8
	dec byte[count]
	jnz so1

	jmp show

exit:	MOV RAX, 60
	MOV RDI, 0
	syscall

htoaw:	MOV RCX, 16
	MOV Rdi, asc

L1:	rol RDX, 04H
	MOV al, dl
	AND al, 0FH
	CMP al, 09H
	JBe L2
	ADD al, 07H

L2: 	ADD al, 30H
	MOV byte[Rdi], al
	inc Rdi
	LOOP L1

	mov rax, 1
	mov rdi, 1
	mov rsi, asc
	mov rdx, 16
	syscall
	ret







