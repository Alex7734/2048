.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern printf: proc

;extern getch: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "2048",0
area_width EQU 640
area_height EQU 480
area DD 0

counter DD 0 ; numara evenimentele de tip timer

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20
table_size equ 48

symbol_width EQU 10

symbol_height EQU 20
include digits.inc
include letters.inc

tabla dd 0,0,0,0
	  dd 0,2,0,0
	  dd 0,0,0,0
	  dd 0,0,0,0

tabla2 dd 0,2048,1024,16
	  dd 2,0,512,32
	  dd 4,0,256,64
	  dd 0,0,8,128
	  
pozX dd 115, 250, 385, 520
	 dd 115, 250, 385, 520
	 dd 115, 250, 385, 520
	 dd 115, 250, 385, 520
  
pozY dd 80 , 80 , 80 , 80
	 dd 175, 175, 175, 175
	 dd 270, 270, 270, 270
	 dd 360, 360, 360, 360
	 

numOfShifts dd 0
table dd 0
RandomNumber dd 0	 
format db "%d ", 0
textFinish db "oopsie :(", 0
placeholder dd 15
placesLeftEmpty dd 15
temp dd 0
	
.code

CountZeros macro
local LoopStart, ZeroNotFound
    mov ecx, 16 
    mov eax, 0
    xor ebx, ebx
LoopStart:
    cmp dword ptr [tabla+ebx], 0
    jne ZeroNotFound 
    inc eax 
ZeroNotFound:
    add ebx, 4 
    cmp ebx, 64 
    jne LoopStart 
    mov placesLeftEmpty, eax
endm

RandomNum proc
    rdtsc
	xor edx, edx
    div placeholder
    mov RandomNumber, edx
    inc ebx
    ret
RandomNum endp

GenerateElement macro
local CheckElement, AddElement
    mov ecx, 15
    xor ebx, ebx
CheckElement:
    cmp [tabla+ebx], 0
    je AddElement
    add ebx, 4
    loop CheckElement
AddElement:
    call RandomNum
    mov edx, RandomNumber
    shl edx, 2
    cmp [tabla+edx], 0
    jne AddElement
    mov [tabla+edx], 2
	push offset textFinish
	call printf
	add esp, 8
endm


