#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Application_Control_Workaround("C:\Windows\notepad.exe")
Exit

Application_Control_Workaround(_Path) {
	Sendinput, {LWin down}{r}{LWin up} 
	WinWait, Run
	ControlSetText, Edit1, %_Path%, Run
	ControlClick, Button2, Run
}

