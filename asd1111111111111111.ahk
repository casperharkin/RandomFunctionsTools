#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 	Gui, Add, Edit, % "g_Foo +hwndhEditControlConflictText", % "Test me 1"

Loop 4
    Gui, Add, Text, % "g_Foo", % "Test me " . A_Index
    Gui, Show

    Exit

    _Foo:
        GuiControlGet, Caller_Hwnd, Hwnd, % A_GuiControl
		
        MsgBox %  "_Foo Called by Control: " A_GuiControl " with Hwnd: " Caller_Hwnd "`nIf this is the Hwnd: " hEditControlConflictText " There was a conflict. "
    Return