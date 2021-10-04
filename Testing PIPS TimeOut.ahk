#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

PIPS_Menu()

Exit


PIPS_Menu(){
	WinActivate Mochasoft - mainframe.nt.gov.au
	OutputVar := "86386193"

	SendInput, {Enter}
	Sleep 1000
	if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, Check_For_Time_Out := "|<>*48$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzsDw7kDUDz00TllztnznzTzLzjjjnyztwzszjz9zrrrzzDxzTwDrzizvvvzzbwzbybvzrTxxxzznyTnzNxznbyyyzzvzDxzgyzvvzzTzztzbyzrDTxwzzjzz1znzTvrjwyTzrzzwTtzjxtryzjzvzzzbwzryyPz03zxzzznyTvzTBzDxzyzzzxzDtzjmzjyzzTzzyzbwzrwTbzDzjzzyTvyTvyDnzrzrzvzDwyTxzbvzvzvzwSDzCTs7nkDUT07zUTzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk") {
		SendInput, {Enter}{Enter}{Enter}
	}
	
	if (A_GuiControl = "Load")
		SendInput, {F4}1.2.1{Enter}%OutputVar%{Enter}
	else
		SendInput, {F4}{Enter}{Enter}{Enter}%A_GuiControl%{Enter}{F8}	

	
}
	