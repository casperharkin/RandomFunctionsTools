#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
Return

q::

Xl := ComObjActive("Excel.Application")
ComObjError(false)

AGS := Xl.ActiveCell.value

SetTitleMatchMode, 2
sleep 1000
winactivate,ahk_exe Payback.exe
sleep 100
Send, {Alt}
sleep 100
Send, {Down}
sleep 100
Send, {enter}
sleep 100
Send %AGS%
sleep 100
Send, {enter}
sleep 100
Clipboard := AGS

MsgBox 0x24, Checking ePOD, Is this a repayment at less than 5`%?`n`n%AGS%
IfMsgBox Yes,{



Xl.ActiveCell.Interior.ColorIndex := 15
winactivate,ahk_exe EXCEL.EXE
Send, {Down}
} 
Else IfMsgBox No,{
winactivate,ahk_exe EXCEL.EXE
Send, {Down}

Return
}

