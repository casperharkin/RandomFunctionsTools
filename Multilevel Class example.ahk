#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Instance := New _Base_(15)
Instance.Test()
Exit

Class _Base_ {

	__New(Data) {
		Msgbox % "Data: " Data
		This.Data := Data
		This.Add()
	}
	
	Add() {
		This.Data += 4 
		Msgbox % "Data: " This.Data
		_Base_.base := Level 
	}

}

	class Level extends _Base_ {
	
		Test() {
			Msgbox % "Nested Class can see: " This.Data
		}
}

