#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
#Persistent
#Include <General>
#Include C:\Users\babb\Documents\Autohotkey\Lib\LV_InCellEdit.ahk
Menu, Tray, Icon, C:\_Umbra Sector\_Resources\ghost_KwJ_icon.ico,,1

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

#SingleInstance force
Global Workbook, CheckListArray, Stage

Global ExitThreadFlag, Workbook, Chars		

Workbook := OrderedArray()


;		Workbook.AGS := "85568665"
;		Workbook.PayCentre := "673"
;		Workbook.FBT := "01010101"
;		Workbook.DateDetected := "Years Ago"
;		Workbook.DateCommenced := "Today"
;		Workbook.DateCeased := "adgg"
;		Workbook.Total := "askkk"
;		Workbook.Reason := "eyarh"
;		
;		; ePOD Reporting
;		Workbook.ErrorSource := "5416346"
;		Workbook.ErrorType := "1114761"
;		Workbook.ErrorCause := "5411613"
;		Workbook.Location := "426426246"
;		
;		;Cumulative Totals and Recover Overpaid Tax
;		Workbook.RPMENT := "mmkumk" 
;		Workbook.TAXPYM := "hmlulh"
;		Workbook.RDRENT := "mlmlg"
;		Workbook.RCYCOM := "ssss"
;		Workbook.Percentage := "ssss"
;		Workbook.Paydate := "s"
;		Workbook.PayCentre := "673"
;		Workbook.FBT := "01010101"
;		Workbook.DateDetected := "Years Ago"
;		Workbook.DateCommenced := "Today"
;		Workbook.DateCeased := "adgg"
;		Workbook.Total := "askkk"
;		Workbook.Reason := "eyarh"
;		
;		; ePOD Reporting
;		Workbook.ErrorSource := "5416346"
;		Workbook.ErrorType := "1114761"
;		Workbook.ErrorCause := "5411613"
;		Workbook.Location := "426426246"
;		
;		;Cumulative Totals and Recover Overpaid Tax
;		Workbook.RPMENT := "mmkumk" 
;		Workbook.TAXPYM := "hmlulh"
;		Workbook.RDRENT := "mlmlg"
;		Workbook.RCYCOM := "ssss"
;		Workbook.Percentage := "ssss"
;		Workbook.Paydate := "ssss"
;		

OnClipboardChange("ClipChanged")
Workarea(A_ScreenWidth-200, A_ScreenHeight-27)
SessionChange(true) 
OnExit("ExitFunc")

Chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/.", ExitThreadFlag := False

IniRead,U, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
IniRead,S, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
IniRead,S2, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S2

Gui Login: Add, Text, x32 y27 w85 h20, User ID:
Gui Login: Add, Edit, x124 y24 w127 h22 vU, % U
Gui Login: Add, Text, x32 y55 w85 h20, ePOD Password:
Gui Login: Add, Edit, x124 y52 w127 h22 +Password vS2, % S2
Gui Login: Add, Text, x32 y81 w85 h20, PIPS Password:
Gui Login: Add, Edit, x124 y79 w127 h22 +Password vS, % S
Gui Login: Add, Button, x277 y20 w96 h39 gLogin, Connect
Gui Login: Add, Button, x277 y79 w96 h39 gLoginGuiEscape, Cancel
Gui Login: Add, Text, x21 y138 w448 h20, Note: Password and User Details are not kept in plain text.
Gui Login: Show, w387 h166, PDR Login - Toolbar
Return

Login:
Gui, Submit, Destroy

If (U = "BABB") 
{
	IniWrite, % Base64Encode(U), % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
	IniWrite, % Base64Encode(S), % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
	IniWrite, % Base64Encode(S2), % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S2
}

LoginGuiEscape:
LoginGuiClose:
Gui, Destroy


;###################################################################################
;################################## Main GUI #######################################
;###################################################################################

Gui, -Resize -Caption -Border +HWNDhGui1 +ToolWindow  -SysMenu +AlwaysOnTop  
Gui Color, FFFFFF

