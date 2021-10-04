#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global History
HistoryArray := []

Gui, Add, Text,, History:
Gui, Add, combobox, gComboboxSub vcombobox

Gui, Add, Text,, Name:
Gui, Add, Edit, vName
Gui, Add, Text,, Reference:
Gui, Add, Edit, vReference
Gui, Add, Button, gSubmit, Okay
gui, Show,

Return

Submit()
{
Global
Gui, Submit, Nohide

SkipObjCreate := False

for each, value in HistoryArray
	if (HistoryArray[A_Index].Reference = Reference)
		SkipObjCreate := True

if (SkipObjCreate != True)
{
	Obj := {}
	Obj.Reference := Reference
	Obj.Name := Name
	HistoryArray.Push(Obj)
	Obj := 
}
BuildHistoryArrayDropdown()
}

ComboboxSub()
{
Global
Gui, Submit, Nohide
ComboBoxVar := ComboBox
for each, value in HistoryArray
	for each, value in HistoryArray[A_Index]
	{
		Array := StrSplit(ComboBox," - ")
		If (HistoryArray[A_Index].Reference = Array.1)
		{
			GuiControl,text,Name, % HistoryArray[A_Index].Name
			GuiControl,text,Reference, % HistoryArray[A_Index].Reference
		}
	}
}

BuildHistoryArrayDropdown()
{
Global
BuildHistoryArrayDropdown := 
GuiControl,, ComboBox, % "|"

for each, value in HistoryArray
	BuildHistoryArrayDropdown .= " | " HistoryArray[A_Index].Reference " - " HistoryArray[A_Index].Name
			
GuiControl,, ComboBox, %  "|" BuildHistoryArrayDropdown
GuiControl, Move, ComboBox, h300
}
