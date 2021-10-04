#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Gui, +AlwaysOnTop
Gui, Font, s10, Verdana
Gui, Add, GroupBox, x15 y15 w550 h50 cBlue vGroupA, Select Button Type
Gui, Add, Radio, x22 y40 vCheck1, ButtonOne
Gui, Add, Radio, x120 y40 vCheck2, ButtonTwo
Gui, Add, Text, x390 y82, Source (Excel File)
Gui, Add, Edit, x85 y80 w300 h23 +Disabled vExcelFile, %ExcelFile%
Gui, Add, Button, x17 y78 gBrowseExcel, &Browse
Gui, Add, Button, x17 y285 Default, Begin
Gui, Add, Button, Default gGuiClose, Cancel
Gui, Add, StatusBar,,
gui show

return

BrowseExcel:
Gui, +OwnDialogs
FileSelectFile, ExcelFile, 1, %LastScriptDir%, Excel Documents (\*.xlsx)
GuiControl,, ExcelFile, %ExcelFile%
return


GuiClose:
ExitApp
return

ButtonBegin() {
Global
	gui, Submit, nohide
	Xl := ComObjCreate("Excel.Application")
	Xl.Visible := True
	Xl_Workbook := Xl.Workbooks.Open(ExcelFile) 
	
	gui, Hide
	if (Check1 = "1") and (Check2 = "0") {
	Xl.Range("Q5:Q500").copy
	MsgBox % Clipboard 
	}
	
	Else if (Check2 = "1") and (Check1 = "0") {
	Xl.Range("O5:O500").copy
	MsgBox % Clipboard 
	}
gui, show
Xl.Quit()
}

Esc::ExitApp