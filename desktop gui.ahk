#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SoundGetWaveVolume, VolSlider


Gui, Add, Slider, gVolSlider ToolTip, % VolSlider
Gui, Add, Button,, Shutdown
Gui, Add, Button,gArrangeWindows, ArrangeWindows
Gui, Show, 

Return

VolSlider(){

GuiControlGet, VolSlider,, msctls_trackbar321
SoundSetWaveVolume, % VolSlider

}

ArrangeWindows(){


WinGet, List, List

	Loop % List
	{

		Active := List%A_Index%
		WinGet, Name, ProcessName, % "AHK_ID " Active 
		
		WinGet, MinMax, MinMax, % "AHK_ID " 
	
		If (MinMax = 1) and (Name != "ApplicationFrameHost.exe") 
			WinRestore, % "AHK_ID " Active  
	
		WinMove, % "AHK_ID " Active ,, 2000 , 0
		WinMaximize, % "AHK_ID " Active 
	}

}