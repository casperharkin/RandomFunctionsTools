#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



MsgBox % New ClassTest 
MsgBox % ClassTest.ASD()
Exit

Class Test 
{
	__new()
	{
		Local R := "Test"
		Return R
	}

	ASD()
	{
		Return "First"
	}
}

class ClassTest extends Test 
{
	__new()
	{
		Local C := "ClassTest"
		
		Return C " " 
	}




}