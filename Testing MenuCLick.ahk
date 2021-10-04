#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


	WinActivate, ahk_exe tn3270.exe
	
	WinGet,hWnd,id, Mochasoft - mainframe.nt.gov.au

	oAcc := Acc_Get("Object", "4.1.4.2", 0, "ahk_id " hWnd) 
	
	ControlHwnd := Acc_WindowFromObject(oAcc)

	ControlGetText, Text,, ahk_id %ControlHwnd%

	MsgBox %x%, %y% %Text%

	;ControlClick, %x% %y%, Mochasoft - mainframe.nt.gov.au
	
	MouseClick,, %x%, %y%
	Return
