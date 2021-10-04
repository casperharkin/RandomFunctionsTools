#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




IniRead, OutputVar, %A_ScriptFullPath%, General, 1
MsgBox % OutputVar

q::
InputBox, Value,
IniWrite, %Value%, %A_ScriptFullPath%, General, 1

Return


/*


[General]
1=ASD



*/
