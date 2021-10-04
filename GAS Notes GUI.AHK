Application := {} 

Application.Name :=  "Gas Notes Wizard"
Application.Version := "4.8"
Application.BuildDate := "08:18 AM @ 10/12/2020"

Window := {} ; Create Window Object
Window.Width := 545
Window.Height := 425
Window.Title := Application.Name
MultiLineFlag = True

;Main GUI ==============================================================================
Gui Main:  +LastFound -Resize +Caption +Border +HWNDhGui1 -ToolWindow  +SysMenu 
Gui Main:  Color, FFFFFF
Gui Main:  Margin, 10, 10

; Window Header h67
Gui Main:  Add, Text, % "x" 1 " y" 0 " w545"   " h" 37 " +0x4E +HWNDhTitleHeader"
DllCall("SendMessage", "Ptr", hTitleHeader, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))

; Window StatusBar
Gui Main:  Add, Picture, % " x" 1 " y404" " w545" " h" 22 " +0x4E +HWNDhStatusBar"
StatusBar := "#@@@@@@@@@@@@@@@@@@@@@"
StringReplace, StatusBar, StatusBar, #, BFBFBF|, All
StringReplace, StatusBar, StatusBar, @, F1F1F1|, All
StringTrimRight, StatusBar, StatusBar, 1
DllCall("SendMessage", "Ptr", hStatusBar, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB(StatusBar, 1, 22))
Gui Main:  Font, s8 c515050, Segoe UI ; Set font options
Gui Main:  Add, Text, % " x" 8 " y407" " w545" " vStatusBarText +HWNDhStatusBarText +BackgroundTrans", % "Gas Notes Wizard v" Application.Version
Gui Main: Font ; Reset font options

