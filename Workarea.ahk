	OnExit("Exit","-1")
	BuildMenu()
	WorkArea(0, 58, 1240, 873)
	SetTimer, ToolbarGUIcol, 200
	Gui,  -Resize -Caption -Border +HWNDhGui2 +ToolWindow  -SysMenu +AlwaysOnTop  
	Gui, Add, Text, % " x" 0 " y" 0 " w" 1 " h" 876 " +0x4E +HWNDhBorderLeft"
	Gui, Add, Text, % " x" 199-1 " y" 0 " w" 1 " h" 876 " +0x4E +HWNDhBorderRight"
	Gui, Add, Text, % "x" 1 " y" 876-1 " w" 199-2 " h" 1 " +0x4E +HWNDhBorderBottom"
	DllCall("SendMessage", "Ptr", hBorderLeft, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0072C6", 1, 1))
	DllCall("SendMessage", "Ptr", hBorderRight, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0072C6", 1, 1))
	DllCall("SendMessage", "Ptr", hBorderBottom, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0072C6", 1, 1))

		
	Gui Color, FFFFFF
	
	Gui, Add, Picture, x0 y0 w199 h65 +BackgroundTrans  +0x4E +HWNDhGUIBG_TOP2,
	DllCall("SendMessage", "Ptr", hGUIBG_TOP2, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))

	Gui, Add, Edit, x6 y67 w188 h21  +Center gContextMenuHandler vActive_AGS, asd
	Gui, Add, Button, x6 y90 w189 h23  gContextMenuHandler vsssssss, Load AGS
	Gui, Add, Button, x6 y115 w140 h23  gContextMenuHandler, Generate Subject Line
	Gui, Add, Button, x+3 y115  w46 h23  gContextMenuHandler, ↓
	Gui, Add, Button, x17 y159 w165 h23  gContextMenuHandler, Prepare Paid Due Diff
	Gui, Add, Button, x17 y184 w165 h23  gContextMenuHandler, Process Workbook
	Gui, Add, Button, x17 y209 w165 h23 gContextMenuHandler, Refresh from Workbook
	Gui, Add, Button, x17 y234 w165 h23  gContextMenuHandler, Create ePOD Record
	Gui, Add, Button, x17 y259 w165 h23  gContextMenuHandler, Adjust Cumlative Totals
	Gui, Add, Button, x17 y284 w165 h23  gContextMenuHandler, Enter Recovery Action
	Gui, Add, GroupBox, x6 y730 w190 h92 , Shortcuts
	Gui, Add, Text, x23 y333 w58 h23 , AGS:
	Gui, Add, Text, x23 y393 w58 h23 , Nett:
	Gui, Add, Text, x23 y363 w58 h23 , Tax:
	Gui, Add, Text, x23 y517 w58 h23 , Gross:
	Gui, Add, Text, x23 y423 w58 h23 , Sal Sac:
	Gui, Add, Text, x23 y453 w58 h23 , Deductions:
	Gui, Add, Text, x23 y483 w58 h23 , Super:
	Gui, Add, GroupBox, x6 y140 w186 h175 , Workbook Helper
	Gui, Add, Edit, x84 y333 w82 h21 vAGS,
	Gui, Add, Edit, x84 y363 w82 h23 vTax_Active, 
	Gui, Add, Edit, x84 y393 w82 h23 vNett_Active, 
	Gui, Add, Edit, x84 y423 w82 h23 vSal_Sac_Active, 
	Gui, Add, Edit, x84 y453 w82 h23 vDeductions_Active, 
	Gui, Add, Edit, x84 y483 w82 h23 vSuper_Active, 
	Gui, Add, Edit, x84 y517 w82 h23 vGross_Active,  
	Gui, Add, GroupBox, x6 y316 w187 h290 , Workbook Info
	Gui, Add, Text, x23 y549 w58 h23 , Prev Super:
	Gui, Add, Edit, x85 y547 w82 h23 vPrevSuper, 
	Gui, Add, Button, x131 y575 w36 h23 gContextMenuHandler, Clear
	Gui, Add, GroupBox, x6 y605 w187 h115 , Quick Notes
	Gui, Add, Edit, x8 y619 w180 h92  vNotes -E0x200, 
	Gui, Add, Button, x8 y747 w45 h23 gContextMenuHandler, Recent
	Gui, Add, Button, x+2 y747 w45 h23 gContextMenuHandler, ePOD
	Gui, Add, Button, x+2 y747 w45 h23 gContextMenuHandler, PIPS
	Gui, Add, Button, x+2 y747 w45 h23 gContextMenuHandler, F:\
	Gui, Add, Button, x8 y771 w45 h23 gContextMenuHandler, Chrome
	Gui, Add, Button, x+2 y771 w45 h23 gContextMenuHandler, Phones
	Gui, Add, Button, x+2 y771 w45 h23 gContextMenuHandler, myHR
	Gui, Add, Button, x+2 y771 w45 h23 gContextMenuHandler, GovAcc
	Gui, Add, Button, x8 y795 w45 h23 gContextMenuHandler, VarDB
	Gui, Add, Button, x+2 y795 w45 h23 gContextMenuHandler, Q-Mast
	Gui, Add, Button, x+2 y795 w45 h23 gContextMenuHandler,  LogJob
	Gui, Add, Button, x+2 y795 w45 h23 gContextMenuHandler,  FileNote

	Gui, Show, x1240 y-5 w199 h800, 


	Gui New


	Gui, -Resize -Caption -Border +HWNDhGui1 +ToolWindow  -SysMenu +AlwaysOnTop  
	Gui, Add, Picture, x0 y0 w1240 h65 +BackgroundTrans  +0x4E +HWNDhGUIBG_TOP vGUIBG_TOP,
	DllCall("SendMessage", "Ptr", hGUIBG_TOP, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	gui, Color, 0173C7

	; Window Menu Button
	Gui   Font, s9 cFFFFFF, Segoe UI ; Set font options y36
	Gui  Add, Picture, % " x" 2 " y" 15 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuFileN Hidden0"
	Gui   Add, Picture, % " x" 2 " y" 15 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuFileN Hidden0"
	
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuFileH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuFileText +BackgroundTrans +0x201", % "File"
	DllCall("SendMessage", "Ptr", hButtonMenuFileN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuFileH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuEditN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuEditH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuEditText +BackgroundTrans +0x201", % "Edit"
	DllCall("SendMessage", "Ptr", hButtonMenuEditN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuEditH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuWizardsN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuWizardsH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuWizardsText +BackgroundTrans +0x201", % "Wizards"
	DllCall("SendMessage", "Ptr", hButtonMenuWizardsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuWizardsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuHistoryN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuHistoryH Hidden1"
	Gui   Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuHistoryText +BackgroundTrans +0x201", % "History"
	DllCall("SendMessage", "Ptr", hButtonMenuHistoryN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuHistoryH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuSettingsN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuSettingsH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuSettingsText +BackgroundTrans +0x201", % "Settings"
	DllCall("SendMessage", "Ptr", hButtonMenuSettingsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuSettingsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuLogonN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuLogonH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuLogonText +BackgroundTrans +0x201", % "Logon"
	DllCall("SendMessage", "Ptr", hButtonMenuLogonN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuLogonH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
	
	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuAboutN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuAboutH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuAboutText +BackgroundTrans +0x201", % "About"
	DllCall("SendMessage", "Ptr", hButtonMenuAboutN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuAboutH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

	Gui  Add, Picture, % " x+" 2 " yp" 0 " w" 60 " h" 24 " +0x4E +HWNDhButtonMenuToolsN Hidden0"
	Gui  Add, Picture, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +0x4E +HWNDhButtonMenuToolsH Hidden1"
	Gui  Add, Text, % " xp" 0 " yp" 0 " wp" 0 " hp" 0 " +HWNDhButtonMenuToolsText +BackgroundTrans +0x201", % "Tools"
	DllCall("SendMessage", "Ptr", hButtonMenuToolsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	DllCall("SendMessage", "Ptr", hButtonMenuToolsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

	Gui, show, x0 y0 h58


	OnMessage(0x200, "WM_MOUSEMOVE")
	OnMessage(0x201, "WM_LBUTTONDOWN")
	OnMessage(0x202, "WM_LBUTTONUP")
	OnMessage(0x2A3, "WM_MOUSELEAVE")
Return



WorkArea(lm,tm,rm,bm) {

    VarSetCapacity(area, 16, 0 )
    NumPut(lm,area,0,"UInt"), NumPut(tm,area,4,"UInt"), NumPut(rm,area,8,"UInt"), NumPut(bm,area,12,"UInt")
    DllCall("SystemParametersInfo","uint",0x2F,"uint",0,"UPtr",&area,"uint",0) ;SPI_SETWORKAREA
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

Exit(msg) {
	SysGet, Mon2, Monitor, 1
	;MsgBox, Left: %Mon2Left% -- Top: %Mon2Top% -- Right: %Mon2Right% -- Bottom %Mon2Bottom%.
	WorkArea(Mon2Left, Mon2Top, Mon2Right, Mon2Bottom)

}

WM_MOUSELEAVE(wParam, lParam, Msg, Hwnd) {
	Global

}

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
	GuiControl, % (MouseCtrl = hButtonMenuToolsText) ? "Show" : "Hide", % hButtonMenuToolsH

}

WM_LBUTTONDOWN(wParam, lParam, Msg, Hwnd) {
	;MsgBox % wParam ", " lParam ", " Msg ", " Hwnd
	return
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
		ControlGetPos, ctlX, ctlY, ctlW, ctlH, , ahk_id %hButtonMenuWizardsText%
		Menu, WizardsMenu, Show, %ctlX%, % ctlY + ctlH
	} Else If (MouseCtrl = hButtonMenuHistoryText) {


	} Else If (MouseCtrl = hButtonMenuLogonText) {
	

	}
	Else If (MouseCtrl = hButtonMenuSettingsText) {

		
	}
	Else If (MouseCtrl = hButtonMenuAboutText) {


	}
	Else If (MouseCtrl = hButtonMenuToolsText) {
		ControlGetPos, ctlX, ctlY, ctlW, ctlH, , ahk_id %hButtonMenuToolsText%
		Menu, ToolsMenu, Show, %ctlX%, % ctlY + ctlH

	}

	
}

BuildMenu()
{
	
	Menu, FileMenu, Add, Reload Toolbar, ContextMenuHandler
	Menu, FileMenu, Add, Toggle AlwaysOnTop, ContextMenuHandler
	Menu, FileMenu, Add, Toggle AR810 Multi-Line Paste, ContextMenuHandler
	Menu, FileMenu, Check, Toggle AlwaysOnTop
	Menu, FileMenu, Add  
	Menu, FileMenu, Add, Close GAS Notes, ContextMenuHandler

	Menu, EditMenu, Add, Titlecase from Clipboard, ContextMenuHandler
	Menu, EditMenu, Add, Uppercase from Clipboard, ContextMenuHandler
	Menu, EditMenu, Add, Lowercase from Clipboard, ContextMenuHandler
	Menu, EditMenu, Add, Remove Symbols from Clipboard, ContextMenuHandler
	Menu, EditMenu, Add, Remove Formatting from Clipboard, ContextMenuHandler

	Menu, WizardsMenu, Add, Instalment Letter, ContextMenuHandler
	Menu, WizardsMenu, Add, Courtesy Letter, ContextMenuHandler
	Menu, WizardsMenu, Add, Conditional Formatting, ContextMenuHandler
	Menu, WizardsMenu, Add, GAS Notes Wizard, ContextMenuHandler
	Menu, WizardsMenu, Add, Register New Jobs Tool,ContextMenuHandler
	Menu, WizardsMenu, Add, Mercantile Checklist Tool,ContextMenuHandler

	Menu, ToolsMenu, Add, ACC Path Finder,ContextMenuHandler
	Menu, ToolsMenu, Add, Code QuickTester,ContextMenuHandler
	Menu, ToolsMenu, Add, Get Text Under Mouse,ContextMenuHandler
	Menu, ToolsMenu, Add, Invoice Builder,ContextMenuHandler
	Menu, ToolsMenu, Add, GAS Notes (OLD),ContextMenuHandler
	Menu, ToolsMenu, Add, Windows Message Spy,ContextMenuHandler
}

ContextMenuHandler(hwnd, GuiEvent, EventInfo) {
;MsgBox % hwnd ", " GuiEvent ", " EventInfo
ControlGetText, Name_from_Hwnd,, ahk_id %hwnd%
;MsgBox % Name_from_Hwnd

}

ToolbarGUIcol() {
	Global
	OldClass := Class
	WinGetClass, class, A

	If (OldClass = class) {
		if (class = "XLMAIN") 
		{
			Gui %hGui1%:Default
			DllCall("SendMessage", "Ptr", hGUIBG_TOP, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("227447", 1, 1))
			DllCall("SendMessage", "Ptr", hButtonMenuFileN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("227447", 1, 1))
			DllCall("SendMessage", "Ptr", hButtonMenuFileH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("439467", 1, 1))

			Gui %hGui2%:Default
			DllCall("SendMessage", "Ptr", hGUIBG_TOP2, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("227447", 1, 1))
		}
		if (class = "rctrl_renwnd32")
		{
			Gui %hGui1%:Default
			DllCall("SendMessage", "Ptr", hGUIBG_TOP, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
			DllCall("SendMessage", "Ptr", hButtonMenuFileN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
			DllCall("SendMessage", "Ptr", hButtonMenuFileH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
			GuiControl, MoveDraw, % hButtonMenuFileN
		
			Gui %hGui2%:Default
			DllCall("SendMessage", "Ptr", hGUIBG_TOP2, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
		}
	}
}



Toolbar_Colour_Changer(Gui, Control, Colour) {
Gui %Gui%:Default
DllCall("SendMessage", "Ptr", Control, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB(Colour, 1, 1))
}