#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
AllowanceArray := []
AGS := "83240834"
Return

#c::
Clipboard := 
Send, {Control down}{c}{Control up}
ClipWait, 2

temp := StrSplit(Clipboard,"`n")

Loop % Temp.Length()
	AllowanceArray.Push(temp[A_Index])

Clipboard := 
Return

#v::

Loop % AllowanceArray.Length()
{
If (A_Index = 1)
	{
	Sleep 200
	winactivate, Mochasoft
	Sleep 200
	sendinput, {F4}All{Enter}{F8}
	}

Needle := AllowanceArray[A_Index]

Haystack := PIPSScreenDump()

loop, 8
{
	;If InStr(Haystack[A_Index+8], Needle)
		MsgBox % Haystack[A_Index+8]

}
}
Return

PIPSScreenDump()
{
	Sleep 800
	Clipboard := ""

	winactivate, Mochasoft
	sendinput, {Alt}ES
	sendinput, ^c
	
	ClipWait, 4
	if ErrorLevel
		MsgBox, The attempt to copy text onto the clipboard failed.
	
	Array := StrSplit(Clipboard, "`n")
	Sleep 800
	Return Array
}

