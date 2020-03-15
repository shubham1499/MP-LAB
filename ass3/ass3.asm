%macro print 4
        mov rax,%1
        mov rdi,%2
        mov rsi,%3
        mov rdx,%4
        syscall
%endmacro
;********************************************************************************************
section .data
	new db 0xA
	menu     db "        MENU             ",10
              db " 1]. HEX to BCD ",10
              db " 2]. BCD to HEX ",10
              db " 3]. Exit Code",10
              db "Enter your choice",10
    	len   equ  $-menu
    	msg1 db "Enter 4 HEX NUM ",10
	len1 equ $-msg1
	msg3 db "Enter 5 digit BCD NUM ",10
	len3 equ $-msg3
	msg2 db "BCD Number is",10
	len2 equ $-msg2
	msg4 db "HEX Number is",10
	len4 equ $-msg4
	cnt db 00h
	cnt1 db 00h
;********************************************************************************************
section .bss
    num resb 10h
    read resb 10h
    ans1 resb 4
;********************************************************************************************
section .text
    global _start
    _start:  
menu1: 
print 1,1,menu,len
print 0,0,read,2   

;*********MENU DRIVEN*******************************
cmp byte[read],31h
je a
cmp byte[read],32h
je b
cmp byte[read],33h
je c
;**********A**HEX TO BCD******************************
a:
	print 1,1,msg1,len1
	print 0,0,num,5

;Conversion of ascii to hex
	mov rcx,04
	mov rsi,num
	xor ax,ax
up:	rol ax,04  ;In case of ass11 u should use al because it gives right answer but here use ax as al gives wrong answer	
	mov dl,byte[rsi]
	cmp dl,39h
	jbe l1
	sub dl,7h
l1:	sub dl,30h
	xor dh,dh	;------------This step is important else garbage value pops
	add ax,dx
	inc rsi
	loop up

	mov rbx,0xA
l2:	xor rdx,rdx ;-----------important else you will get floating exception
	div rbx
	push rdx
	inc byte[cnt1]
	cmp rax,0h
	jnz l2
print 1,1,msg2,len2

l3:	pop rdx
	xor dh,dh ;------------This step is important else garbage value pops
	mov byte[num],dl
	add byte[num],30h
	print 1,1,num,1
	dec byte[cnt1]
	jnz l3


print 1,1,new,1
	mov rax,60          
	mov rdi,00         
	syscall  
;********************************************************************************************
;**********B**BCD TO HEX******************************
b:
	print 1,1,msg3,len3
	print 0,0,num,6

	
	mov    rsi,num ;num to be converted into hex 
	xor    rax,rax ;make Q 0
	mov    rbx,10  ;for multiplying by 10    
	mov    rcx,05  ;five digit BCD 
back1:  mul    rbx     ;rax*rbx=rdx multiplier rax multiplicand
   	xor    rdx,rdx ;make multiplier 0
   	mov    dl,[rsi];put value from rsi in dl
   	sub    dl,30h  ;subtract 30    
   	add    rax,rdx ;	
 	inc    rsi     ;(goto next digit)
	dec    rcx     ;decrement rcx by 1 (count is 5 )
        jnz    back1   ;repeat mul ins
;*****************************DISPLAY********************* 	

    	mov     rsi,ans1+3  
    	mov     rcx,4    ;Hex display so 4  
cntx:    mov     rdx,0      
        mov     rbx,16      
        div     rbx
        cmp     dl, 09h      
        jbe      add30
        add      dl, 07h
    add30:
        add     dl,30h      
        mov     [rsi],dl  
        dec     rsi 
        dec     rcx      
        jnz     cntx  
        print 1,1,msg4,len4    
    print 1,1,ans1,4  
    	
    	mov rax,60          
	mov rdi,00         
	syscall   
;********************************************************************************************
;*****************************EXIT********************* 	
c:
	mov rax,60          
	mov rdi,00         
	syscall   


