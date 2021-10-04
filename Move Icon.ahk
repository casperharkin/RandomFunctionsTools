#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.






SetBatchLines -1
#SingleInstance Force   
#Persistent

Icon := {xVel : 10, yVel : 10, x : 0, y : 0}
SetTimer, MoveIcon, 100    
Exit

MoveIcon:

    Icon.x += Icon.xVel, Icon.y += Icon.yVel

    If Icon.x + Icon.Width > 600 OR Icon.x <= 0
        Icon.xVel *= -1

    If Icon.y + Icon.Height > 600 OR Icon.y <= 0
        Icon.yVel *= -1

	MoveIcon("Recycle Bin",Icon.x ,Icon.y)

Return

MoveIcon(Icon_Name := "Recycle Bin", x := "500", y := "500") {

ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman

if !hwWindow 
	ControlGet, hwWindow, HWND,, SysListView321, A

IfWinExist ahk_id %hwWindow%  
	WinGet, iProcessID, PID

hProcess := DllCall("OpenProcess", "UInt", 0x438, "Int", FALSE, "ptr", iProcessID)

ControlGet, list, list, Col1	
	Loop, Parse, list, `n
		if (A_LoopField = Icon_Name)
			ItemNo := A_Index-1

; LVM_SETITEMPOSITION
SendMessage, 0x1000+15, ItemNo, ( y << 16 )|x, SysListView321, Program Manager ahk_class Progman
}