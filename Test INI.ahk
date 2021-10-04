#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

IniRead, _Data, %A_ScriptFullPath%, General, A
MsgBox % _Data

Exit

q::
Iniwrite, Second, %A_ScriptFullPath%, General, A
Reload

Return




/*
[General]
A=Second







*/