; define macro to perform a single clockwise rotation on a 4x4 matrix
rotate_matrix macro	
	push eax
	xor eax, eax
	
    mov edx, dword ptr tabla[12*4]
	mov tabla2[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla[8*4]
	mov tabla2[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla[4*4]
	mov tabla2[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla[0]
	mov tabla2[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla[13*4]
	mov tabla2[eax], edx 
	add eax, 4
    mov edx, dword ptr tabla[9*4]
	mov tabla2[eax], edx 
	add eax, 4
    mov edx, dword ptr tabla[5*4]
	mov tabla2[eax], edx 
	add eax, 4
    mov edx, dword ptr tabla[1*4]
	mov tabla2[eax], edx 
	add eax, 4
    mov edx, dword ptr tabla[14*4]
	mov tabla2[eax], edx 
	add eax, 4				
    mov edx, dword ptr tabla[10*4]
	mov tabla2[eax], edx 
	add eax, 4	
    mov edx, dword ptr tabla[6*4]
	mov tabla2[eax], edx 
	add eax, 4
    mov edx, dword ptr tabla[2*4]
	mov tabla2[eax], edx 
	add eax, 4	
    mov edx, dword ptr tabla[15*4]
	mov tabla2[eax], edx 
	add eax, 4	
    mov edx, dword ptr tabla[11*4]
	mov tabla2[eax], edx 
	add eax, 4	
    mov edx, dword ptr tabla[7*4]
	mov tabla2[eax], edx 
	add eax, 4	
    mov edx, dword ptr tabla[3*4]
	mov tabla2[eax], edx 
	
	xor eax, eax
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
	add eax, 4
	mov edx, dword ptr tabla2[eax]
	mov tabla[eax], edx 
		
	pop eax
	
endm


; define macro for collapsing down
collapse_down_macro MACRO
    local rowMergeLoop, rowMovement, colMergeLoop, nextRowMergeLoop, colScan, isZero, nextAlsoZero, endColScan, rowMovement2, isZero2, colScan2, endColScan2, nextAlsoZero2
 	
	mov ebx, 12
    mov ecx, 12
	
	 
	rowMovement2:
		mov ebx,12
		colScan2:
			xor edx,edx
			mov esi, tabla[ebx*4+ecx]
			mov edx, ebx
			cmp esi, 0
			jne endColScan2
			
			isZero2:

			sub edx, 4
			mov edi, tabla[edx*4+ecx]
			cmp edi,0 
			je nextAlsoZero2
				add numOfShifts, 1
				; runs if next diff than 0
				mov tabla[ebx*4+ecx], edi
				mov tabla[edx*4+ecx], 0
				jmp endColScan2

			nextAlsoZero2:
			cmp edx, 0
			jg isZero2
			
			jmp endColScan2

		endColScan2:
		sub ebx,4
		cmp ebx,0
		jge colScan2
			
	sub ecx,4
	cmp ecx,0
	jge rowMovement2
  
	mov ebx, 12
    mov ecx, 12
	
	
	rowMergeLoop:
		mov ebx,12
		colMergeLoop:
			 mov esi,tabla[ebx*4+ecx]
			 sub ebx,4
			 mov ebp,tabla[ebx*4+ecx]
			 add ebx,4
			 cmp esi,ebp
			 jne nextRowMergeLoop
			 
			 ; this runs if the two numbers are the same
			 add tabla[ebx*4+ecx],esi
			 sub ebx,4
			 mov tabla[ebx*4+ecx],0
			 add ebx,4

		     nextRowMergeLoop:
			 sub ebx,4
			 cmp ebx,4
		jge colMergeLoop
	sub ecx,4
	cmp ecx,0
	jge rowMergeLoop

	mov ebx, 12
	mov ecx, 12

	rowMovement:
		mov ebx,12
		colScan:
			xor edx,edx
			mov esi, tabla[ebx*4+ecx]
			mov edx, ebx
			cmp esi, 0
			jne endColScan
			
			isZero:

			sub edx, 4
			mov edi, tabla[edx*4+ecx]
			cmp edi,0 
			je nextAlsoZero
					
				; runs if next diff than 0
				mov tabla[ebx*4+ecx], edi
				mov tabla[edx*4+ecx], 0
				jmp endColScan

			nextAlsoZero:
			cmp edx, 0
			jg isZero
			
			jmp endColScan

		endColScan:
		sub ebx,4
		cmp ebx,0
		jge colScan
			
	sub ecx,4
	cmp ecx,0
	jge rowMovement

ENDM

collapse_up_macro macro
	rotate_matrix
	rotate_matrix
	collapse_down_macro
	rotate_matrix
	rotate_matrix
endm 

collapse_left_macro macro
	rotate_matrix
	rotate_matrix
	rotate_matrix
	collapse_down_macro
	rotate_matrix
endm

collapse_right_macro macro
	rotate_matrix
	collapse_down_macro
	rotate_matrix
	rotate_matrix
	rotate_matrix
endm


; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	
	ret
make_text endp


make_text_white proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	
	ret
make_text_white endp

; un macro ce ne deseaneaza o linie orizontala de lungime l incepand cu coordonatele x si y
line_horizontal macro x, y, len, color
local bucla_linie
	mov eax, y
	mov ebx, area_width 
	mul ebx 
	add eax, x
	shl eax, 2 
	add eax, area
	mov ecx, len
bucla_linie:
	mov dword ptr[eax], color
	add eax, 4
	loop bucla_linie
endm

; un macro ce ne deseaneaza o linie verticala de lungime l incepand cu coordonatele x si y
line_vertical macro x, y, len, color
local bucla_linie
	mov eax, y
	mov ebx, area_width 
	mul ebx 
	add eax, x
	shl eax, 2 
	add eax, area
	mov ecx, len
bucla_linie:
	mov dword ptr[eax], color
	add eax, area_width*4
	loop bucla_linie
endm


; macro ce deseneaza tabla de joc la initializare 
desenareTabla macro	 
	 xor esi, esi
	 mov edi, 30
	 
	deseneazaLinii:
		line_horizontal 50, edi, 540, 0000000h
		add edi, 100
		inc esi
		cmp esi,5
	jne deseneazaLinii
	
	
	xor esi, esi
	mov edi, 50
	
	deseneazaColoane:
		line_vertical edi, 30, 400, 0000000h
		add edi, 135
		inc esi
		cmp esi,5
	jne deseneazaColoane
endm


; un macro ce sterge numerele pe tabla
delete_numbers macro
	local bucla_linie, bucla_coloana, done, print0, print2, print4, print8, print16, print32, print64, print128, print256, print512, print1024, print2048
	xor eax, eax
	bucla_linie:
		xor ecx, ecx
		bucla_coloana:
				mov edi, tabla[eax*4+ecx]
				mov ebx, pozX[eax*4+ecx]
				mov edx, pozY[eax*4+ecx]
				
				cmp edi, 0
				je print0
				
				cmp edi, 2
				je print2
				
				cmp edi, 4
				je print4
				
				cmp edi, 8
				je print8
				
				cmp edi, 16
				je print16
				
				cmp edi, 32
				je print32
				
				cmp edi, 64
				je print64
				
				cmp edi, 128
				je print128
				
				cmp edi, 256
				je print256
				
				cmp edi, 512
				je print512
				
				cmp edi, 1024
				je print1024
				
				cmp edi, 2048
				je print2048
				
				print0:
					jmp done
				
				print2:
					make_text_macro_white_space '2', area, ebx, edx
					jmp done
					
				print4:
					make_text_macro_white_space '4', area, ebx, edx
					jmp done
					
				print8:
					make_text_macro_white_space '8', area, ebx, edx
					jmp done
					
				print16:
					sub ebx, 6
					make_text_macro_white_space '1', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '6', area, ebx, edx
					sub ebx, 6
					jmp done
					
				print32:
					sub ebx, 6
					make_text_macro_white_space '3', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '2', area, ebx, edx
					sub ebx, 6
					jmp done
					
				print64:
					sub ebx, 6
					make_text_macro_white_space '6', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '4', area, ebx, edx
					sub ebx, 6
					jmp done		
				
				print128:
					sub ebx, 12
					make_text_macro_white_space '1', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '2', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '8', area, ebx, edx
					sub ebx, 12
					jmp done
					
				print256:
					sub ebx, 12
					make_text_macro_white_space '2', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '5', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '6', area, ebx, edx
					sub ebx, 12
					jmp done
					
				print512:
					sub ebx, 12
					make_text_macro_white_space '5', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '2', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '4', area, ebx, edx
					sub ebx, 12		
					jmp done
					
				print1024:
					sub ebx, 18
					make_text_macro_white_space '1', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '0', area, ebx, edx					
					add ebx, 12
					make_text_macro_white_space '2', area, ebx, edx					
					add ebx, 12
					make_text_macro_white_space '4', area, ebx, edx					
					sub ebx, 18
					jmp done
					
				print2048:
					sub ebx, 18
					make_text_macro_white_space '2', area, ebx, edx
					add ebx, 12
					make_text_macro_white_space '0', area, ebx, edx					
					add ebx, 12
					make_text_macro_white_space '4', area, ebx, edx					
					add ebx, 12
					make_text_macro_white_space '8', area, ebx, edx					
					sub ebx, 18
					jmp done
					
				done:
				add ecx, 4
		cmp ecx, 16
		jl bucla_coloana
	add eax,4
	cmp eax,16
	jl bucla_linie
endm
			
; un macro ce afiseaza numerele pe tabla
make_numbers macro
	local bucla_linie, bucla_coloana, done, print0, print2, print4, print8, print16, print32, print64, print128, print256, print512, print1024, print2048
	;call putRandomNumOnBoard
	xor eax, eax
	bucla_linie:
		xor ecx, ecx
		bucla_coloana:
				; logica de afisare pentru 2
				mov edi, tabla[eax*4+ecx]
				mov ebx, pozX[eax*4+ecx]
				mov edx, pozY[eax*4+ecx]
				
				cmp edi, 0
				je print0
				
				cmp edi, 2
				je print2
				
				cmp edi, 4
				je print4
				
				cmp edi, 8
				je print8
				
				cmp edi, 16
				je print16
				
				cmp edi, 32
				je print32
				
				cmp edi, 64
				je print64
				
				cmp edi, 128
				je print128
				
				cmp edi, 256
				je print256
				
				cmp edi, 512
				je print512
				
				cmp edi, 1024
				je print1024
				
				cmp edi, 2048
				je print2048
				
				print0:
					jmp done
				
				print2:
					make_text_macro '2', area, ebx, edx
					jmp done
					
				print4:
					make_text_macro '4', area, ebx, edx
					jmp done
					
				print8:
					make_text_macro '8', area, ebx, edx
					jmp done
					
				print16:
					sub ebx, 6
					make_text_macro '1', area, ebx, edx
					add ebx, 12
					make_text_macro '6', area, ebx, edx
					sub ebx, 6
					jmp done
					
				print32:
					sub ebx, 6
					make_text_macro '3', area, ebx, edx
					add ebx, 12
					make_text_macro '2', area, ebx, edx
					sub ebx, 6
					jmp done
					
				print64:
					sub ebx, 6
					make_text_macro '6', area, ebx, edx
					add ebx, 12
					make_text_macro '4', area, ebx, edx
					sub ebx, 6
					jmp done		
				
				print128:
					sub ebx, 12
					make_text_macro '1', area, ebx, edx
					add ebx, 12
					make_text_macro '2', area, ebx, edx
					add ebx, 12
					make_text_macro '8', area, ebx, edx
					sub ebx, 12
					jmp done
					
				print256:
					sub ebx, 12
					make_text_macro '2', area, ebx, edx
					add ebx, 12
					make_text_macro '5', area, ebx, edx
					add ebx, 12
					make_text_macro '6', area, ebx, edx
					sub ebx, 12
					jmp done
					
				print512:
					sub ebx, 12
					make_text_macro '5', area, ebx, edx
					add ebx, 12
					make_text_macro '2', area, ebx, edx
					add ebx, 12
					make_text_macro '4', area, ebx, edx
					sub ebx, 12		
					jmp done
					
				print1024:
					sub ebx, 18
					make_text_macro '1', area, ebx, edx
					add ebx, 12
					make_text_macro '0', area, ebx, edx					
					add ebx, 12
					make_text_macro '2', area, ebx, edx					
					add ebx, 12
					make_text_macro '4', area, ebx, edx					
					sub ebx, 18
					jmp done
					
				print2048:
					sub ebx, 18
					make_text_macro '2', area, ebx, edx
					add ebx, 12
					make_text_macro '0', area, ebx, edx					
					add ebx, 12
					make_text_macro '4', area, ebx, edx					
					add ebx, 12
					make_text_macro '8', area, ebx, edx					
					sub ebx, 18
					jmp done
					
				done:
				add ecx, 4
		cmp ecx, 16
		jl bucla_coloana
	add eax,4
	cmp eax,16
	jl bucla_linie
endm

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

make_text_macro_white_space macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text_white
	add esp, 16
endm

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click, 3 - s-a apasat o tasta)
; arg2 - x (in cazul apasarii unei taste, x contine codul ascii al tastei care a fost apasata)
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 3
	je evt_key
	cmp eax, 1
	je evt_click
	cmp eax, 2
	jz evt_timer 
	jg evt_key
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	jmp afisare_litere

	
evt_key:
	mov eax,[ebp+arg2]
	cmp eax,'W'
	je upLogic
	
	mov eax, [ebp+arg2]
	cmp eax, 'A'
	je leftLogic
	
	mov eax,[ebp+arg2]
	cmp eax,'S'
	je downLogic
	
	mov eax,[ebp+arg2]
	cmp eax,'D'
	je rightLogic
	
upLogic:
	CountZeros
	cmp placesLeftEmpty, 0
	je afisare_litere
	push eax
	push offset format
	call printf
	add esp, 8
	delete_numbers
	collapse_up_macro
	cmp numOfShifts, 1
	jle skipGenerate1
	GenerateElement
	skipGenerate1:
	make_numbers
	push numOfShifts
	push offset format
	call printf
	add esp, 8
	
	jmp afisare_litere


leftLogic:
	CountZeros
	cmp placesLeftEmpty, 0
	je afisare_litere
	push eax
	push offset format
	call printf
	add esp, 8
	delete_numbers
	collapse_left_macro
	cmp numOfShifts, 1
	jle skipGenerate2
	GenerateElement
	skipGenerate2:
	delete_numbers
	make_numbers
	jmp afisare_litere
	
downLogic:
	CountZeros
	cmp placesLeftEmpty, 0
	je afisare_litere
	push eax
	push offset format
	call printf
	add esp, 8
	delete_numbers
	collapse_down_macro
	cmp numOfShifts, 1
	jle skipGenerate3
	GenerateElement
	skipGenerate3:
	make_numbers
	jmp afisare_litere
	
rightLogic:
	CountZeros
	cmp placesLeftEmpty, 0
	je afisare_litere
	push eax
	push offset format
	call printf
	add esp, 8
	delete_numbers
	collapse_right_macro
	cmp numOfShifts, 1
	jle skipGenerate4
	GenerateElement
	skipGenerate4:
	make_numbers
	jmp afisare_litere

	
afisare_litere:
	desenareTabla
	jmp evt_timer
	
evt_click:
	delete_numbers
	jmp final_draw
	
	
evt_timer:
	inc counter	
	jmp final_draw

final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	push 0
	call exit
end start
