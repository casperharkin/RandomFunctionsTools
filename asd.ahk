#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Gui, Add, Picture, Icon2, % A_AhkPath
Gui, Add, Button,gOkay, Click to Center
Gui, Show,w500 , Example

Exit ; AES

Okay(){
WinGetPos,x,y,w,h,Example
GuiControl, MoveDraw, Static1, % " x" (w/2)  
GuiControl, MoveDraw, Button1, % " x" (w/2)-80 
}


