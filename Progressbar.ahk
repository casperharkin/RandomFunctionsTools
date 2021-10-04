#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui Progress: +Toolwindow -Caption 
Gui Progress: Color, FFFFFF
Gui Progress: Font, Bold s8
Gui Progress: Add, Progress, x18 y50 w276 h20 -Smooth vMyProgress, 100
Gui Progress: Add, Text, x96 y14 w120 h23 +0x200 +Center, Loading GAS Notes
Gui Progress: Show, w312 h85, Loading GAS Notes:

Loop 5
{
sleep 100
GuiControl,, MyProgress, +20
}

Gui Progress: destroy