.586P						; CPU Mode
.model flat, stdcall 		; Flat memory model

; Data Segment
_data segment
_data ends

; Code Segment
_text segment
start:
	ret						; Exit
_text ends

end start

; Hiç bir şey yapmayan program