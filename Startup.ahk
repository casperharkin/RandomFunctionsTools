#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

PaybackWindow := WinExist("ahk_exe Payback.exe")
tn3270Window := WinExist("ahk_exe tn3270.exe")

Gui +AlwaysOnTop -Caption +ToolWindow +E0x08000000
Gui Color, 0173C7
Gui Font, CWhite Bold s9 Segoe UI
Gui Add, Progress, x8 y34 w421 h20 HwndhProgress vvProgress -Smooth +BackgroundTrans, 0
Gui Add, Text, x11 y7 w418 h23 +0x200 +Center +BackgroundTrans vvCurrentAction gMove, Current Action
Gui Show, w437 h69 Center , LOADING

While (tn3270Window = "0x0") {
	tn3270Window := WinExist("ahk_exe tn3270.exe")
	GuiControl,Text,vCurrentAction,Waiting on tn3270.exe
	Sleep 200
	GuiControl,,vProgress,+0.5
}

GuiControl,,vProgress,0

While (PaybackWindow = "0x0") {
	PaybackWindow := WinExist("ahk_exe Payback.exe")
	GuiControl,Text,vCurrentAction,Waiting on Payback.exe
	Sleep 200
	GuiControl,,vProgress,+1
}
GuiControl,,vProgress,0

While (OutlookWindow = "0x0") {
	OutlookWindow := WinExist("ahk_exe OUTLOOK.EXE")
	GuiControl,Text,vCurrentAction,Waiting on Outlook.exe
	Sleep 200
	GuiControl,,vProgress,+1
}

GuiControl,,vProgress,0

While (TRIMWindow = "0x0") {
	TRIMWindow := WinExist("ahk_exe TRIM.exe")
	GuiControl,Text,vCurrentAction,Waiting on TRIM.exe
	Sleep 200
	GuiControl,,vProgress,+0.5
}

GuiControl,,vProgress,0



MsgBox % "Done."
ExitApp
Return


Move() {
PostMessage, 0xA1, 2
}

Application_Control_Workaround(_Path) {
	Check := FALSE
	Sendinput, {LWin down}{r}{LWin up} 
	WinWait, Run
	ControlSetText, Edit1, %_Path%, Run
	WinWaitClose, Run,, % 1/4
	ControlClick, Button2, Run
}

