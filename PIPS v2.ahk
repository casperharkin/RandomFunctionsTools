#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Gui, Add, ComboBox, w300 vCB1,
Gui, Add, Button, gOk vB1, Ok
Gui, Show
return

GuiClose:
GuiEscape:
ExitApp

Ok:
Gui, Submit, NoHide
History .= CB1 "|"
Sort, History, U D|
GuiControl, , CB1, |%History%
GuiControl, text, CB1, %CB1% 
return