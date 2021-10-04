#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Xl := ComObjActive("Excel.Application")
ComObjError(false)

Loop % Xl.ActiveSheet.UsedRange.Rows.Count
	{
		ServiceNo := Float(GetCellValue("AGS", A_Index, 0))

		winactivate, ePOD
		sleep(200)
		send, {Alt}{Down}{Enter}
		sleep(200)
		Send, %ServiceNo%{ENTER}
		sleep(200)
		
		MsgBox
;		Date := Acc_Get("Object", "4.1.4.2.4.2.4.9.1", vChildID, "ahk_id " hWnd)
;		Amt := Acc_Get("Object", "4.1.4.2.4.2.4.9.5", vChildID, "ahk_id " hWnd)

	}


Exit

	SetCellValue(Find,Value,offset_X,offset_Y)
	{
		Temp := ComObjActive("Excel.Application")
		ComObjError(false)
		Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
		Temp.ActiveSheet.Range(Pointer.Offset(offset_X, offset_Y).address).Value := Value
	}

	GetCellValue(Find,offset_X,offset_Y)
	{
		Global
		Temp := ComObjActive("Excel.Application")
		ComObjError(false)
		Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
		return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
	}

Float( n, p:=6 ) { ; By SKAN on D1BM @ goo.gl/Q7zQG9
Return SubStr(n:=Format("{:0." p "f}",n),1,-1-p) . ((n:=RTrim(SubStr(n,1-p),0) ) ? "." . n : "") 
}

	Sleep(Duration)
	{
		if (Thread_Kill_Token = True)
		{
			Thread_Kill_Token := !Thread_Kill_Token
			Exit
		}
		Sleep % Duration
	}