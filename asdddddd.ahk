#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;bestApp_path := "C:\Notepad.exe"
;
;LaunchApp(BestApp_path)
;
;Launchapp(path)
;{
;Run % path,,, pid
;WinGetClass, winClass, ahk_pid %pid%
;Link := path
;MsgBox % Link " = " %Link%
;}


		
		bestApp_path := "C:\Notepad.exe"
		Link = bestApp_path
		MsgBox % Link " = " %Link%