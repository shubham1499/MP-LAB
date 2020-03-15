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
;===================
section .data
;===================

;===================
section .bss
;===================
num resb 2
num1 resb 2
factorial resb 4
cnth resb 2
var resq 4
;====================
section .text
;====================
 global _start
    _start:

        ;mov byte[num1],1h
        ;inc byte[num1]
        pop rbx
        pop rbx
        pop rbx

        ;inc byte[num1]

        mov rsi,num

        x1:
            mov al,byte[rbx]
            mov byte[rsi],al
            inc rbx
            inc rsi
            cmp byte[rsi],0
            je x2
            jmp x1
        x2:
            mov rsi,num
            mov byte[cnth],1
            call atoh
            mov [num1],bl
            mov al,[num1]
            mov bl,01h
            call factr
            ;mov byte[factorial],al
            call hta
            ;add byte[factorial],30h
            print factorial,4
        
            
        

        exit:
            mov rax,60
            mov rsi,0h
            syscall    



;----------------hex to ascii----------------
	
	hta:
	mov rdi,factorial
	mov byte[cnth],8h
	
	l2:
	rol ax,4
	mov bl,al
	and bl,0Fh
	cmp bl,9h
	jbe l3
	add bl,7h
	
	l3:
	add bl,30h
	mov byte[rdi],bl

	inc rdi
	dec byte[cnth]
	jnz l2
	
	ret
	
	;----------------ascii to hex-------------------

	atoh:
	
	xor ax,ax
	xor bx,bx
	
	hex:
	mov al,byte[rsi]
	rol bx,4h
	sub al,30h
	cmp al,9h
	jbe next
	
	sub al,7h
	
	next:
	add bx,ax
	inc rsi
	dec byte[cnth]
	jnz hex

	ret
;---------------------FACTORIAL--------------------

   		factr:				;recursive procedure
			cmp rax,01h
			je retcon1

			push rax			
			dec rax
			
			call factr

		retcon:
            
			pop rbx
            		mul rbx
			jmp endpr

		retcon1:			;if rax=1 return
			pop rbx
			jmp retcon		
		endpr:
	ret
