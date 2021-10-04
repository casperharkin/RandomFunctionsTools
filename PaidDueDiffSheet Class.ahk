#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Global Xl



	Active := New PaidDueDiffSheet()
	Active.FinancialYear()
	Active.PaymentSummaryAmendment()
	Active.PrintToPDF() 

Return

Class PaidDueDiffSheet {

	__New() {

	Xl := ComObjActive("Excel.Application")
	ComObjError(false)
	
	For sheet in Xl.Worksheets
	   if InStr(Sheet.Name, "Year Summary") 
				Xl.Sheets(Sheet.Name).activate
	}
	
	FinancialYear() {
		Return This.FinancialYear := StrReplace(GetCellValue("Financial Year",0,1), "/", "-")
	}

	PaymentSummaryAmendment() {
		For sheet in Xl.Worksheets
	  		if (Sheet.Name = "Payment Summary Amendment")
			{
			Xl.Sheets("Payment Summary Amendment").activate
			Xl.ActiveSheet.Unprotect
			Fin_Year_To_Amend := SubStr(Xl.ActiveSheet.Range("D4").Value,1,4)
			winactivate, Mochasoft
			sendinput, {F4}
			sleep 500
			winactivate, Mochasoft
			sendinput, pay
			sendinput,{enter}
			sleep 500
			sendinput,{TAB 3}
			sendinput, %Fin_Year_To_Amend%26{F8}
			sleep 500
			sendinput,s{ENTER}
			sleep 500
			winactivate, Mochasoft
			sendinput, {Alt}ES
			sendinput, ^c
			sleep 500
			Array := StrSplit(Clipboard, "`n")
			sleep 500
			GrossSumTotal := substr(Array[18],14,15)
			SetCellValue("Reduce gross total:",GrossSumTotal,0,3)
			sleep 500
			
			FormatTime, Time,, dd/MM/yyyy
			SetCellValue("Pay Centre:",Workbook.Pay_centre,0,1)
			SetCellValue("Section 3: Requested By (Payroll)","Bryn Abbott",6,1)
			SetCellValue("Section 3: Requested By (Payroll)",Time,6,4)
			Xl.ActiveWorkbook.save()
			Xl.ActiveSheet.ExportAsFixedFormat(0, Xl.activeworkbook.path . "\" . "Payment Summary Amendment_" . Title . ".pdf" ,0,True,False,1,100,False)
	}
}
	PrintToPDF() {
		For sheet in Xl.Worksheets
		   if InStr(Sheet.Name, "Year Summary") 
					Xl.Sheets(Sheet.Name).activate
		
			Cell_No := SubStr(Xl.Range("A:J").Find("Total Overpayment").address, 4) + 1
			Cell_Letter := SubStr(Xl.Range("A:J").Find("Total Overpayment").address, 1,3)
			FileContents := ""
			
			loop, 27 {
				Cell_No := Cell_No + 1, Cell := Cell_Letter . Cell_No
		
				if (Xl.ActiveSheet.Range(Cell).Value = "0") 
					Blank_Pays .= "Pay " Cell_No - 6 "`n"
		
				if (Xl.ActiveSheet.Range(Cell).Value != "0") 
					PDF_Contents .= "Pay " Cell_No - 6 "`n"
			}
		
			Loop, parse, Blank_Pays, `n,
				Check := A_Index=1 ? Xl.Sheets(A_LoopField).Select(True) : Xl.Sheets(A_LoopField).Select(False)
			Xl.ActiveWindow.SelectedSheets.Visible := False 
		
			For sheet in Xl.Worksheets
			   if InStr(Sheet.Name, "Year Summary") 
						Xl.Sheets(Sheet.Name).Select(False)
		
			Loop, parse, PDF_Contents, `n,
				Xl.Sheets(A_LoopField).Select(False)
		
				Xl.ActiveSheet.ExportAsFixedFormat(0, Xl.activeworkbook.path . "\" . Workbook.AGS "_Paid Due Diff_" . Title . ".pdf" ,0,True,False,1,100,False)
		
				WinActivate, Excel
				Xl.DisplayAlerts := (False)
				Xl.ActiveSheet.Unprotect
				Xl.Workbook.Close(0) 
				Xl.quit()
			}

	PushTotalsToWorkbook() {

			For sheet in Xl.Worksheets
			   if InStr(Sheet.Name, "Year Summary") 
						Xl.Sheets(Sheet.Name).activate

			if (Financial_Year := GetCellValue("Current", 0, 1) = "2019/2020") {
					Financial_Year := RegExReplace(GetCellValue("Current", 0, 1), "/", "_")
					Workbook.TaxAmount := GetCellValue("TOTALS", 0, 1)
					Workbook.NettAmount := GetCellValue("TOTALS", 0, 2)
					Workbook.SalarySacAmount := GetCellValue("TOTALS", 0, 3)
					Workbook.DeductionsAmount := GetCellValue("TOTALS", 0, 4)
					Workbook.SuperAmount := GetCellValue("TOTALS", 0, 6)
					WinActivate, Excel
					Xl.DisplayAlerts := (False)
					Xl.ActiveSheet.Unprotect
					Xl.Workbook.Close(0) 
					Xl.quit()
				}
				
				if (Financial_Year := GetCellValue("Previous", 0, 1) != "2019/2020")
				{
					Past_Loaction := Xl.activeworkbook.path . "\"
					
					if (Workbook.GrossAmount != "")
					{
						Workbook.GrossAmount := Workbook.GrossAmount + GetCellValue("TOTALS", 0, 2)
						Workbook.SalarySacAmountGross := Workbook.SalarySacAmountGross + GetCellValue("TOTALS", 0, 3)
						Workbook.CantRecovreSuper := Workbook.CantRecovreSuper + GetCellValue("TOTALS", 0, 5)
					}
					
					else if (Workbook.GrossAmount = "")
					{
						Workbook.GrossAmount := GetCellValue("TOTALS", 0, 2)
						Workbook.SalarySacAmountGross := GetCellValue("TOTALS", 0, 3)
						Workbook.CantRecovreSuper := GetCellValue("TOTALS", 0, 5)
						guicontrol, text, Gross_Active, % Workbook.GrossAmount
						guicontrol, text, PrevSuper, % Workbook.CantRecovreSuper
					}
					
					WinActivate, Excel
					Xl.DisplayAlerts := (False)
					Xl.ActiveSheet.Unprotect
					Xl.Workbook.Close(0) 
					Xl.quit()
					Return
				}

	}




}

GetCellValue(Find,offset_X,offset_Y)
{
	Global
	Temp := ComObjActive("Excel.Application")
	ComObjError(false)
	Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
	return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
}

SetCellValue(Find,Value,offset_X,offset_Y)
{
	Global
	Temp := ComObjActive("Excel.Application")
	ComObjError(false)
	Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
	Temp.ActiveSheet.Range(Pointer.Offset(offset_X, offset_Y).address).Value := Value
}
