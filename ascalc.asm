section .data
	; Strings
	msgtitle	db	'~ Calculator ~',0xa
	lmsgtitle	equ	$-msgtitle

	msgnum1		db	'Enter first number: '
	lmsgnum1	equ	$-msgnum1

	msgnum2		db	'Enter second number: '
	lmsgnum2	equ	$-msgnum2

	msgop		db	'Select operation:',0xa
	lmsgop		equ	$-msgop

	msgadd		db	' 1. Add',0xa
	lmsgadd		equ	$-msgadd

	msgsubtract	db	' 2. Subtract',0xa
	lmsgsubtract	equ	$-msgsubtract

	msgprompt	db	'> '
	lmsgprompt	equ	$-msgprompt

	msgans		db	'Answer: '
	lmsgans		equ	$-msgans

section .bss
	; Variables to store math numbers and stuff in
	; digits input by user are received as ascii representations of those digits (each digit is 1 byte)
	num1	resb	8
	num2	resb	8
	op	resb	1
	ans	resb	8

section .text
global _start

_start:
	; print msgtitle
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgtitle
	mov	edx,lmsgtitle
	int	0x80

	; print msgnum1
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgnum1
	mov	edx,lmsgnum1
	int	0x80

	; read in first number to num1
	mov	eax,3		; sys_read
	mov	ebx,0		; stdin
	mov	ecx,num1
	mov	edx,2
	int	0x80

	; print msgnum2
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgnum2
	mov	edx,lmsgnum2
	int	0x80

	; read in second number to num2
	mov	eax,3		; sys_read
	mov	ebx,0		; stdin
	mov	ecx,num2
	mov	edx,2
	int	0x80

	; print msgop
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgop
	mov	edx,lmsgop
	int	0x80

	; print msgadd
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgadd
	mov	edx,lmsgadd
	int	0x80

	; print msgsubtract
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgsubtract
	mov	edx,lmsgsubtract
	int	0x80

	; print msgprompt
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgprompt
	mov	edx,lmsgprompt
	int	0x80

	; read in desired operation to op
	mov	eax,3		; sys_read
	mov	ebx,0		; stdin
	mov	ecx,op
	mov	edx,1
	int	0x80

	; test for user's choice
	mov	eax,[op]	; store user's selection in eax
	sub	eax,'0'		; convert from ascii to decimal

	cmp	eax,1		; operation = 1 (add)
	je	add
	cmp	eax,2		; operation = 2 (subtract)
	je	subtract

	; exit program with error code 1 if no jumps were made
	mov	eax,1		; sys_exit
	mov	ebx,1
	int	0x80

add:
	mov	eax,[num1]	; store first number in eax
	mov	ebx,[num2]	; store second number in ebx

	sub	eax,'0'		; convert num1 from ascii to decimal
	sub	ebx,'0'		; convert num2 from ascii to decimal

	add	eax,ebx		; add num2 to num1, storing result in eax

	add	eax,'0'		; convert from decimal to ascii

	mov	[ans],eax	; move result in eax to ans

	; print msgans
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgans
	mov	edx,lmsgans
	int	0x80

	; print ans
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,ans
	mov	edx,8
	int	0x80

	; exit program
	mov	eax,1		; sys_exit
	mov	ebx,0
	int	0x80

subtract:
	mov	eax,[num1]	; store first number in eax
	mov	ebx,[num2]	; store second number in ebx

	sub	eax,'0'		; convert num1 from ascii to decimal
	sub	ebx,'0'		; convert num2 from ascii to decimal

	sub	eax,ebx		; subtract ebx from eax, storing result in eax

	add	eax,'0'		; convert from ascii to decimal

	mov	[ans],eax	; move result in eax to ans

	; print msgans
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,msgans
	mov	edx,lmsgans
	int	0x80

	; print ans
	mov	eax,4		; sys_write
	mov	ebx,1		; stdout
	mov	ecx,ans
	mov	edx,8
	int	0x80

	; exit program
	mov	eax,1		; sys_exit
	mov	ebx,0
	int	0x80
