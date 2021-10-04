#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Xl := ComObjActive("Excel.Application")
ComObjError(false)


Loop % Xl.ActiveSheet.UsedRange.Rows.Count
{

	CurrentCell := GetCellAddy("A List",A_Index,0)
	
	MsgBox % "Cell Address: " CurrentCell "`nCell Height: " Xl.ActiveSheet.Range(CurrentCell).RowHeight

}


	GetCellValue(Find,offset_X,offset_Y)
	{
		Global
		Temp := ComObjActive("Excel.Application")
		ComObjError(false)
		Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
		return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
	}

	GetCellAddy(Find,offset_X,offset_Y)
	{
		Global
		Temp := ComObjActive("Excel.Application")
		ComObjError(false)
		Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
		return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).address
	}
	


