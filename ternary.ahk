#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


MsgBox 0x24, Title of Msgbox, Text in msgbox., 9

IfMsgBox Yes, {
answer  := "True"
} Else IfMsgBox No, {
answer  := "False"
} Else IfMsgBox Timeout, {
answer  := "True"
}



MsgBox % var := answer="True" ? gosub, sub1 : Return

