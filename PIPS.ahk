#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Build_PIPS_GUI()
Exit

Build_PIPS_GUI()
{
	global
	Gui, 2:New, +LastFound +Caption +AlwaysOnTop
	gui, Margin, 0, 0
	Gui, Color, 0xF3F3F3
	Gui, Add, Button,  y3 h20 vpay gPIPS_Menu,  Payslip
	Gui, Add, Button,  y3 h20 vptrc gPIPS_Menu, PTR's
	Gui, Add, Button,  y3 h20 vESUP gPIPS_Menu, Super
	Gui, Add, Button,  y3 h20 vEADD gPIPS_Menu, Address 
	Gui, Add, Button,  y3 h20 vEPER gPIPS_Menu, Payee
	Gui, Add, Button,  y3  h20 vall gPIPS_Menu, Allowances
	Gui, Add, Button,  y3  h20 vLEV gPIPS_Menu, Leave
	Gui, font, Bold
	Gui, Add, Text, x+5 y6 h15, Load AGS No.: 
	Gui, font, 
	Gui, Add, ComboBox, x+5 y3 w150 h15 vComboBox,
	Gui, Add, Button, x+5  y3  h20 Default gLoad   , Load

	Gui 2:Show, x0 y22, Pips toolbar
  
}

PIPS_Menu()
{
WinActivate Mochasoft - mainframe.nt.gov.au
SendInput, {F4}

Check_For_Time_Out := "|<>*48$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzsDw7kDUDz00TllztnznzTzLzjjjnyztwzszjz9zrrrzzDxzTwDrzizvvvzzbwzbybvzrTxxxzznyTnzNxznbyyyzzvzDxzgyzvvzzTzztzbyzrDTxwzzjzz1znzTvrjwyTzrzzwTtzjxtryzjzvzzzbwzryyPz03zxzzznyTvzTBzDxzyzzzxzDtzjmzjyzzTzzyzbwzrwTbzDzjzzyTvyTvyDnzrzrzvzDwyTxzbvzvzvzwSDzCTs7nkDUT07zUTzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"

if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, Check_For_Time_Out)
	{
		Send {Enter 3}
		Sleep 2000
	}


SendInput, {F4}{Enter}{Enter}{Enter}%A_GuiControl%{Enter}{F8}
}


Load:
gui, submit, nohide
FormatTime, time, A_now, hh:mm tt
IniWrite, % ComboBox . " @ " time, % "C:\_Umbra Sector\_PDR Toolbar\Settings.ini", History_PIPS, % ComboBox










If InStr(ComboBox,"@")
{
Array := StrSplit(ComboBox," @ ")
ComboBox := Array.1
}
guicontrol, Text, ComboBox, % ComboBox


HistoryArray.Push(ComboBox)
FormatTime, time, A_now, hh:mm tt
Loop % HistoryArray.Length()
	 BuildHistoryArrayDropdown .= "|" HistoryArray[A_Index] " @ " time

guicontrol,, ComboBox, % BuildHistoryArrayDropdown . "||"
GuiControl, Move, ComboBox, h300
BuildHistoryArrayDropdown := ""

If InStr(ComboBox,"@")
{
Array := StrSplit(ComboBox," @ ")
ComboBox := Array.1
}
guicontrol, Text, ComboBox, % ComboBox	
WinActivate Mochasoft - mainframe.nt.gov.au
SendInput, {F4}1.2.1{Enter}%ComboBox%{Enter}
Return