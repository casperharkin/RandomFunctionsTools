#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
OnExit, UnHook

EVENT_OBJECT_LOCATIONCHANGE := "0x800B"
Event_Menu_Start := "0x4"


pCallback := RegisterCallback("WinEventProc")
Acc_SetWinEventHook(Event_Menu_Start, Event_Menu_Start, pCallBack)
return

UnHook:
	Acc_UnhookWinEvent(pCallback)
	ExitApp


WinEventProc(hHook, event, hWnd, idObject, idChild, eventThread, eventTime) {

	WinGet, Note_hWnd, ID, ahk_class Notepad
	If (Note_hWnd= hWnd)
		MsgBox % Format("{:X}", hWnd)

}

Esc:: GoTo, UnHook