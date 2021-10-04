#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; make CapsLock Always Stay Off
SetCapsLockState, AlwaysOff
Return

; Toggle CapsState between True and False
CapsLock::CapsState := !CapsState

; Here is where you can set your shortcuts or functions to run when
; CapsState is True
#if CapsState = True

	a::b

	g::ExampleFunc(CapsState)

	h::
	Send Hello, World. 
	Return

	j:: 
	if WinActive("ahk_class Notepad")
		{
			Send, Only Works in Notepad
		}
	Return

#if

ExampleFunc(CapsState)
{
	MsgBox % "CapsState is " (CapsState=1?"True":"False")
}