Gui, Add, Text, % " x" 0 " y" 0 " w" 1 " h" 876 " +0x4E +HWNDhBorderLeft"
DllCall("SendMessage", "Ptr", hBorderLeft, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0072C6", 1, 1))
Gui, Add, Text, % " x" 199 " y" 0 " w" 1 " h" 876 " +0x4E +HWNDhBorderRight"
DllCall("SendMessage", "Ptr", hBorderRight, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0072C6", 1, 1))

Gui, Margin, 0, 0
Gui, Font, s8, Verdana
Gui, Add, Picture, x0 y0 w200 h59 +BackgroundTrans  +0x4E +HWNDhGUIBG,
DllCall("SendMessage", "Ptr", hGUIBG, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
Gui, font, cWhite s12 Verdana Bold Underline
Gui, Add, Text, x0 y20 w197 +center +BackgroundTrans, Debt Recover Unit
Gui, font

Gui, Add, GroupBox, xm+2 ys+65 Section w195 h95, Load Client Data:
Gui, Add, edit, xs+5  ys+15 w186 +center vAGS, 85568665
Gui, Add, button, xs+5  y+3 w186 gMainMenuHandler, Load AGS
Gui, Add, button, xs+5 y+3  w186 gMainMenuHandler, Generate Subject Line

Gui, Add, GroupBox, xm+2 ys+95 Section  w195 h175, Process Workbook:
Gui, Add, button, xs+5 ys+15 w186 gMainMenuHandler, Process Paid Due Diff
Gui, Add, button, xs+5 y+3  w186 gMainMenuHandler, Process Workbook
Gui, Add, button, xs+5 y+3  w186 gMainMenuHandler, Process ePOD
Gui, Add, button, xs+5 y+3 w186 gMainMenuHandler, Refresh from Workbook
Gui, Add, button, xs+5 y+3 w186 gMainMenuHandler, Process Gross Cumlative Totals
Gui, Add, button, xs+5 y+3 w186 gMainMenuHandler, Process Recovery Action

Gui, Add, GroupBox, xm+2 ys+175 Section  w195 r16, Workbook Details:
Gui, Add, ListView, xs+5 ys+15 w186 -readonly gSubLV1 hwndHLV1 r10 hwndHLV1 AltSubmit vLV1, Variable:|Contents:

Gui, Add, GroupBox, xm+2 ys+225 Section hWndhNotesGroupBox w195 r9.5, Quick Notes:
Gui, Add, edit, xs+5  ys+15 r8 w186 hWndhNotesEditBox,


Gui, Add, GroupBox, xm+2 ys+140 Section  w195 h150, Shortcuts:
Gui, Add, button, xs+3  ys+15 w45 gShortcutMenuHandler, Recent
Gui, Add, button, x+3  ys+15 w45 gShortcutMenuHandler, ePOD
Gui, Add, button, x+3  ys+15 w45 gShortcutMenuHandler, PIPS
Gui, Add, button, x+3  ys+15 w45 gShortcutMenuHandler, F:\

Gui, Add, button, xm+5 y+5 w45 Section  gShortcutMenuHandler, Web
Gui, Add, button, x+3  w45 gShortcutMenuHandler, Phone
Gui, Add, button, x+3  w45 gShortcutMenuHandler, myHR
Gui, Add, button, x+3  w45 gShortcutMenuHandler, GAS

Gui, Add, button, xm+5 y+5 w45 Section  gShortcutMenuHandler, Debug
Gui, Add, button, x+3  w45 gShortcutMenuHandler, QMast
Gui, Add, button, x+3  w45 gShortcutMenuHandler, LogJob
Gui, Add, button, x+3  w45 gShortcutMenuHandler, Notes

Gui, Add, button, xm+5 y+5 w45 Section  gShortcutMenuHandler, Logon
Gui, Add, button, x+3  w45 gShortcutMenuHandler, TV/QN
Gui, Add, button, x+3  w45 gShortcutMenuHandler,  
Gui, Add, button, x+3  w45 gShortcutMenuHandler,  

Gui, Show, x1240 y0 w199 h870, 

Array_Gui(Workbook,"Client Details:")
ICELV1 := New LV_InCellEdit(HLV1)
ICELV1.OnMessage()
RefreshListView()
return

SubLV1:  
If (A_GuiEvent == "F") {
   If (ICELV1["Changed"]) {
      Msg := ""
      For I, O In ICELV1.Changed
         Msg .= "Row " . O.Row . " - Column " . O.Col . " : " . O.Txt
    ICELV1.Remove("Changed")
	SAVE()
   }
}
return

GuiClose:
ExitApp

MainMenuHandler:
Gui, Submit, Nohide
ServiceNo := AGS

if (A_guicontrol = "Load AGS")
	{		
;		Person_Details(Workbook.AGS)
;		Superannuation_Details(Workbook.AGS)
;		SuperInfoFetch(Workbook.SuperFund)
;		Address_Details(Workbook.AGS)

		;Create Instance
		ActiveClientData := New MainfraimToText(ServiceNo)
		
		ActiveClientData.Navigate()

		ActiveClientData.GatherPersonDetails()
		ActiveClientData.GatherAddresses()
		ActiveClientData.GatherSuperannuation()
		ActiveClientData.GatherCostCode()

		RefreshListView()
	}

if (A_guicontrol = "Process Paid Due Diff")
	{
		PreparePaidDueDiff(Workbook.AGS)
		RefreshListView()
	}

if (A_guicontrol = "Process Workbook")
	{
		ProcessWorkbook(Workbook.AGS)
		RefreshListView()
	}

if (A_guicontrol = "Refresh from Workbook")
	{
		Xl := ComObjActive("Excel.Application")
		ComObjError(false)
		
		;Overpayment Investigation Report
		Workbook.AGS := SubStr(GetCellValue("AGS", 0, 1), 1 , 8)
		Workbook.PayCentre := GetCellValue("Pay Centre", 0, 1)
		Workbook.FBT := GetCellValue("FBT Date", 0, 1)
		Workbook.DateDetected := GetCellValue("Date Overpayment Detected", 0, 1)
		Workbook.DateCommenced := GetCellValue("Date O/P commenced", 1, 0)
		Workbook.DateCeased := GetCellValue("Date O/P ceased", 1, 0)
		Workbook.Total := RegExReplace(GetCellValue("Total overpayment to be recovered", 1, 0), "[^0-9.]")
		Workbook.Reason := GetCellValue("Reason for Overpayment (This description will be shown on the letter to the employee)", 1, 0) . ". (" . Workbook.DateCommenced . " to " . Workbook.DateCeased . ") $" . Workbook.Total
		
		; ePOD Reporting
		Workbook.ErrorSource := GetCellValue("Error Source", 1, 0)
		Workbook.ErrorType := GetCellValue("Error Type", 1, 0)
		Workbook.ErrorCause := GetCellValue("Error Cause", 1, 0)
		Workbook.Location := GetCellValue("Location", 1, 0)
		
		;Cumulative Totals and Recover Overpaid Tax
		Workbook.RPMENT := Float(GetCellValue("RPM.ENT", 0, 2)) 
		Workbook.TAXPYM := Float(GetCellValue("TAX.PYM", 0, 2)) 
		Workbook.RDRENT := Float(GetCellValue("RDR.ENT", 0, 2)) 
		Workbook.RCYCOM := Float(GetCellValue("RCY.COM", -1, 3))
		Workbook.Percentage := Float(GetCellValue("10% of gross salary", 0, 1),2) 
		Workbook.Paydate := Pay_hash(Workbook.PayCycle)
	}

if (A_guicontrol = "Process ePOD")
	{
		WinActivate ahk_exe Payback.exe
		WinGet,hWnd,id, Overpayment Details
		
		oAcc := Acc_Get("Object", "4.1.4.2.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		ControlSetText,, % Workbook.Date_Detected, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.4.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		ControlSetText,, %  Workbook.FBT, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.6.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		ControlSetText,, RCY002, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.8.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, Nett, , ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.10.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		ControlSetText,, %  Workbook.TotalAmount, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.16.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, % Workbook.Error_Source, , ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.19.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, % Workbook.Error_Type,, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.22.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, % Workbook.Error_Cause,, ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.1.4.26.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, % Workbook.Location, , ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.6.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%
		Control, ChooseString, Calculated/Reported, , ahk_id %ControlHwnd%
		
		oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		ControlFocus,, ahk_id %ControlHwnd%

		clipboard := Workbook.Reason
		Send, ^v{Space}{BackSpace}
	}

if (A_guicontrol = "Process Gross Cumlative Totals")
	{
	
	Workbook_Reason_PIPS :=  Workbook.Reason
	
	if winexist("Mochasoft - mainframe.nt.gov.au")
	{
		
		WinActivate Mochasoft
		SetKeyDelay, 80, 0,
		Datez := A_DD " " A_MMM " " A_YYYY
		sleep 200
		Workbook.RPMENT := RegExReplace(Workbook.RPMENT, "[^0-9.]")
		Workbook.TAXPYM := RegExReplace(Workbook.TAXPYM, "[^0-9.]")
		Workbook.RDRENT := RegExReplace(Workbook.RDRENT, "[^0-9.]")
		Amount_Field := "_________"
		Amount_Field_Larg := "________________"
		Date_Field := "___________"
		Receipt_Field := "________________"
		Receipt := "PAYROLL DRT ASP_"
		sleep 500
		Send {F7}RPM.ENT{enter}
		Clipboard := SubStr(Amount_Field,1,StrLen(Amount_Field) - StrLen(Workbook.RPMENT)) . Workbook.RPMENT . "+" . Datez . Receipt . "__" . SubStr(Amount_Field,1,StrLen(Amount_Field) - StrLen(Workbook.RPMENT)) . Workbook.RPMENT . "M" . "________________NY" . "_______________________" . Float(Workbook.PayCentre, 3) . "2019/20" . Workbook.Pay_Cycle
		sleep 500
		SendInput ^v
		sleep 500
		Workbook_Reason_PIPS := SubStr(Workbook.Reason, 1, 160)
		SendInput {f9}%Workbook_Reason_PIPS%{Enter}{Enter}{Enter}
		sleep 500
		SendInput {F7}TAX.PYM{enter}
		sleep 500
		Clipboard := "ATTAX1" . SubStr(Amount_Field,1,StrLen(Amount_Field) - StrLen(Workbook.TAXPYM)) . Workbook.TAXPYM . "NY" . "_______________________" . Float(Workbook.PayCentre, 3) . "2019/20" . Workbook.Pay_Cycle
		SendInput ^v	
		sleep 500
		Send {F17}
		sleep 500
		Workbook_Reason_PIPS := SubStr(Workbook.Reason, 1, 160)
		SendInput {f9}%Workbook_Reason_PIPS%{Enter}{Enter}{Enter}
		sleep 500
		Send {F7}RDR.ENT{enter}
		Clipboard  := "RPAY__" . SubStr(Amount_Field_Larg,1,StrLen(Amount_Field_Larg) - StrLen(Workbook.TAXPYM)) . Workbook.TAXPYM . "M" . Datez . "____________________________________________" . "Y" . "_______________________" . Float(Workbook.PayCentre, 3) . "2019/20" . Workbook.Pay_Cycle
		sleep 500
		SendInput ^v
		sleep 500		
		Workbook_Reason_PIPS := SubStr(Workbook.Reason, 1, 160)
		SendInput {f9}%Workbook_Reason_PIPS%{Enter}{Enter}{Enter}
	}
	else 
	{
		msgbox, % "Is PIPS Open to PTR Screen for AGS: " SubStr(Workbook.Active_AGS, 1 , 8) "? `n`nYou Will Need to Run Cumulative Totals Adjustment Again."
		return
	}
	}

if (A_guicontrol = "Process Recovery Action")
	{
		if winexist("Mochasoft - mainframe.nt.gov.au")
			{
				WinActivate Mochasoft
				SetKeyDelay, 80, 0,
				Datez := A_DD " " A_MMM " " A_YYYY
				sleep 200
				formattime, datezz,a_now , dd MMM yyyy
				Amount_Field := "_________"
				Send {F7}RCY.COM{enter}
				sleep 900
				Clipboard  := "RCY002N" . datezz . SubStr(Amount_Field,1,StrLen(Amount_Field) - StrLen(Workbook.Percentage)) . Workbook.Percentage . "_________" . SubStr(Amount_Field,1,StrLen(Amount_Field) - StrLen(Workbook.Total)) . Workbook.Total . "_______________________" . "Y" . "_______________________" . Float(Workbook.PayCentre,3) . "2019/20" . Workbook.Pay_Cycle
				sleep 900
				SendInput ^v
				sleep 900
				Workbook_Reason_PIPS := SubStr(Workbook.Reason, 1, 160)
				SendInput {f9}%Workbook_Reason_PIPS%
				sleep 500
				return
				
			}
		else 
			{
				msgbox, % "Is PIPS Open to PTR Screen for AGS: " SubStr(Workbook_AGS, 1 , 8) "? `n`nYou Will Need to Run RCY.COM Again."
				return
			}
	}
Return

ShortcutMenuHandler:
Gui, Submit, Nohide

if (A_GuiControl = "Recent") 
{
Loop, Files, % "C:\Users\" A_Username "\Documents\Offline Records (34)\*.*", R
{
    FileGetTime, FileTime, % A_LoopFileLongPath
    If (FileTime > LatestFileTime) OR (A_Index = 1)
        LatestFileTime := FileTime, LatestFilePath := A_LoopFileLongPath
}
SplitPath, LatestFilePath,, dir
Run % dir 
return
}

if (A_GuiControl = "ePOD") 
{
		if !WinExist("ePOD") 
		{
			Run "C:\Users\babb\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\DBE Financial Systems\Production\EPod.appref-ms"
			WinWait, ePOD Login - Production
			sleep 1000
			WinGet,hWnd,id, ePOD Login - Production
			
			oAcc := Acc_Get("Object", "4.3.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			SendInput, % Base64Decode(U)
			
			oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			SendInput,  % Base64Decode(S2)
			
			oAcc := Acc_Get("Object", "4.5.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			ControlClick,, ahk_id %ControlHwnd%
		}

WinGetTitle, OutputVar, ahk_exe Payback.exe
While OutputVar = "ePOD Login - Production"
	{
	Sleep 100
	WinGetTitle, OutputVar, ahk_exe Payback.exe
	}

While OutputVar = "Initialising..."
	{
	Sleep 100
	WinGetTitle, OutputVar, ahk_exe Payback.exe
	}
Move_Resize("ePOD",1480,5,A_screenWidth,A_ScreenHight,True,False)
}

if (A_GuiControl = "PIPS") 
{
		if !WinExist("Mochasoft")  
		{
			Run "C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe"
			WinWait, Mochasoft - mainframe.nt.gov.au
			sleep 1000
			WinActivate, Mochasoft - mainframe.nt.gov.au
			send % Base64Decode(U)
			send {TAB}
			send % Base64Decode(S)
			send {Enter}
			sleep 500
			send {Enter}
		}
Move_Resize("Mochasoft - mainframe.nt.gov.au",1480,5,A_screenWidth,A_ScreenHight,True,False)
return
}

if (A_GuiControl = "F:\") {
	Run F:\Payroll Debt Recovery\
return	
}

if (A_GuiControl = "Web") {
	run C:\Users\babb\AppData\Local\Google\Chrome\Application\chrome.exe 
return	
}

if (A_GuiControl = "Phone") {
	run microsoft-edge:http://ntgcentral.nt.gov.au/phones?search=
return	
}

if (A_GuiControl = "myHR") {
	run https://myhr.nt.gov.au/
return	
}

if (A_GuiControl = "GAS") {
	run microsoft-edge:http://dbefinws01.cprod.corp.ntgov:8080/Masterpiece4.0_NTG/Welcome.jsp
return	
}

if (A_GuiControl = "Debug") {
	ClipOld := Clipboard
	Sendinput, {LWin down}{r}{LWin up} 
	Clipboard := "C:\Users\babb\Documents\Autohotkey\Lib\DebugVars.ahk"
	sleep 300
	Sendinput, {ctrl down}{v} 
	Sendinput, {Enter}
	Clipboard := ClipOld 
return	
}

if (A_GuiControl = "QMast") {
	WinGet, Style, Style, UC for Business Desktop - Bryn Abbot
	If (Style & 0x10000000)  ; 0x10000000 is WS_VISIBLE
		{
		  	WinHide ahk_class TFormVterm
			Return
		}
	else 
		{
			WinShow ahk_class TFormVterm 
			WinMaximize, UC for Business Desktop - Bryn Abbot
		}
return	
}

if (A_GuiControl = "LogJob") {
	MsgBox % "Not Happy with how this all works, will update it one day."
return	
}

if (A_GuiControl = "Notes") {
	run "C:\_Umbra Sector\_Projects\GAS Notes Wizard\GAS Notes Wizard.ahk"
return	
}

if (A_guicontrol = "Logon")	{
		if !WinExist("ePOD") 
		{
			Run "C:\Users\babb\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\DBE Financial Systems\Production\EPod.appref-ms"
			WinWait, ePOD Login - Production
			sleep 1000
			WinGet,hWnd,id, ePOD Login - Production
			
			oAcc := Acc_Get("Object", "4.3.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			SendInput, % Base64Decode(U)
			
			oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			SendInput,  % Base64Decode(S2)
			
			oAcc := Acc_Get("Object", "4.5.4", 0, "ahk_id " hWnd) 
			ControlHwnd := Acc_WindowFromObject(oAcc)
			ControlFocus,, ahk_id %ControlHwnd%
			ControlClick,, ahk_id %ControlHwnd%
		}
		
		if !WinExist("Mochasoft")  
		{
			Run "C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe"
			WinWait, Mochasoft - mainframe.nt.gov.au
			sleep 1000
			WinActivate, Mochasoft - mainframe.nt.gov.au
			send % Base64Decode(U)
			send {TAB}
			send % Base64Decode(S)
			send {Enter}
			sleep 500
			send {Enter}
		}
		
		if !WinExist("- Outlook")
			Run OUTLOOK
		
		if !WinExist("HPE") 
			Run trim
		
		if !WinExist("UC") 
			Run "F:\Payroll Debt Recovery\Q-Master\Version 5.1\Desktop.exe"	
		
		sleep 10000
		Move_Resize("- Outlook",5,5,A_screenWidth,A_ScreenHight,True,False)
		Move_Resize("ePOD",1480,5,A_screenWidth,A_ScreenHight,True,False)
		Move_Resize("Mochasoft - mainframe.nt.gov.au",1480,5,A_screenWidth,A_ScreenHight,True,False)
		Move_Resize("HPE Content Manager",1480,5,A_screenWidth,A_ScreenHight,True,False)
	Return
	}

if (A_GuiControl = "TV/QN") 
	{
	
		QNToggle := !QNToggle
	
	If (QNToggle) 
		{
			GuiControl,, % hNotesGroupBox, TV Channel:
			GuiControl, Hide 1, % hNotesEditBox
			Run % "C:\Users\babb\Desktop\Miniplayer.ahk"
			SetParentByClass("AutoHotkeyGUI",2)
		}
	else
		{
			GuiControl, , % hNotesGroupBox, Quick Notes:
			GuiControl, Hide 0, % hNotesEditBox
			process,close, Miniplayer.ahk
		}
	}


return
Position:
Gui, Show, , % WMP.CurrentMedia.name " - " Format(WMP.Controls.currentPosition) " / " Format(WMP.CurrentMedia.duration)
return

SetParentByClass(Window_Class, Gui_Number) ; F
{ 
    Parent_Handle := DllCall( "FindWindowEx", "uint",0, "uint",0, "str", Window_Class, "uint",0) 
    Gui, %Gui_Number%: +LastFound 
    Return DllCall( "SetParent", "uint", WinExist(), "uint", Parent_Handle )
}


ExitFunc()
{
	SessionChange(false)
	Workarea(A_ScreenWidth, A_ScreenHeight-27)
}


Array_Gui(Array, Parent="") 
{

	For Key, Value in Array
	{
		Item := TV_Add(Key, Parent)
		if (IsObject(Value))
			Array_Gui(Value, Item)
	}
	return
	
	GuiArrayClose:
	Gui, Destroy
	return
}

RefreshListView()
{
	LV_Delete()
	GuiControl, -Redraw, MyListView 
	For Key, Value in Workbook
		LV_Add("", Key , Value )
	LV_ModifyCol(1,"")   
	LV_ModifyCol(2,"")
	GuiControl, +Redraw, MyListView
}

SAVE()
{
Loop % LV_GetCount()
	{
		LV_GetText(VarName, A_Index)
		LV_GetText(VarData, A_Index, 2)
		workbook[VarName] := VarData
	}
Return
}

CreateDIB(Input, W, H, ResizeW := 0, ResizeH := 0, Gradient := 1 ) {
	WB := Ceil((W * 3) / 2) * 2, VarSetCapacity(BMBITS, (WB * H) + 1, 0), P := &BMBITS
	Loop, Parse, Input, |
	{
		P := Numput("0x" . A_LoopField, P + 0, 0, "UInt") - (W & 1 && Mod(A_Index * 3, W * 3) = 0 ? 0 : 1)
	}
	hBM := DllCall("CreateBitmap", "Int", W, "Int", H, "UInt", 1, "UInt", 24, "Ptr", 0, "Ptr")
	hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2008, "Ptr")
	DllCall("SetBitmapBits", "Ptr", hBM, "UInt", WB * H, "Ptr", &BMBITS)
	If (Gradient != 1) {
		hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x0008, "Ptr")
	}
	return DllCall("CopyImage", "Ptr", hBM, "Int", 0, "Int", ResizeW, "Int", ResizeH, "Int", 0x200C, "UPtr")
}


PreparePaidDueDiff(Active_AGS)
{

Xl := ComObjActive("Excel.Application")
ComObjError(false)

Xl.Sheets(2).activate

PDD_Financial_Year := GetCellValue("Financial Year",0,1)

if (PDD_Financial_Year != "2019/2020")
	{
		Xl.Sheets("Payment Summary Amendment").Visible := True
		Xl.Sheets("Payment Summary Amendment").activate
		Xl.ActiveSheet.Unprotect
		
		SetCellValue("Pay Centre:",Workbook.Pay_centre,0,1)
		FormatTime, Time,, dd/MM/yyyy
		SetCellValue("Section 3: Requested By (Payroll)","Bryn Abbott",6,1)
		SetCellValue("Section 3: Requested By (Payroll)",Time,6,4)
		
		PDD_Financial_Year := SubStr(PDD_Financial_Year,1,4)

		winactivate, Mochasoft
		sendinput, {F4}

		Sleep(400)
		Array := StrSplit(PIPSScreenDump(), "`n")
		Sleep(400)

		if (substr(Array[3],33,16) = "M A I N  M E N U" )
			{
				winactivate, Mochasoft
				sendinput, pay
				sendinput,{enter}
				sleep(500)
				sendinput,{TAB 3}
				sendinput, %PDD_Financial_Year%26{F8}
				sleep(500)
				sendinput,s{ENTER}
				Sleep(400)
				Array := StrSplit(PIPSScreenDump(), "`n")
				Sleep(400)
				GrossSumTotal := substr(Array[18],14,15)
				SetCellValue("Reduce gross total:",GrossSumTotal,0,3)
			}

		sleep(500)
		Xl.ActiveWorkbook.save()
	}
	
	Xl.Sheets(2).Visible := True
	Xl.Sheets(2).activate
	Xl.Sheets(2).Unprotect
	
	Cell := Xl.Range("A:J").Find("Total Overpayment").address
	Cell_No := SubStr(Cell, 4) + 1
	Cell_Letter := SubStr(Cell, 1,3)
	FileContents := ""
	
	loop, 27
	{
		Cell_No := Cell_No + 1
		Cell := Cell_Letter . Cell_No
		
		if (Xl.ActiveSheet.Range(Cell).Value = "0") 
			Xl.Sheets("Pay " Cell_No - 6).Select(False)
		
		if (Xl.ActiveSheet.Range(Cell).Value != "0") 
			FileContents .= "Pay " Cell_No - 6 "`n"
	}
	
	Xl.ActiveWindow.SelectedSheets.Visible := False 

	Xl.Sheets(2).Visible := True
	Xl.Sheets(2).activate
	Xl.Sheets(2).Unprotect

	Xl.ActiveSheet.Range("C1").Value := "Name:"
	Xl.ActiveSheet.Range("C2").Value := "AGS:"

	SetCellValue("Name:",Workbook.Surname . ", " . Workbook.GivenNames,0,1)
	SetCellValue("AGS:",Workbook.AGS,0,1)
	
	Loop, parse, FileContents, `n,
		Xl.Sheets(A_LoopField).Select(False)
	
	Xl.ActiveSheet.ExportAsFixedFormat(0, Xl.activeworkbook.path . "\" . Workbook.AGS "_Paid Due Diff_" . StrReplace(GetCellValue("Financial Year",0,1), "/", "-") . ".pdf" ,0,True,False,1,100,False)
	
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
		}
		
		WinActivate, Excel
		Xl.DisplayAlerts := (False)
		Xl.ActiveSheet.Unprotect
		Xl.Workbook.Close(0) 
		Xl.quit()
		Return
	}
}

Move_Resize(WinTitle, X, Y, W, H, Max := "", Active := "")
{
WinMove, %WinTitle%,, %X%, %Y%, %W%, %H%
sleep 1000
if (Max = True)
	WinMaximize % WinTitle

if (Active = True)
	WinActivate % WinTitle
}

Base64Decode(code) {
	StringReplace code, code, =,,All
	Loop Parse, code
	{
		m := A_Index & 3 ; mod 4
		IfEqual m,0, {
			buffer += DeCode(A_LoopField)
			out := out Chr(buffer>>16) Chr(255 & buffer>>8) Chr(255 & buffer)
		}
		Else IfEqual m,1, SetEnv buffer, % DeCode(A_LoopField) << 18
			Else buffer += DeCode(A_LoopField) << 24-6*m
	}
	IfEqual m,0, Return out
	IfEqual m,2, Return out Chr(buffer>>16)
	Return out Chr(buffer>>16) Chr(255 & buffer>>8)
}

Code(i) {   ; <== Chars[i & 63], 0-base index
	Global Chars
	StringMid i, Chars, (i&63)+1, 1
	Return i
}

DeCode(c) { ; c = a char in Chars ==> position [0,63]
	Global Chars
	Return InStr(Chars,c,1) - 1
}

Base64Encode(string) {
	Loop Parse, string
	{
		m := Mod(A_Index,3)
		IfEqual      m,1, SetEnv buffer, % Asc(A_LoopField) << 16
		
		Else IfEqual m,2, EnvAdd buffer, % Asc(A_LoopField) << 8
			Else {
				buffer += Asc(A_LoopField)
				out := out Code(buffer>>18) Code(buffer>>12) Code(buffer>>6) Code(buffer)
			}
	}
	IfEqual m,0, Return out
	IfEqual m,1, Return out Code(buffer>>18) Code(buffer>>12) "=="
	Return out Code(buffer>>18) Code(buffer>>12) Code(buffer>>6) "="
}

EncodeInteger( p_value, p_size, p_address, p_offset )
{
	loop, %p_size%
		DllCall( "RtlFillMemory"
			, "uint", p_address+p_offset+A_Index-1
			, "uint", 1
			, "uchar", ( p_value >> ( 8*( A_Index-1 ) ) ) & 0xFF )
}

Workarea(Width, Hight) 
{
VarSetCapacity(area, 16)
EncodeInteger(Width, 4, &area, 8 )
EncodeInteger(Hight, 4, &area, 12 )
success := DllCall( "SystemParametersInfo", "uint", 0x2F, "uint", 0, "uint", &area, "uint", 0 )
if ( ErrorLevel or ! success )
{
	MsgBox, [1] failed: EL = %ErrorLevel%
	ExitApp
}
return
}

SessionChange(notify := true)
{
    static WTS_CURRENT_SERVER      := 0
    static NOTIFY_FOR_ALL_SESSIONS := 1

    if (notify)                                                                   ; http://msdn.com/library/bb530723(vs.85,en-us)
    {
        if !(DllCall("wtsapi32.dll\WTSRegisterSessionNotificationEx", "Ptr", WTS_CURRENT_SERVER, "Ptr", A_ScriptHwnd, "UInt", NOTIFY_FOR_ALL_SESSIONS))
            return false
        OnMessage(0x02B1, "WM_WTSSESSION_CHANGE")
    }
    else                                                                          ; http://msdn.com/library/bb530724(vs.85,en-us)
    {
        OnMessage(0x02B1, "")
        if !(DllCall("wtsapi32.dll\WTSUnRegisterSessionNotificationEx", "Ptr", WTS_CURRENT_SERVER, "Ptr", A_ScriptHwnd))
            return false
    }
    return true
}

WM_WTSSESSION_CHANGE(wParam, lParam)                                              ; http://msdn.com/library/aa383828(vs.85,en-us)
{
    static WTS_SESSION_UNLOCK := 0x8
    if (wParam = WTS_SESSION_UNLOCK)
		{
			Sleep 1000
      		Workarea(A_ScreenWidth-200, A_ScreenHeight-27)
			WinGet windows, List
			Loop %windows%
			{
				HWND := windows%A_Index%
				WinGetTitle, OutputVar, ahk_id %HWND%
				WinGet, Style, Style, ahk_id %HWND%
				WinGetClass class, ahk_id %HWND%	
				If (class = "ApplicationFrameWindow") 
					Return
			
				If (Style & 0x10000000) and (OutputVar != "") and (OutputVar != "Settings")
					{
						WinGet, MinMax, MinMax, ahk_id %HWND%
						If (MinMax = 1)
							{
								WinRestore, ahk_id %HWND%	
								WinMaximize, ahk_id %HWND%	
							}
					}
			}
			
		}
}

ClipChanged(Type) 
{
ClipboardCheck := Trim(Clipboard," ")
	IF (Strlen(ClipboardCheck) = "9")
		IF (SubStr(ClipboardCheck, 4, 1) = " ") or (SubStr(ClipboardCheck, 4, 1) = "-")
			Clipboard := StrReplace(StrReplace(ClipboardCheck, "-", A_Space), " ")
}


