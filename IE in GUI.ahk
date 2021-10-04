#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

	Gui, +LastFound +Resize +OwnDialogs
	Gui, Add, Button, , Okay
	Gui, Add, ActiveX, w814 h635 xm ym vWB hwndATLWinHWND, Shell.Explorer
	Gui,show, w510 h600 ,Gui Browser

	WB.silent := true
	WB.Navigate("http://dbefinws01.cprod.corp.ntgov:8080/Masterpiece4.0_NTG/Welcome.jsp")

