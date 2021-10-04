#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



	~+LButton::
	
	Dims := {} ; Create Object for Screen Dimensions.
	WinGet, vUID,ID,A ; Get the ID of the active window. 
	
	WinGet, MinMax, MinMax, % " AHK_ID " vUID ; Check is the window is maximized.
	If (MinMax = 1) 
		WinRestore, % " AHK_ID " vUID ; if window is maximized then restore it.
	
	WinGetPos, X, , , , % " AHK_ID " vUID ; Grab the X Coord for active window

	SysGet, vMonitorCount, MonitorCount	; Count Monitors
	
	loop % vMonitorCount
	{
		SysGet, Mon, Monitor, % A_Index
		Dims["MonLeft" . A_Index] := MonLeft
	}
	
	if (X < Dims["MonLeft2"]) {
		WinMove,  % " AHK_ID " vUID, , % Dims["MonLeft2"]+50
		WinMaximize, % " AHK_ID " vUID
	}
	
	if (X > Dims["MonLeft2"]) {
		WinMove,  % " AHK_ID " vUID, , % Dims["MonLeft1"]+50
		WinMaximize, % " AHK_ID " vUID
	}
