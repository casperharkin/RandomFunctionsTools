#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


ConnectToWorkbook(xl := ComObjActive("Excel.Application"))
Exit


ConnectToWorkbook(xl){

if   !ComObjType(ComObjActive("Excel.Application"), "Name") ;If In Edit Mode
	msgbox Edit Mode
}

