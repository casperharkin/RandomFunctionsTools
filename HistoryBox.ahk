#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Build_PIPS_GUI()
HistoryArray := []
Hor := "1440"
Ver := "26"
Count := 0
Gui Show, x1442 y46 w1440 h26, 
Return
Load:
gui, submit, nohide

for each, value in HistoryArray
	if (ComboBox = value)
		RemovedValue := HistoryArray.RemoveAt(A_Index)

HistoryArray.Push(ComboBox)

Loop % HistoryArray.Length()
	 BuildHistoryArrayDropdown .= "|" HistoryArray[A_Index] 

guicontrol,, ComboBox, % BuildHistoryArrayDropdown . "||"
GuiControl, Move, ComboBox, h300
BuildHistoryArrayDropdown := ""



;WinActivate Mochasoft - mainframe.nt.gov.au
;SendInput, {F4}1.2.1{Enter}%ComboBox%{Enter}
Return

Build_PIPS_GUI()
{
	global
	Gui, 2:New, +LastFound -Caption +AlwaysOnTop
	gui, Margin, 0, 0
	Gui, Add, Button,  y3 h20 vpay gPIPS_Menu,  Payslip
	Gui, Add, Button,  y3 h20 vptrc gPIPS_Menu, PTR's
	Gui, Add, Button,  y3 h20 vESUP gPIPS_Menu, Super
	Gui, Add, Button,  y3 h20 vEADD gPIPS_Menu, Address 
	Gui, Add, Button,  y3 h20 vEPER gPIPS_Menu, Payee
	Gui, Add, Button,  y3 h20 vall gPIPS_Menu, Allowances
	Gui, Add, Button,  y3 h20 vLEV gPIPS_Menu, Leave
	Gui, font, Bold
	Gui, Add, Text, x+5 y6 h15, Load AGS No.: 
	Gui, font, 
	Gui, Add, ComboBox, x+5 y3 w150  vComboBox, 
	Gui, Add, Button, x+5  y3  h20 Default gLoad, Load
  return
}

PIPS_Menu()
{
WinActivate Mochasoft - mainframe.nt.gov.au
SendInput, {F4}%A_GuiControl%{Enter}{F8}
}
