#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;############################################################
;############## Formating Example for Menus, ################
;######## eg. Menu Name | Item 1, Item 2, Item 3 ############
;############################################################

Raw_Menus = 
(
File|New,Open...,Save,Save As...,,Page Setup...,Print...,,Exit
Edit|Undo,,Cut,Copy,Paste,Delete
View|Font,Word Wrap
Setting|Titlecase,Uppercase,Lowercase
Help|About,Help
)

Array := StrSplit(Raw_Menus, "`n")

Loop % Array.Length() {
	MenuTitle := StrSplit(Array[A_Index], "|")
	ArrayOrder .= MenuTitle[1] "`n"
}

MsgBox % ArrayOrder 
	