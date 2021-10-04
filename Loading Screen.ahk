	#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	; #Warn  ; Enable warnings to assist with detecting common errors.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	
	Settimer, Count, 500
	
	Gui +AlwaysOnTop -Caption +ToolWindow +E0x08000000
	Gui Color, cBlue
	
	Gui Font, CWhite Bold s9 Segoe UI
	Gui Add, Progress,% " x40 y210    w421 h20 HwndhProgress vvProgress -Smooth +BackgroundTrans", 0
	Gui Add, Text,% "xp	y+p   w418 h23 +0x200 +Center +BackgroundTrans vvCurrentAction gMove", "Please wait..."
	Gui Show, w500 h500, LOADING
	
	WinSet, TransColor, cBlue 90, LOADING
	Exit
	
	Count:
	Count++
	GuiControl,,vProgress,+3
	If (count = "41") {
	    settimer, count, Off
	    Exitapp
	}
	Return
	
	Move() {
	PostMessage, 0xA1, 2
	}