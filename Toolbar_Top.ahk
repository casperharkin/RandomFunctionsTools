#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

	SysGet, Mon, Monitor
	SetWorkArea(MonLeft, MonTop+40, MonRight, MonBottom-27)
	Gui, +LastFound -Resize -Caption -Border +HWNDhGUIBG +ToolWindow  -SysMenu +AlwaysOnTop
	Loop 12
		Gui, add, button, ym vButton%A_Index%, % "Button " A_Index
	Gui, Show,  % " w" A_ScreenWidth " h" 40 " y" 0,
	Exit
	
	SetWorkArea(left,top,right,bottom)  ; set main monitor work area ; windows are not resized!
	{
	    VarSetCapacity(area, 16)
	    NumPut(left,   area, 0, "UInt") ; left
	    NumPut(top,    area, 4, "UInt") ; top
	    NumPut(right,  area, 8, "UInt") ; right
	    NumPut(bottom, area,12, "UInt") ; bottom
	    DllCall("SystemParametersInfo", "UInt", 0x2F, "UInt", 0, "UPtr", &area, "UInt", 0) ; SPI_SETWORKAREA
	}