; Window Menu Button
Gui Main:  Font, s9 cFFFFFF, Segoe UI ; Set font options y36
Gui Main: Add, Picture, % " x" 2 " y" 6 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuFileN Hidden0"
Gui Main:  Add, Picture, % " x" 2 " y" 6 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuFileN Hidden0"

Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuFileH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuFileText +BackgroundTrans +0x201", % "File"
DllCall("SendMessage", "Ptr", hButtonMenuFileN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuFileH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuEditN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuEditH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuEditText +BackgroundTrans +0x201", % "Edit"
DllCall("SendMessage", "Ptr", hButtonMenuEditN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuEditH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuWizardsN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuWizardsH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuWizardsText +BackgroundTrans +0x201", % "Wizards"
DllCall("SendMessage", "Ptr", hButtonMenuWizardsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuWizardsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuHistoryN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuHistoryH Hidden1"
Gui Main:  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuHistoryText +BackgroundTrans +0x201", % "History"
DllCall("SendMessage", "Ptr", hButtonMenuHistoryN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuHistoryH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuSettingsN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuSettingsH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuSettingsText +BackgroundTrans +0x201", % "Settings"
DllCall("SendMessage", "Ptr", hButtonMenuSettingsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuSettingsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuLogonN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuLogonH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuLogonText +BackgroundTrans +0x201", % "Logon"
DllCall("SendMessage", "Ptr", hButtonMenuLogonN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuLogonH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuAboutN Hidden0"
Gui Main: Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuAboutH Hidden1"
Gui Main: Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuAboutText +BackgroundTrans +0x201", % "About"
DllCall("SendMessage", "Ptr", hButtonMenuAboutN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
DllCall("SendMessage", "Ptr", hButtonMenuAboutH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui Main: Font ; Reset font options
Gui Main: Add, Text, x39 y65 w47 h23 +Right, Client ID:
Gui Main: Add, Text, x215 y65 w88 h23 +Left, Invoice No.:
Gui Main: Add, Text, x65 y204 w70 h23 +Right, Debt Status:
Gui Main: Add, Text, x269 y204 w42 h23 +Center, Dispute:
Gui Main: Add, Text, x403 y65 w23 h23 +Right, Org:
Gui Main: Add, Edit, x89 y65 w120  vCID, 
Gui Main: Add, Edit, x280 y65 w120 h21 hwndhInvoiceNo vInvoiceNo ,
Gui Main: Add, Edit, x428 y65 w29 h21 vOrg, 
Gui Main: Add, Edit, x75 y177 w390 h21 limit44 vEntLine, 
Gui Main: Add, dropdownlist, x137 y204 w130 vDebtStatus, |DRR - Debtor Response Required|DLS - Letter Sent|DCP - phone contact|DCE - Email sent or received|DCM - Message Left|DFD - Financial Difficulties|DDD - Deceased Estate|DPM - Debtor Payment Made/Claims Paid|PAA - Awaiting payment agreement|PW - Weekly payment agreement|PF  - Fortnightly payment agreement|PM  - Monthly payment agreement|AAR - Awaiting Agency Response|ARS - Return to Sender|ADS - Disputed Account|AHD - Account on Hold|AWS - Suggested Write Off|MAC - Australian Credit Management|MTD - Territory Debt Collectors|MWK - Ward Keller
Gui Main: Add, dropdownlist, x311 y204 w32 vDispute, ||N|Y
Gui Main: Add, Edit, x75 y261 w390 h21 vAR810Line1 limit55, 
Gui Main: Add, Edit, x75 y286 w390 h21 vAR810Line2 limit55, 
Gui Main: Add, Edit, x75 y311 w390 h21 vAR810Line3 limit55, 
Gui Main: Add, Edit, x75 y337 w390 h21 vAR810Line4 limit55, 
Gui Main: Add, Edit, x75 y363 w269 h21 vAR810Line5 limit55, 
Gui Main: Add, Button, x346 y203 w120 h23 gMenuHandler, Write AR525
Gui Main: Add, Button, x348 y362 w118 h23 gMenuHandler, Write AR810
Gui Main: Add, Button, x9 y112 w120 h23 gMenuHandler, View AR810
Gui Main: Add, Button, x134 y112 w120 h23 +default gMenuHandler, View AR525
Gui Main: Add, Button, x259 y112 w120 h23 gMenuHandler, View AR525O
Gui Main: Add, Button, x382 y112 w150 h23 gMenuHandler, View All
Gui Main: Add, Button, x459 y65 w44 h23 gMenuHandler, Paste
Gui Main: Add, GroupBox, x5 y47 w535 h50, Load Client Detials:
Gui Main: Add, GroupBox, x5 y97 w535 h50, Navigation:
Gui Main: Add, GroupBox, x5 y149 w535 h89, AR525 Screen:
Gui Main: Add, GroupBox, x6 y242 w535 h157, AR810 Notes Screen:
Gui Main: Show, % " w" Window.Width " h" Window.Height, GAS Notes Wizard

;WM_CONTROLS AND ON MESSAGE ==============================================================================

OnMessage(0x200, "WM_MOUSEMOVE")
;OnMessage(0x201, "WM_LBUTTONDOWN")
OnMessage(0x202, "WM_LBUTTONUP")
;OnMessage(0x2A3, "WM_MOUSELEAVE")
VarSetCapacity(TME, 16, 0), NumPut(16, TME, 0), NumPut(2, TME, 4), NumPut(hGui1, TME, 8)

;Menus ==============================================================================
Menu, FileMenu, Add, Reload Toolbar, ContextMenuHandler
Menu, FileMenu, Add, Toggle AlwaysOnTop, ContextMenuHandler
Menu, FileMenu, Add, Toggle AR810 Multi-Line Paste, ContextMenuHandler
Menu, FileMenu, Check, Toggle AlwaysOnTop
Menu, FileMenu, Add ; Separator
Menu, EditMenu, Add, Titlecase from Clipboard, ContextMenuHandler
Menu, EditMenu, Add, Uppercase from Clipboard, ContextMenuHandler
Menu, EditMenu, Add, Lowercase from Clipboard, ContextMenuHandler
Menu, EditMenu, Add, Remove Symbols from Clipboard, ContextMenuHandler
Menu, EditMenu, Add, Remove Formatting from Clipboard, ContextMenuHandler
Menu, WizardsMenu, Add, Instalment Letter, ContextMenuHandler
Menu, WizardsMenu, Add, Courtesy Letter, ContextMenuHandler
Menu, WizardsMenu, Add, Conditional Formatting, ContextMenuHandler
Menu, WizardsMenu, Add, Create Email with Invoice, ContextMenuHandler
Menu, SettignsMenu, Add,

Exit


MenuHandler:
MsgBox % A_GuiControl
Return
ContextMenuHandler:
MsgBox % A_ThisMenuItem 
Return


WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) 
{
	Global
	DllCall("TrackMouseEvent", "UInt", &TME)
	MouseGetPos,,,, MouseCtrl, 2
	GuiControl, % (MouseCtrl = hButtonMenuFileText) ? "Show" : "Hide", % hButtonMenuFileH
	GuiControl, % (MouseCtrl = hButtonMenuEditText) ? "Show" : "Hide", % hButtonMenuEditH
	GuiControl, % (MouseCtrl = hButtonMenuWizardsText) ? "Show" : "Hide", % hButtonMenuWizardsH
	GuiControl, % (MouseCtrl = hButtonMenuHistoryText) ? "Show" : "Hide", % hButtonMenuHistoryH
	GuiControl, % (MouseCtrl = hButtonMenuSettingsText) ? "Show" : "Hide", % hButtonMenuSettingsH
	GuiControl, % (MouseCtrl = hButtonMenuLogonText) ? "Show" : "Hide", % hButtonMenuLogonH
	GuiControl, % (MouseCtrl = hButtonMenuAboutText) ? "Show" : "Hide", % hButtonMenuAboutH
}

WM_LBUTTONUP(wParam, lParam, Msg, Hwnd) {
	Global
	If (MouseCtrl = hButtonMenuFileText) {
		ControlGetPos, ctlX, ctlY, ctlW, ctlH, , ahk_id %hButtonMenuFileText%
		Menu, FileMenu, Show, %ctlX%, % ctlY + ctlH
	} Else If (MouseCtrl = hButtonMenuEditText) {
		ControlGetPos, ctlX, ctlY, ctlW, ctlH, , ahk_id %hButtonMenuEditText%
		Menu, EditMenu, Show, %ctlX%, % ctlY + ctlH
	} Else If (MouseCtrl = hButtonMenuWizardsText) {
		ControlGetPos, ctlX, ctlY, ctlW, ctlH, , ahk_id %hButtonMenuToolsText%
		Menu, WizardsMenu, Show, %ctlX%, % ctlY + ctlH
	}
	
}

CreateDIB(Input, W, H, ResizeW := 0, ResizeH := 0, Gradient := 1 ) 
{
	_WB := Ceil((W * 3) / 2) * 2, VarSetCapacity(BMBITS, (_WB * H) + 1, 0), _P := &BMBITS
	Loop, Parse, Input, |
	{
		_P := Numput("0x" . A_LoopField, _P + 0, 0, "UInt") - (W & 1 && Mod(A_Index * 3, W * 3) = 0 ? 0 : 1)
	}
	hBM := DllCall("CreateBitmap", "Int", W, "Int", H, "UInt", 1, "UInt", 24, "Ptr", 0, "Ptr")
	hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2008, "Ptr")
	DllCall("SetBitmapBits", "Ptr", hBM, "UInt", _WB * H, "Ptr", &BMBITS)
	If (Gradient != 1) {
		hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x0008, "Ptr")
	}
	return DllCall("CopyImage", "Ptr", hBM, "Int", 0, "Int", ResizeW, "Int", ResizeH, "Int", 0x200C, "UPtr")
}
