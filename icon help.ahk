#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#Persistent

SetTimer, Check, 500

Exit

q::Suspend, Toggle
w::Pause


Check() {
if (A_IsSuspended)
	Menu, Tray, Icon , C:\Users\babb\Desktop\New folder\Icon2.ico
Else
	Menu, Tray, Icon , C:\Users\babb\Desktop\New folder\Icon3.ico
}
