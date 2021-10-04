#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	
	WindowsOnTop := []
	
	#d::
	
	if (Flag := -1)
		{
			Send #d
			
		    WinGet, ListTitle, List
		
		    loop % ListTitle
		    {
		        WinGetTitle, WinTitle, % "AHK_ID " ListTitle%A_index%
		            If (WinTitle != "") {
		                WinGet, ES, ExStyle, % WinTitle 
		
		                If ("0x" . SubStr(ES,0) = 0x8) {
							WinSet, AlwaysOnTop, Off, % WinTitle
						}
		            }
		    }
	
			for each, item in WindowsOnTop {
				WinActivate, % WindowsOnTop[each]
				WinSet, AlwaysOnTop, On, % WindowsOnTop[each]
			}
			
			Flag := 0
		}
	
	
	if (Flag != -1)
		{
		    WinGet, ListTitle, List
		
		    loop % ListTitle
		    {
		        WinGetTitle, WinTitle, % "AHK_ID " ListTitle%A_index%
		            If (WinTitle != "") {
		                WinGet, ES, ExStyle, % WinTitle 
		
		                If ("0x" . SubStr(ES,0) = 0x8) {
		                    WindowsOnTop.Push(WinTitle)
						}
		            }
		    }
		
			Flag := -1
			Send #d
		}
	
