#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

obj := {}

obj.Test := 1
obj.RPM	:= "$50000"

MsgBox % Clipboard := Jxon_Dump(obj)

obj2 := Jxon_Load(Clipboard)

for each, item in obj2
	MsgBox % item