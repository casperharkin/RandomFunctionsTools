#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ArrayTeam1 := []
ArrayTeam2 := []
ArrayTeam3 := []
ArrayTeam4 := []

ArrayNameGroups := []
ArrayNameGroups.Push("1. Richard")
ArrayNameGroups.Push("4. Barret")
ArrayNameGroups.Push("1. Peter")
ArrayNameGroups.Push("2. Alex")
ArrayNameGroups.Push("1. Andrew")
ArrayNameGroups.Push("2. Edward")
ArrayNameGroups.Push("4. Joseph")
ArrayNameGroups.Push("3. Mathew")

Loop % ArrayNameGroups.Length()
{
TeamNo := SubStr(ArrayNameGroups[A_Index],1,1)
ArrayTeam%TeamNo%.Push(ArrayNameGroups[A_Index])
}
