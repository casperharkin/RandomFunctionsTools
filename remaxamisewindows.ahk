#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

q::
WinGet, OutputVar, List
Loop % OutputVar
{
	WinGet, Name, ProcessName, % "AHK_ID " OutputVar%A_Index%
	WinGet, MinMax, MinMax, % "AHK_ID " OutputVar%A_Index%
	If (MinMax = 1) and (Name != "ApplicationFrameHost.exe") {
		WinRestore, % "AHK_ID " value
		WinMaximize, % "AHK_ID " value
	}
}