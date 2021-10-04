#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


WinGet,hWnd,id,ahk_class AcrobatSDIWindow

oAcc := Acc_Get("Object", "3.1.1.2", 0, "ahk_id " hWnd)  
ControlHwnd := Acc_WindowFromObject(oAcc)
ControlFocus,, ahk_id %ControlHwnd%
ControlClick,, ahk_id %ControlHwnd%