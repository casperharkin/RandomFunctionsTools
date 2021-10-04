#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global GlobalVars

GlobalVars := {}
GlobalVars.Test1 := "TEST 1"
GlobalVars.Test2 := "TEST 2"
GlobalVars.Test3 := "TEST 3"

MsgBox % Func()

Return

Func()
{
	Return SubStr(GlobalVars.Test3,6,1)
}