#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent
OnClipboardChange("ClipChanged")
return

ClipChanged(Type) 
{
ClipboardCheck := Trim(Clipboard," ")
	IF (Strlen(ClipboardCheck) = "9")
		IF (SubStr(ClipboardCheck, 4, 1) = " ") or (SubStr(ClipboardCheck, 4, 1) = "-")
			Clipboard := StrReplace(StrReplace(ClipboardCheck, "-", A_Space), " ")
}