.586P
.model flat, stdcall

public proc1
	public alt				; bir değişken tanımı

	_data segment
		alt dword 0
	_data ends

	_text segment
		proc1 proc
			mov eax, alt
			add eax, 10
			ret
		proc1 endp
	_text ends
end

; Modül içerisinde public bir değer tanımlama yapılır
; Sonra bu değeri bir modül içerisinde kullanılır