#Persistent
OnClipboardChange("ClipChanged")
Exit

ClipChanged(Type) 
{
Critical
Sleep 1000
ClipboardCheck := Trim(Clipboard," ")
	IF (Strlen(ClipboardCheck) = "9")
		IF (SubStr(ClipboardCheck, 4, 1) = " ") or (SubStr(ClipboardCheck, 4, 1) = "-")
			Clipboard := StrReplace(StrReplace(ClipboardCheck, "-", A_Space), " ")
}