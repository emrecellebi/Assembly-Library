.586P
.model flat, stdcall

extern proc1@0:near			; modülü dahil et
extern alt:dword			; modül için deki değişkeni dahil et

_data segment
_data ends

_text segment
start:
	
	mov alt, 10
	call proc1@0			; modülü çağrılır
	mov eax, alt
	
	ret
_text ends

end start