#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

MsgBox % TimeUntilTime(EndTime := "16:21:00")
Exit


TimeUntilTime(EndTime := "16:21:00") {
FormatTime, StartTime, T12, Time
StartObj := StrSplit(StartTime, ":"), EndObj := StrSplit(EndTime, ":")
If (StartObj[2] > EndObj[2])
	EndObj[1] := EndObj[1]-1, EndObj[2] := EndObj[2]+60
EndObj[2] := EndObj[2] - StartObj[2], EndObj[1] := EndObj[1] - StartObj[1]
Return EndObj[1] " hours and " EndObj[2] " minutes"
}
