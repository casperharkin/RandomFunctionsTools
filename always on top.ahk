#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

 
q::WinSet, AlwaysOnTop, Off, A

Exit ; End of Auto Execute Section

#d::

Toggle := !Toggle 

if (Toggle) {

	WindowsOnTop := []

	WinGet, ListTitle, List
	
	loop % ListTitle
	{
	    WinGetTitle, WinTitle, % "AHK_ID " ListTitle%A_index%
		  	If (WinTitle != "")	{
				WinGet, ES, ExStyle, % WinTitle 
	
				If ("0x" . SubStr(ES,0) = 0x8)
					WindowsOnTop.Push(WinTitle)
			}
	}

	Send #d

}

if (!Toggle) {

	Send #d

	WinGet, ListTitle, List
	
	loop % ListTitle
	{
	    WinGetTitle, WinTitle, % "AHK_ID " ListTitle%A_index%
		  	If (WinTitle != "")	{
	
				If (Check(WindowsOnTop,WinTitle) := -1) {
					WinSet, AlwaysOnTop, On, WinTitle
				}
				Else
					WinSet, AlwaysOnTop, Off, WinTitle
			}
	}
}
Return

Check(WindowsOnTop, WinTitle) {

For Each, item in WindowsOnTop
	if (WindowsOnTop[Each] = WinTitle)
		Return -1
}

