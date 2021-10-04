#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
q::

Inputbox, ReplaceText, What to Replace:, What Char did you want to replace?,,240,130,,,,,  
r := QuickReplace(ReplaceText)

Return

QuickReplace(Replacements) 
{
	Replacements_Array := StrSplit(Replacements, ",","`t") 
	
		Loop % Replacements_Array.Length() 
		{
			If InStr(Replacements_Array[A_Index], "A_") {
				Replacements := Replacements_Array[A_Index]
				Replacements := %Replacements%
				Clipboard := StrReplace(Clipboard, Replacements)
			}
			Else If InStr(Replacements_Array[A_Index], "``n")
				Clipboard := StrReplace(Clipboard, "`n`r")
			Else If InStr(Replacements_Array[A_Index], "Comma")
				Clipboard := StrReplace(Clipboard, ",")
			Else
				Clipboard := StrReplace(Clipboard, Replacements_Array[A_Index])
		}
}

