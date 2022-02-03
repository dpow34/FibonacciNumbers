TITLE Fibonacci Numbers     (program2_powdrild.asm)

; Author: David Powdrill
; Last Modified:4/17/2020
; OSU email address: powdrild@oregonstate.edu
; Course number/section: CS271-400
; Project Number: 2                 Due Date: 4/19/2020
; Description: Asks a user to enter the number of fibonacci terms they'd like to be displayed (1-46) and then the program displays the fibonacci numbers in rows of 5. 

INCLUDE Irvine32.inc

LOWER = 1																	;lowest number of fibonacci terms that can be displayed
UPPER = 46																	;highest number of fibonacci terms that can be displayed

.data
userName		QWORD	?													;name of user
fibTerms		DWORD	?													;number of Fibonacci terms
prevTerm		DWORD	1													;first term in Fibonacci equation
currTerm		DWORD	0													;second term in Fibonacci equation
answer			DWORD	?													;answer of Fibonacci equation
intro_1			BYTE	"Fibonacci Numbers ", 0
intro_2			BYTE	"Programmed by David Powdrill ", 0
prompt_1		BYTE	"What's your name? ", 0
greeting_1		BYTE	"Hello, ", 0
instruct_1		BYTE	"Enter the number of Fibonacci terms to be displayed ", 0
instruct_2		BYTE	"Give the number as an integer in the range [1 .. 46]. ", 0
prompt_2		BYTE	"How many Fibonacci terms do you want? ", 0
error_1			BYTE	"Out of range. Enter a number in [1 .. 46] ", 0
goodBye_1		BYTE	"Result certifed by David Powdrill. ", 0
goodBye_2		BYTE	"Goodbye, ", 0


.code
main PROC

;------------------------------
;Introduces title and author of program.
; Asks user for their name and greets user
;------------------------------
	;prints title
	mov		edx, OFFSET intro_1		
	call	WriteString				
	call	CrLf	

	;prints author
	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf
	call	CrLf

	;asks user for name and stores as userName
	mov		edx, OFFSET prompt_1	
	call	WriteString
	mov		edx, OFFSET userName	
	mov		ecx, 32
	call	ReadString				

	;greets user 
	mov		edx, OFFSET greeting_1
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	call	CrLf
;------------------------------
; Gives instructions and parameters to user
;-------------------------------
	;prints instructions
	mov		edx, OFFSET instruct_1
	call	WriteString
	call	CrLf

	;prints paramters for input by user
	mov		edx, OFFSET instruct_2
	call	WriteString
	call	CrLf
	call	CrLf

;--------------------------------
; Gets input from user and checks to 
; see if number entered fits parameters
;-------------------------------
again:
	;asks user for number of fibonacci terms
	mov		edx, OFFSET prompt_2
	call	WriteString
	call	ReadInt

	;valdates input fits parameters
	mov		fibTerms, eax
	cmp		eax, LOWER				;compares user inputted number with LOWER constant
	jl		error					
	mov		eax, fibTerms
	cmp		eax, UPPER				;compares user inputted number with UPPER constant
	jg		error
	call	CrLf
	jmp		display

error:
	;prints error message
	mov		edx, OFFSET error_1
	call	WriteString
	call	CrLf
	jmp		again

display:

;-------------------------------
; Displays fibonacci terms in rows
; of 5 up to specified term.
;--------------------------------
	mov		eax, prevTerm
	mov		ebx, currTerm
	mov		ecx, fibTerms
	mov		edx, 0					;values per row counter
fibloop:
	;checks to see if made it to the end of terms
	cmp		ecx, 0					;checks to see if there are more terms to display
	je		quitt

	;adds both terms
	add		eax, ebx				;adds currTerm to prevTerm
	mov		answer, eax				;stores sum as answer
	mov		eax, answer

	;checks to see if new line is needed
	cmp		edx, 4					;checks to see if there are 5 variables on the line already
	jg		newline

	;prints term and adds spaces
	call	WriteDec
	mov		al, 9					;tab character
	call	WriteChar
	call	WriteChar
	
	;sets variables and counters for next iteration
	mov		eax, prevTerm
	mov		eax, ebx				;sets prevTerm to the value of currTerm
	mov		ebx, answer				;sets currTerm to the value of answer
	add		edx, 1					;decreses number of terms left to display
	loop	fibloop
	jmp		quitt

newline:
	call	CrLf
	call	WriteDec
	mov		al, 9					;tab character
	call	WriteChar
	call	WriteChar
	mov		eax, prevTerm				
	mov		eax, ebx				;sets prevTerm to the value of currTerm
	mov		ebx, answer				;sets currTerm to the value of answer
	mov		edx, 1					;sets values per row counter to 1
	loop	fibloop

quitt:
	call	CrLf
	call	CrLf

;-------------------------------
; Prints Goodbye messages
;-------------------------------
	;prints first message
	mov		edx, OFFSET goodBye_1
	call	WriteString
	call	CrLf

	;prints second message with username
	mov		edx, OFFSET goodBye_2
	call	WriteString
	mov		edx, OFFSET	userName
	call	WriteString

	exit	; exit to operating system
main ENDP


END main
