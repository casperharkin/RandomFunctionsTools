#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;based on:
;GUIs via DllCall: get/set internal/external control text - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=6&t=40514
;context menu window messages: focus/invoke item - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=5&t=39209

q:: ;invoke menu item in context menu that matches string
;e.g. Notepad right-click menu, 'Paste' menu item
SendMessage, 0x1E1,,,, ahk_class #32768 ;MN_GETHMENU := 0x1E1
hMenu := ErrorLevel

vNeedle := "Sen&d to"
Loop, % DllCall("user32\GetMenuItemCount", Ptr,hMenu)
{
	vIndex := A_Index-1
	vID := DllCall("user32\GetMenuItemID", Ptr,hMenu, Int,vIndex, UInt)
	if (vID = 0) || (vID = 0xFFFFFFFF) ;-1
		continue
	vChars := DllCall("user32\GetMenuString", Ptr,hMenu, UInt,vIndex, Ptr,0, Int,0, UInt,0x400) + 1

	VarSetCapacity(vText, vChars << !!A_IsUnicode)
	DllCall("user32\GetMenuString", Ptr,hMenu, UInt,vIndex, Str,vText, Int,vChars, UInt,0x400) ;MF_BYPOSITION := 0x400


	if (StrReplace(vText, "&") = vNeedle)
	{
		PostMessage, 0x1F1, % vIndex, 0,, ahk_class #32768 ;MN_DBLCLK := 0x1F1
		;PostMessage, 0x1E5, % vIndex, 0,, ahk_class #32768 ;MN_DBLCLK := 0x1F1
		
		break
	}
}
MsgBox % sContents 
return

GetMenu(hMenu)
{
	Loop, % DllCall("GetMenuItemCount", "Uint", hMenu)
	{
		idx := A_Index - 1
		idn := DllCall("GetMenuItemID", "Uint", hMenu, "int", idx)
		nSize++ := DllCall("GetMenuString", "Uint", hMenu, "int", idx, "Uint", 0, "int", 0, "Uint", 0x400)
		VarSetCapacity(sString, nSize)
		DllCall("GetMenuString", "Uint", hMenu, "int", idx, "str", sString, "int", nSize, "Uint", 0x400)	;MF_BYPOSITION
		If !sString
		   sString := "---------------------------------------"
		sContents .= idx . " : " . idn . A_Tab . A_Tab . sString . "`n"
		If (idn = -1) && (hSubMenu := DllCall("GetSubMenu", "Uint", hMenu, "int", idx))
		   sContents .= GetMenu(hSubMenu)
	}
	Return	sContents
}