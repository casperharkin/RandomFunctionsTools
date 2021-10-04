#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include C:\Users\babb\Documents\Autohotkey\Lib

Global ExitThreadFlag
ExitThreadFlag := False

loop {

	Sleep(2000)
	MsgBox % A_Index
}
Return

#q::
ExitThreadFlag := !ExitThreadFlag
Return

