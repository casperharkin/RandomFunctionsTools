#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

InputBox, _Workbook_AGS, Manual Payee Creator,What is the AGS for the Manual Payee?
winactivate, ePOD
WinGet, hWnd, ID, ePOD
oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
ControlHwnd := Acc_WindowFromObject(oAcc)
ControlFocus,, ahk_id %ControlHwnd%
ControlGetFocus, ControlName, ahk_id %ControlHwnd%
dllcall("keybd_event", int, 0x25, int, 0x14B, int, 0, int, 0)
send, {AppsKey}{Down}{Down}{Enter}
sleep 200
Send, %_Workbook_AGS%{ENTER}
sleep 200

oAcc := Acc_Get("Object", "4.1.4.1.4.8.4", vChildID, "ahk_id " hWnd)
Name := oAcc.accValue(vChildID)
oAcc := Acc_Get("Object", "4.1.4.1.4.10.4", vChildID, "ahk_id " hWnd)
Name2 := oAcc.accValue(vChildID)
oAcc := Acc_Get("Object", "4.1.4.1.4.12.4", vChildID, "ahk_id " hWnd)
Amount := oAcc.accValue(vChildID)

	run "C:\Users\babb\Documents\Custom Office Templates\Manual Payee Recovery.xls"
		WinWaitActive, Manual Payee Recovery.xls  [Compatibility Mode] - Excel

	WinActivate Excel
	Xl := ComObjActive("Excel.Application") 
	ComObjError(false)  


	Xl.Range("C4").Value := (Name " , " Name2)
	Xl.Range("C5").Value := (_Workbook_AGS)
	Xl.Range("C6").Value := (Amount)
	Xl.ActiveWorkbook.SaveAs(A_Desktop . "\" . Name . "_MANUAL PAYEE RECOVERY")
	Xl.ActiveWorkbook.Close()