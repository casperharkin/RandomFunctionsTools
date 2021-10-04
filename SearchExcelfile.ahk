#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global Temp
Gui, Margin, 10, 10
Gui, Font, s8, Verdana
Gui, Add, Edit, Section hwndPathEdit w210 Disabled
Gui, Add, Button, ys-1 gOpen w50, Open
Gui, Add, DDL, ys w130 hwndSheetsDDL vSheet Disabled
Gui, Add, Text, Section xm w130, Vendor
Gui, Add, Text, ys wp, Email
Gui, Add, Text, ys wp, Phone
Gui, Add, Edit, Section xm wp vVendor , Vendor XYZ
Gui, Add, Edit, ys wp ReadOnly vEmail
Gui, Add, Edit, ys wp ReadOnly vPhone
Gui, Add, Button, xm Section wp gSearch hwndSearch  Disabled, Search
Gui, Add, Button, ys wp gCopy hwndCopyEmail Disabled, Copy Email
Gui, Add, Button, ys wp gCopy hwndCopyPhone Disabled, Copy Phone
Gui, Show,, Relative Cell Lookup
Return

Open:
	FileSelectFile, Path, 3, , Select an Excel Workbook, Excel Workbooks (*.xlsx; *.xls)
	
	If ErrorLevel
		Return

	Temp := ComObjCreate("Excel.Application") 
	Temp_Workbook := Temp.Workbooks.Open(Path) 
	Temp.Visible := false

    Sheets := ""
    For Sheet in Temp.Worksheets  
        Sheets .= Sheet.Name "|"

    GuiControl,, % SheetsDDL, % "|"
    GuiControl,, % SheetsDDL, % Rtrim(Sheets, "|")
    GuiControl, Choose, % SheetsDDL, 1 

    SplitPath, Path, FileName
    GuiControl,, % PathEdit, % FileName
    GuiControl, Enable, % Search
	GuiControl, +Default, % Search
    GuiControl, Enable, % SheetsDDL
Return

Search:
	gui, submit, nohide

    If !(Path) OR !(Vendor)
        Return

    GuiControl, Disable, % CopyPhone
    GuiControl, Disable, % CopyEmail
    GuiControl, Text, Email, % GetCellValue(Vendor,"E:E",Sheet,0,1)
    GuiControl, Text, Phone, % GetCellValue(Vendor,"E:E",Sheet,0,2)
	GuiControl, Enable, % CopyPhone
	GuiControl, Enable, % CopyEmail
Return

Copy:
	gui, submit, nohide
	Res := SubStr(A_GuiControl,6,5)
	Clipboard := % %Res%
    ToolTip % "Copied " Res "!"
    Sleep 1000
    ToolTip
Return

GuiClose:
    Temp.Quit
    ExitApp
Return

GetCellValue(Find, Selection, Sheet, offset_Row, offset_Col)
{
	Temp.Sheets(Sheet).Activate
    return Temp.Range(Temp.activesheet.Range(Selection).Find(Find).Offset(offset_Row, offset_Col).address).Value
}