#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Temp := {}
Temp.1 := 1
Temp.12 := 12
Temp.133 := 133

MsgBox % Temp
UnloadObject("Temp", Size := 0)
MsgBox % Temp
Return


UnloadObject(VarName, Size := 0) {
Global
%VarName% := 
VarSetCapacity(%VarName%, 0)
}


