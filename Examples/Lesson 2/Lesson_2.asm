.586P
.model flat, stdcall

include cons.inc		; Sabit olarak tanımlanan değişkenleri dahil et

_data segment
	include dat.inc		; Dat.inc dahil et
_data ends

_text segment
start:
	mov eax, cons_1			; cons_1 değerini eax içerisine taşı
	shl eax, 1				; Multiply by 2
	mov dat_1, eax			; Çıkan sonuç dat_1 değerine kayıt edilir
	
	;----------------------
	
	mov eax, cons_2
	shl eax, 2				; Multiply by 4
	mov dat_2, eax
	
	;----------------------
	
	mov eax, cons_3
	add eax, 1000			; 1000 ile topla
	mov dat_3, eax
	
	;----------------------
	
	mov eax, cons_4
	add eax, 2000
	mov dat_4, eax
	
	;----------------------
	
	mov eax, cons_5
	sub eax, 3000			; 2000 çıkart
	mov dat_5, eax
	
	;----------------------
	
	mov eax, cons_6
	sub eax, 4000
	mov dat_6, eax
	
	;----------------------
	
	mov eax, cons_7
	mov edx, 3
	imul edx				; Multiply by 3
	mov dat_7, eax
	
	;----------------------
	
	mov eax, cons_8
	mov edx, 7
	imul edx				; Multiply by 7
	mov dat_8, eax
	
	;----------------------
	
	mov eax, cons_9
	mov ebx, 3
	mov edx, 0
	idiv ebx				; Divide by 3
	mov dat_9, eax
	
	;----------------------
	
	mov eax, cons_10
	mov ebx, 7
	mov edx, 0				; idiv komutunda eax üzerinden veri alabilmek için edx değerini sıfırlamak gerekir.
	idiv ebx				; Divide by 7
	mov dat_10, eax
	
	;----------------------
	
	; Toplam, çıkartma, çarpma, bölme işlemleri
	
	ret
_text ends

end start