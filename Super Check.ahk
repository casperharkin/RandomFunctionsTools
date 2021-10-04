#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;InputBox, PayNo, What Pay?, What Pay Are We Reporting On?
;FuturePayPass()


PayNo := 06
FinYear := "2021/2022"
xl := ComObjActive("Excel.Application")

Loop % Xl.ActiveSheet.UsedRange.Rows.Count
	{
		AGS := Float(GetCellValue("AGS No",A_Index, 0))
		Name := GetCellValue("Employee Name",A_Index, 0)
		Ent_ID := GetCellValue("AGS No",A_Index, 2)

;		If (GetCellValue(Name,0, 14) != 0) 
;		{

		If InStr(Ent_ID, "OTN") and (GetCellValue(Name,0,15) != "Future SGR.COM")
			{
				winactivate, ahk_exe Payback.exe
				sleep, 200 
				WinGet, hWnd, ID, ePOD
				oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
				ControlHwnd := Acc_WindowFromObject(oAcc)
				sleep, 200 
				ControlFocus,, ahk_id %ControlHwnd%
				sleep, 200 
				ControlGetFocus, ControlName, ahk_id %ControlHwnd%
				sleep, 200 
				dllcall("keybd_event", int, 0x25, int, 0x14B, int, 0, int, 0)
				sleep, 200 
				send, {AppsKey}{Down}{Down}{Enter}
				sleep, 200 
				Send, %AGS%{ENTER}
				sleep, 800 

		If (UniqueID := WinExist(WinTitle, "There is no overpayment information for this employee for this FBT Year.") != "0x0")
		{
			sleep, 400 
			winactivate, ahk_exe Payback.exe
			sleep, 400 
			ControlClick, OK, ahk_exe Payback.exe
			sleep, 400 
			ControlClick, OK, ahk_exe Payback.exe
		}

		Date := Acc_Get("Object", "4.1.4.2.4.2.4.9.6", vChildID, "ahk_id " hWnd)
		Amt := Acc_Get("Object", "4.1.4.2.4.2.4.9.5", vChildID, "ahk_id " hWnd)
		Date := Date.accValue(vChildID)
		Amt := Amt.accValue(vChildID)
		;MsgBox % Date
		if (Date = PayNo . "/" . FinYear)
		{

			Activate_Send("{F4}")
			Sleep 300
			Activate_Send("PAY"  "{Enter}")
			Sleep 300
			Activate_Send(AGS . "{Enter}")
			Sleep 300

			If (MsgBox("Was Super Taken this Pay?","Was The Client Paid and Was Super Taken?") = "Yes")
				{
		
					MsgBox % "Copy the Recovery Bal and Amount of Super Collected to Clipboard"
		
					Array := StrSplit(Clipboard, " ")
		
		
					SetCellValue(Name,"ePOD Updated for Pay 6",0,15)
					SetCellValue(Name, Array.1,0,13)
		
					Row := SubStr(GetCellAddy(Name,0,15), 4,4)	
					Xl.Range("$A" . Row . ":$T" . Row ).Interior.Color := 000255000
		
					MsgBox % "Add RTM Payment `n `nFigure Has Been Added to the Clipboard. " Clipboard := ReplacedStr := StrReplace(Array[Array.Length()],"-")
					Clipboard := "P" . PayNo . "/2021/2022"
					MsgBox % "Done"
				}
		}

;				If (MsgBox("Is there entrys for Super?","Is there a future SGR.COM?") = "Yes")
;					{
;						SetCellValue(Name,"Future SGR.COM",0,15)
;						Row := SubStr(GetCellAddy(Name,0,15), 4,4)
;						Xl.Range("$A" . Row . ":$T" . Row ).Interior.Color := 2552550
;					}
			}
;		}
	}

Exit

FuturePayPass()
{
Global

xl := ComObjActive("Excel.Application")

Loop % Xl.ActiveSheet.UsedRange.Rows.Count
	{
		AGS := Float(GetCellValue("AGS No",A_Index, 0))
		Name := GetCellValue("Employee Name",A_Index, 0)
		Ent_ID := GetCellValue("AGS No",A_Index, 2)

		If (GetCellValue(Name,0, 14) = 0) 
		{

		If InStr(Ent_ID, "OTN") 
			{
				Activate_Send("{F4}")
				Activate_Send("Ptrc"  "{Enter}")
				Activate_Send("{TAB}" . AGS . "{Enter}")
				Activate_Send("{Shift Down}{TAB}{TAB}{TAB}{TAB}{Shift Up}A{Enter}")

				If (MsgBox("Is there entrys for Super?","Is there a future SGR.COM?") = "Yes")
					{
						SetCellValue(Name,"Future SGR.COM",0,15)
						Row := SubStr(GetCellAddy(Name,0,15), 4,4)
						Xl.Range("$A" . Row . ":$T" . Row ).Interior.Color := 2552550
					}
			}
		}
	}
}

Float( n, p:=6 ) { ; By SKAN on D1BM @ goo.gl/Q7zQG9
Return SubStr(n:=Format("{:0." p "f}",n),1,-1-p) . ((n:=RTrim(SubStr(n,1-p),0) ) ? "." . n : "") 
}

MsgBox(Title,Msg) {
Global Result

MsgBox 0x24, %  Title ": ", % Msg

	IfMsgBox Yes, {
		return "Yes"
	} Else IfMsgBox No, {
		return "No"
	}

}

Activate_Send(msg) 
{
	WinActivate Mochasoft - mainframe.nt.gov.au
	sleep 300
	Send % msg
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
	
	SetCellValue(Find,Value,offset_X,offset_Y)
	{
		Temp := ComObjActive("Excel.Application")
		ComObjError(false)
		Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
		Temp.ActiveSheet.Range(Pointer.Offset(offset_X, offset_Y).address).Value := Value
	}
