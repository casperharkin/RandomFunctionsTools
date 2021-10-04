HistoryArray := {}
Build_PIPS_GUI()
Gui, 2: Show
Return

PIPS_Menu()
{
WinActivate Mochasoft - mainframe.nt.gov.au
SendInput, {F4}%A_GuiControl%{Enter}{F8}
}


Build_PIPS_GUI()
{
	global
	Gui, 2:New, +LastFound -Caption +AlwaysOnTop
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
	Gui, Add, ComboBox, x+5 y3 w250 h15 vComboBox,
	Gui, Add, Button, x+5  y3  h20 Default gPreLoad   , Load
  return
}

PreLoad:
gui, submit, nohide

If InStr(ComboBox," - ")
{
Array := StrSplit(ComboBox," - ")
ComboBox := Array.1

}


winactivate, Mochasoft
sendinput, {F4}
sleep 1000
Load:

clipboard := ""
winactivate, Mochasoft
sendinput, {Alt}ES
sendinput, ^c
ClipWait, 2
if ErrorLevel
	MsgBox, The attempt to copy text onto the clipboard failed.

Array := StrSplit(Clipboard, "`n")

if (substr(Array[3],33,16) = "M A I N  M E N U" )
{
	winactivate, Mochasoft
	sendinput, 1.2.1
	sendinput,{enter}
	sendinput, %ComboBox%
	sendinput, {enter}
	sleep 1000
	Goto Load
}

if (substr(Array[20],16,40) = "DO YOU WISH TO CONTINUE WITH THE DISPLAY")
{
	winactivate, Mochasoft
	sendinput, {enter}
	sleep 1000
	Goto Load
}

if (substr(Array[2],3,7) = "(1.2.1)")
{
	Array :=
	winactivate, Mochasoft
	sendinput, {Alt}ES
	sendinput, ^c
	ClipWait, 2
	if ErrorLevel
		MsgBox, The attempt to copy text onto the clipboard failed.

	Array := StrSplit(Clipboard, "`n")
	vName := Change_String(substr(Array[6],22,23),"Clean") . " , " Change_String(substr(Array[7],22,45),"Clean")	
}

AGSnName := ComboBox . " - " . vName

HistoryArray.Push(AGSnName)

Loop % HistoryArray.Length()
	 BuildHistoryArrayDropdown .= "|" HistoryArray[A_Index]

guicontrol,, ComboBox, % BuildHistoryArrayDropdown . "||"
GuiControl, Move, ComboBox, h300
BuildHistoryArrayDropdown := ""










return

If InStr(ComboBox," - ")
{
Array := StrSplit(ComboBox," - ")
ComboBox := Array.1
}
guicontrol, Text, ComboBox, % ComboBox


HistoryArray.Push(ComboBox)
FormatTime, time, A_now, hh:mm tt
Loop % HistoryArray.Length()
	 BuildHistoryArrayDropdown .= "|" HistoryArray[A_Index] " - " vName

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

