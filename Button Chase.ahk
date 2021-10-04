#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines -1

Gui Add, Button, x270 y198 w80 h23 v_Button gClicked, -[ Click Me ]-
Gui Show, w620 h420, Button Chaser:
OnMessage(0x200, "WM_MOUSEMOVE")
Return

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) 
{
    Global
		DllCall("TrackMouseEvent", "UInt")
		MouseGetPos,OutputVarX,OutputVarY,,, 2
		ControlGetPos, x, y, w, h, %_Button%
		Random, Rand1, 0, 600
		Random, Rand2, 0, 420
		If (OutputVarX - x <= 20) or (OutputVarY - y <= 1)
			GuiControl, Move, _Button, % "x" Rand1 "y" Rand2
}

Clicked()
{
Msgbox % "Winner Winner, Pork Lunch."
}