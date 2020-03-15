%macro print 4
%endmacro
extern printf
extern scanf
;==============
section .data
;==============

format : db "First root-: %lf     Second root-: %lf ",10,0
fin : db "%lf",0 ;--------------------------------------------imp this is only 0
format_img1: db "First root-: %lf +%lfi ",10,0 ;---------------IMP it is 10,0
format_img2: db "Second root1-: %lf %lfi",10,0
flag : db 00H
;=============
section .bss
;=============
a: resq 1
b: resq 1
c: resq 1
temp : resq 1
delta : resq 1
temp2 : resq 1
temp3 : resq 1
root1 :resq 1
root2 :resq 1
;================
section .text
;================
global main
main:

;========================accepting values================================
mov rdi,fin
mov rax,0
sub rsp,8
mov rsi,rsp
call scanf
mov r8,qword[rsp]
mov qword[a],r8
add rsp,8

;accepting_b
mov rdi,fin
mov rax,0
sub rsp,8
mov rsi,rsp
call scanf
mov r8,qword[rsp]
mov qword[b],r8
add rsp,8

;accepting_c
mov rdi,fin
mov rax,0
sub rsp,8
mov rsi,rsp
call scanf
mov r8,qword[rsp]
mov qword[c],r8
add rsp,8
;========================Finding b^2 and storing in temp===============================
fld qword[b]
fmul qword[b]
fstp qword[temp]


;======================Finding 4ac and storing in temp2========================================
mov qword[temp2],4
fild qword[temp2]
fstp qword[temp2]

fld qword[temp2]
fmul qword[a]
fmul qword[c]

fstp qword[temp2]; fstp is store floating point value

;==========================Finding Delta===============================
fld qword[temp]
fsub qword[temp2]
fstp qword[delta]

fld qword[delta]
mov rax,qword[delta]
bt rax,63
jc down
;------------------------------------Real Roots------------------------------------------
fsqrt
fstp qword[delta]
;==========================Finding numerator=============================
fld qword[b]
fchs				;changing sign of b
fstp qword[temp3]		;-b in temp3

fld qword[a]
fadd qword[a]			;storing 2a in st0

fstp qword[temp]		;temp=2a

fld qword[temp3]
fadd qword[delta]
fdiv qword[temp]
fstp qword[root1]


fld qword[temp3]
fsub qword[delta]
fdiv qword[temp]
fstp qword[root2]

;==============Printing roots===================
mov rdi,format
mov rax,2
sub rsp,8
movsd xmm0,[root1]
movsd xmm1,[root2]
call printf
add rsp,8
jmp exit
;--------Imaginary Roots------------------------------------------
down:
fchs
fsqrt
fstp qword[delta]

fld qword[a]
fadd qword[a]
fstp qword[temp]		;temp=2a

fld qword[b]
fchs								;changing sign of b
fstp qword[temp3]		;temp3=-b

fld qword[temp3]
fdiv qword[temp]
fstp qword[temp3]			;Now temp3 has real part of both root

fld qword[delta]
fdiv qword[temp]
fstp qword[temp]			;Now temp has imaginary part of first root

fld qword[temp]
fchs
fstp qword[temp2]			;Now temp2 has imaginary part of second root
;================Printing first root================
mov rdi,format_img1
mov rax,2
sub rsp,8
movsd xmm0,[temp3]
movsd xmm1,[temp]
call printf
add rsp,8

;================Printing Second root================
mov rdi,format_img2
mov rax,2
sub rsp,8
movsd xmm0,[temp3]
movsd xmm1,[temp2]
call printf
add rsp,8

exit:
mov rax,60
mov rdi,0
syscall

