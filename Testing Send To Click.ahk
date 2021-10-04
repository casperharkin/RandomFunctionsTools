#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

		SetBatchLInes, -1
		WinWait, ahk_class #32768
		SendMessage, 0x1E1, 0, 0		; MN_GETHMENU
		hMenu := ErrorLevel
		sContents := GetMenu(hMenu)
		WinWaitClose
		
		MsgBox, % "Contents of SubMenu: `n" sContents
		
		
		GetMenu(hMenu)
		{
			Loop, % DllCall("GetMenuItemCount", "Uint", hMenu)
			{
				idx := A_Index - 1
				idn := DllCall("GetMenuItemID", "Uint", hMenu, "int", idx)
				nSize++ := DllCall("GetMenuString", "Uint", hMenu, "int", idx, "Uint", 0, "int", 0, "Uint", 0x400)
				VarSetCapacity(sString, nSize)
				DllCall("GetMenuString", "Uint", hMenu, "int", idx, "str", sString, "int", nSize, "Uint", 0x400)	;MF_BYPOSITION
		
				If (idn = -1) && (hSubMenu := DllCall("GetSubMenu", "Uint", hMenu, "int", idx)) && (sString = "Se&nd to") 
				{
				 	PostMessage, 0x1ED, % idx, 0,, ahk_class #32768
					sleep 1000
		
						Loop, % DllCall("GetMenuItemCount", "Uint", hSubMenu)
						{
								idx := A_Index - 1
								idn := DllCall("GetMenuItemID", "Uint", hSubMenu, "int", idx)
								nSize2++ := DllCall("GetMenuString", "Uint", hSubMenu, "int", idx, "Uint", 0, "int", 0, "Uint", 0x400)
								VarSetCapacity(sString, nSize2)
								DllCall("GetMenuString", "Uint", hSubMenu, "int", idx, "str", sString, "int", nSize, "Uint", 0x400)	;MF_BYPOSITION
								sContents .= sString "`n"
			
								If InStr(sString, "Desktop")
								{
									PostMessage, 0x1F1, % idx, 0,, ahk_class #32768
								}
			
						}
				}
			}
			Return	sContents
		}