section .data

msg1: db "this is the number of space",0x0A
len1: equ $-msg1

msg2: db "this is the number of enter",0x0A
len2: equ $-msg2

msg4: db "enter the character",0x0A
len4: equ $-msg4

msg3: db" ",0x0A
len3: equ $-msg3


global cnt1,cnt3,cnt2
chh: db 00
cnt2: db 00
cnt1: db 00
cnt3: db 00
cnt4: db 00
;=================
section .bss
;=================
extern   ans
extern   scount
extern   ecount
extern 	 buffer
extern   fd 
extern   buf_len
extern   chrr


%macro print 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro


section .text


global space,enters,hta,char,chr



;======================




 enters:

print 1,1,msg2,len2
  

xor rax,rax
xor rbx,rbx
xor rcx,rcx
xor rdx,rdx
    mov rsi,buffer
up3:  
	mov al,byte[rsi]
    cmp al,0x0A
    je next33

inc rsi
dec byte[cnt3]
jnz up3 
jmp next44

next33:
 inc byte[ecount]
inc rsi
dec byte[cnt3]
jnz up3

next44:
	mov bx,word[ecount]
	mov cx,word[ecount]	
ret


;======================
space:


  print 1,1,msg1,len1

xor rax,rax
xor rbx,rbx
xor rcx,rcx
xor rdx,rdx
    mov rsi,buffer
up:  
    mov al,byte[rsi]
   cmp al,20H
   je next3

inc rsi
dec byte[cnt1]
jnz up 
jmp next4

next3:
 inc byte[scount]
inc rsi
dec byte[cnt1]
jnz up

	next4:
	mov bx,word[scount]
	mov cx,word[scount]	


ret


;======================



 char:

print 1,1, msg4,len4
  print 0,0,chh,2

xor rax,rax
xor rbx,rbx
xor rcx,rcx
xor rdx,rdx
    mov rsi,buffer
up33:  
    mov al,byte[rsi]
   cmp al,byte[chh]
   je next333

inc rsi
dec byte[cnt4]
jnz up33 
jmp next444

next333:
 inc byte[chrr]
inc rsi
dec byte[cnt4]
jnz up33

next444:
mov bx,word[chrr]
mov cx,word[chrr]	
ret

hta:


mov rdi,ans
mov byte[cnt2],00H
mov byte[cnt2],04H
above:
	rol cx,04
	mov dl,cl
	AND dl,0FH	
	cmp dl,09
	jbe next5
	add dl,07
next5:
	add dl,30H
	mov byte[rdi],dl
	inc rdi
	dec byte[cnt2]
	jnz above
	print 1,1,ans,4       
ret





