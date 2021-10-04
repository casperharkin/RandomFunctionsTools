#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Global Workbook := {}
Workbook.SuperFund := "OTN143"

SuperInfoFetch(Workbook.SuperFund)
MsgBox % Workbook.SuperFundAddress
Return

SuperInfoFetch(SuperFund)
{
	Xl := ComObjCreate("Excel.Application") 
	Xl_Workbook := Xl.Workbooks.Open("P:\21161 - Payroll Debt Recovey\Notes\List of Super Providers and Codes.xls") 
	Xl.Visible := False
	Workbook.SuperFundAddress := Xl.Range("E" Xl.Range("A:E").Find(SuperFund).row).value
	Workbook.SuperFundName := StrSplit(Xl.Range("D" Xl.Range("A:E").Find(SuperFund).row).value,"`n", ".").1
	Xl.quit()
}