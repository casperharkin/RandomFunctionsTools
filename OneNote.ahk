#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

Event_Menu_Start := "0x3"
Event_Menu_End := "0x3"

pCallback := RegisterCallback("WinEvent")
Acc_SetWinEventHook(Event_Menu_Start, Event_Menu_End, pCallBack)
Return

    WinEvent(hHook, event, hWnd, idObject, idChild, eventThread, eventTime) {
	WinGetClass, Class, % "AHK_ID 0x" Format("{:X}",hWnd)
	If (Class = "Notepad")
			Winset, Alwaysontop, , A
			ToolTip "Set as AlwaysOnTop"
			Winset, Alwaysontop, , A
        }
	Else
