.586P
.model flat, stdcall

extern prog_module@0:near		; near -->  prosedür çağrısını aynı segment içerisinde yer alacağı anlamına gelir

_data segment
_data ends

_text segment
start:
	call prog_module@0			; @0 parametre olarak geçirilmesi gereken byte sayısını belirtir verilen veritipinin byte değeri yazılır.
	ret
_text ends

end start

; Object Modülü kullanımı