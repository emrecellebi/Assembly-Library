.586P
.model flat, stdcall

;------------> Constants <------------
WM_DESTROY equ 2		; Pencere Kapatılması
WM_CREATE equ 1			; Pencere Oluşumu

WM_LBUTTONDOWN equ 201h	; Pencere için mouse sol click basılması
WM_RBUTTONDOWN equ 204h	; Pencere için mouse sağ click basılması

CS_VREDRAW equ 1h
CS_HREDRAW equ 2h
CS_GLOBALCLASS equ 4000h
WS_OVERLAPPEDWINDOW equ 000CF0000H

style equ CS_HREDRAW + CS_VREDRAW + CS_GLOBALCLASS

IDI_APPLICATION equ 32512
IDC_CROSS equ 32515

SW_SHOWNORMAL equ 1

;------------> Procedures Methods <------------

extern MessageBoxA@16:near
extern CreateWindowExA@48:near				; Her prosedür eax değerine çıktı bırakır.
extern DefWindowProcA@16:near
extern DispatchMessageA@4:near
extern ExitProcess@4:near
extern GetMessageA@16:near
extern GetModuleHandleA@4:near
extern LoadCursorA@8:near
extern LoadIconA@8:near
extern PostQuitMessage@4:near
extern RegisterClassA@4:near
extern ShowWindow@8:near
extern TranslateMessage@4:near
extern UpdateWindow@4:near

includelib lib\user32.lib
includelib lib\kernel32.lib

;------------> Structures <------------
MsgStruct struct			; Message Structure
	msHwnd dd ?				; Pencere Tanımlayıcısı
	msMessage dd ?			; Mesaj tanımlayıcısı
	msWparam dd ? 			; Mesaj ile ilgili yardımcı bilgiler
	msLparam dd ? 			; Mesaj ile ilgili yardımcı bilgiler
	msTime dd ? 			; Messj gönderme zamanı
	msPt dd ? 				; Mesjın gönderildiği andaki imleç konumu
MsgStruct ends

WndClass struct				; Window Style Structure
	clsStyle dd ? 			; Pencere Stili
	clWndProc dd ? 			; Mesaj prosedüre işaretçi
	clscExtra dd ? 			; Yardımcı baytlar hakkında bilgi
	clWndExtra dd ? 		; Yardımcı baytlar hakkında bilgi
	clsHinstance dd ? 		; Uygulama Tanımlayıcısı
	clsHicon dd ? 			; Pencere icon Tanımlayıcısı
	clsHcursor dd ? 		; Pencere Kursor Tanımlayıcısı
	clBkGround dd ? 		; Pencere background Tanımlayıcısı
	clMenuName dd ? 		; Menu Tanımlayıcısı
	clName dd ? 			; Pencere sınıfı adı
WndClass ends

_data segment				; Data Segment
	newHWnd dd 0
	msg MsgStruct <?>
	wc WndClass <?>
	hInst dd 0				; Uygulama tanımlayıcısı saklanır
	titleName db "Win32 Application", 0
	className db "class32", 0
	cap db "Message", 0
	; mes1 db "You have clicked the left mouse button", 0
	mes1 db "Melek Senturk", 0
	mes2 db "Exit. Bye!", 0
_data ends

_text segment				; Code Segment
start:
	push 0
	call GetModuleHandleA@4
	mov [hInst], eax

reg_class:
	; Window class structure doldurulur.
	mov [wc.clsStyle], style
	mov [wc.clWndProc], offset wndProc
	mov [wc.clscExtra], 0
	mov [wc.clWndExtra], 0
	mov eax, [hInst]
	mov [wc.clsHinstance], eax
	
	; ----------> Window Icon <----------
	push IDI_APPLICATION
	push 0
	call LoadIconA@8
	mov [wc.clsHicon], eax
	
	; ----------> Window Cursor <----------
	push IDC_CROSS
	push 0
	call LoadCursorA@8
	mov [wc.clsHcursor], eax
	
	mov [wc.clBkGround], 17				; Window Background Color
	
	mov dword ptr [wc.clMenuName], 0
	mov dword ptr [wc.clName], offset className
	push offset wc
	call RegisterClassA@4
	push 0
	push [hInst]
	push 0
	push 0
	push 400					; DY Window Height
	push 400					; DX Window Width
	push 100					; Y Window Pos
	push 100					; X Window Pos
	push WS_OVERLAPPEDWINDOW
	push offset titleName		; Window Name
	push offset className		; Class Name
	push 0
	call CreateWindowExA@48
	cmp eax, 0
	jz _error
	mov [newHWnd], eax			; Window Tanımlayıcısı
	
	push SW_SHOWNORMAL
	push [newHWnd]
	call ShowWindow@8			; Oluşturulan Pencereyi Göster
	
	push [newHWnd]
	call UpdateWindow@4			; Pencereyi Güncelle
	
msg_loop:
	push 0
	push 0
	push 0
	push offset msg
	call GetMessageA@16
	cmp eax, 0
	je end_loop
	push offset msg
	call TranslateMessage@4
	push offset msg
	call DispatchMessageA@4
	jmp msg_loop
	
end_loop:
	push [msg.msWparam]
	call ExitProcess@4

_error:
	jmp end_loop
	
wndProc proc
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	cmp dword ptr [ebp + 0ch], WM_DESTROY
	je WmDestroy
	cmp dword ptr [ebp + 0ch], WM_CREATE
	je WmCreate
	cmp dword ptr [ebp + 0ch], WM_LBUTTONDOWN
	je Wm_LButton
	cmp dword ptr [ebp + 0ch], WM_RBUTTONDOWN
	je Wm_RButton
	jmp defWndProc
wndProc endp

Wm_RButton:
	jmp WmDestroy
	
Wm_LButton:
	push 0					; MB_OK
	push offset cap
	push offset mes1
	push dword ptr [ebp + 08h]
	call MessageBoxA@16
	mov eax, 0
	jmp finish

WmCreate:
	mov eax, 0
	jmp finish

defWndProc:
	push dword ptr [ebp + 14h]
	push dword ptr [ebp + 10h]
	push dword ptr [ebp + 0ch]
	push dword ptr [ebp + 08h]
	call DefWindowProcA@16
	jmp finish
	
WmDestroy:
	push 0						; MB_OK
	push offset cap
	push offset mes2
	push dword ptr [ebp + 08h]
	call MessageBoxA@16
	push 0
	call PostQuitMessage@4
	mov eax, 0

finish:
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret 16

_text ends

end start