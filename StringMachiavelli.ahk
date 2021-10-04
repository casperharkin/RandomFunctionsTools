#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

MsgBox % Clipboard := StrMan.Trim("   tes!@ngSTUFF123    ")
Exit

Class StrMan 
{
	Strip(String) {
	return RegExReplace(String, "[^0-9.]")
	}

	Title(string) {
	return % Format("{:T}", String)
	}

	Upper(string) {
	return % Format("{:U}", String)
	}

	Lower(string) {
	return % Format("{:L}", String)
	}

	Trim(String) {
	return 	string := regexreplace(string := regexreplace(string, "\s+$"), "^\s+") 
	}

	Wash(String) {
	return string = %string%
	}
}