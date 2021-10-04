	#Persistent
	Global pCallBack
	Event_Menu_Start := "0x3"
	Event_Menu_End := "0x3"
	
	pCallback := RegisterCallback("WinEvent")
	Acc_SetWinEventHook(Event_Menu_Start, Event_Menu_End, pCallBack)
	Return
	
	    WinEvent(hHook, event, hWnd, idObject, idChild, eventThread, eventTime) {
		WinGetClass, Class, % "AHK_ID 0x" Format("{:X}",hWnd)
		If (Class = "Notepad") {
				MsgBox % "Notepad Has Been Opened`n`n`n" event
				DllCall( "UnhookWinEvent", Uint, hHook)
			}
		}
