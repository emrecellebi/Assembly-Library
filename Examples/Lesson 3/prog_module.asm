.586p

.model flat, stdcall

public prog_module
_text segment
	prog_module proc
		mov eax, 1000
		ret
	prog_module endp
_text ends
end