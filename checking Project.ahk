#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Global Client_Info := {}

q::
;Gather_PaidDueDiff_Data()
;
;MsgBox % "Open Workbook."
;
;Check_Data_Against_Workbook()
;
;MsgBox % "Open Salary ePOD Record."

Check_Data_Against_ePOD()

;For Each, Item in Client_Info {
;		MsgBox % Each " = $" Item 
;}
Exit

Check_Data_Against_ePOD(){


		WinGet, hWnd, ID, ahk_exe Payback.exe

		oAcc := Acc_Get("Object", "4.1.4.2.4", vChildID, "ahk_id " hWnd)
		Client_Info.Person_Cost_Code := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.2.4", vChildID, "ahk_id " hWnd)
		Client_Info.Date_Overpayment_Detected := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.4.4", vChildID, "ahk_id " hWnd)
		Client_Info.FBT_Date := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.6.4", vChildID, "ahk_id " hWnd)
		Client_Info.EntCode := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.8.4", vChildID, "ahk_id " hWnd)
		Client_Info.RecType := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.11.4", vChildID, "ahk_id " hWnd)
		Client_Info.Amount := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.13.4", vChildID, "ahk_id " hWnd)
		Client_Info.CostCode := oAcc.accValue(vChildID)

		msgbox % Client_Info.Date_Overpayment_Detected
		msgbox % Client_Info.FBT_Date
		msgbox % Client_Info.EntCode
		msgbox % Client_Info.RecType
		msgbox % Client_Info.Amount
		msgbox % Client_Info.CostCode

}

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~ FUNCS n Stuff ~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


GetCellValue(Find,offset_X,offset_Y) {
	Temp := ComObjActive("Excel.Application")
	Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
	return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
}

Gather_PaidDueDiff_Data(){
	IniRead, Current_Financial_Year, % "C:\Users\babb\Desktop\Workbook Class Settings.ini", General, Current_Financial_Year
	Xl := ComObjActive("Excel.Application")
	ComObjError(false)
	
	For sheet in Xl.Worksheets
		if InStr(Sheet.Name, "Year Summary") 
			Xl.Sheets(Sheet.Name).activate

	if (Financial_Year := GetCellValue("Financial", 0, 1) = Current_Financial_Year) {
		Financial_Year := RegExReplace(GetCellValue("Current", 0, 1), "/", "_")
		Client_Info.Tax_Amount := GetCellValue("TOTALS", 0, 1)
		Client_Info.Nett_Amount := GetCellValue("TOTALS", 0, 2)
		Client_Info.SalarySac_Amount := GetCellValue("TOTALS", 0, 3)
		Client_Info.Deductions_Amount := GetCellValue("TOTALS", 0, 4)
		Client_Info.Super_Amount := GetCellValue("TOTALS", 0, 6)
		
		WinActivate, Excel
		Xl.DisplayAlerts := (False)
		Xl.ActiveSheet.Unprotect
;		Xl.Workbook.Close(0) 
;		Xl.quit()
	}
	
	if (Financial_Year := GetCellValue("Financial", 0, 1) != Current_Financial_Year)
	{
		if (Client_Info.Gross_Amount != "") {
			Client_Info.Gross_Amount := Client_Info.Gross_Amount + GetCellValue("TOTALS", 0, 2)
			Client_Info.SalarySac_Amount_Gross := Client_Info.SalarySac_Amount_Gross + GetCellValue("TOTALS", 0, 3)
			Client_Info.Previous_Fin_Year_Super := Client_Info.Previous_Fin_Year_Super + GetCellValue("TOTALS", 0, 5)
		}
		
		else if (Client_Info.Gross_Amount = "") {
			Client_Info.Gross_Amount := GetCellValue("TOTALS", 0, 2)
			Client_Info.SalarySac_Amount_Gross := GetCellValue("TOTALS", 0, 3)
			Client_Info.Previous_Fin_Year_Super := GetCellValue("TOTALS", 0, 5)
		}
		
		WinActivate, Excel
		Xl.DisplayAlerts := (False)
		Xl.ActiveSheet.Unprotect
;		Xl.Workbook.Close(0) 
;		Xl.quit()
	}
}

Check_Data_Against_Workbook(){

	Xl := ComObjActive("Excel.Application")
	ComObjError(false)
	
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;~~~~~~~~~~~~~~~~~~ Current Financial Year ~~~~~~~~~~~~~~~~~
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	MsgBox % "Deductions_Amount:`n`n" Client_Info.Deductions_Amount " vs " GetCellValue("Deductions Diff", 1, 0)
	MsgBox % "Tax_Amount:`n`n" Client_Info.Tax_Amount " vs " GetCellValue("Tax Diff", 1, 0)
	MsgBox % "Nett_Amount:`n`n" Client_Info.Nett_Amount " vs " GetCellValue("Nett Diff", 1, 0)
	MsgBox % "SalarySac_Amount:`n`n" Client_Info.SalarySac_Amount " vs " GetCellValue("Salary Sacrifice Contribution", 1, 0)
	MsgBox % "Super_Amount:`n`n" Client_Info.Super_Amount " vs " GetCellValue("Fund Name", 2, 3)

	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;~~~~~~~~~~~~~~~~~ Previous Financial Year ~~~~~~~~~~~~~~~~~
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	MsgBox % "Gross_Amount:`n`n" Client_Info.Gross_Amount " vs " GetCellValue("Gross Diff", 1, 0)
	MsgBox % "SalarySac_Amount_Gross:`n`n" Client_Info.SalarySac_Amount_Gross " vs " GetCellValue("Gross Diff", 1, 3)
	MsgBox % "Previous_Fin_Year_Super:`n`n" Client_Info.Previous_Fin_Year_Super " vs " GetCellValue("Gross Diff", 1, 3)
}

