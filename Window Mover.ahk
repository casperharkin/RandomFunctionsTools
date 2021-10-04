#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Offset := "8"

sysget mon1, monitor, 1
sysget mon2, monitor, 2

Numpad4::
; Grab Active Window Title
WinGetTitle, Title, A

; Grab Active Window Pos
WinGetPos, X,Y,,,%Title%

; What Screen was this on when called
If (X > mon2left-X)
	CallerMon := "mon2"
Else
	CallerMon := "mon1"

;MsgBox % CallerMon 

; WinGet List to find the Z-Order of Windows
WinGet, Z_Order_List, List

; Check Z Order List for Top Window on Other Screen
Loop % Z_Order_List
{
	; Grab Title from Unique ID/HWND passes from WinGet
	WinGetTitle, ID2Title, % "ahk_id " Z_Order_List%A_Index%

	; Grab position of that window
	WinGetPos, X2,Y2,,,%ID2Title%

	If (CallerMon = "mon1")	and (X2 > mon2left-Offset) and (ID2Title != "")
		{
			OtherWindow := ID2Title
			Break
		}
	else If (CallerMon = "mon2") and (X2 < mon2left-Offset) and (ID2Title != "")
		{
			OtherWindow := ID2Title
			Break
		}
}

if (CallerMon = "mon1")
	{
		WinMove, %Title%, , % mon2left-Offset, mon2top-Offset
		WinMove, %OtherWindow%, , % mon1left-Offset, mon1top-Offset
	}

else if (CallerMon = "mon2")
	{
		WinMove, %Title%, , % mon1left-Offset, mon1top-Offset
		WinMove, %OtherWindow%, , % mon2left-Offset, mon2top-Offset
	}
Return

