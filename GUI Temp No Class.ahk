#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global GuiObj := {}, TME
CreateToolbar() ;Build the toolbar menu
OnMessage(0x200, "WM_MOUSEMOVE") ;Check Mouse everytime it moves
OnMessage(0x202, "WM_LBUTTONUP") ;Check if Toolbar Menu Item Selected
VarSetCapacity(TME, 16, 0), NumPut(16, TME, 0), NumPut(2, TME, 4), NumPut(hGui1, TME, 8) ;Get Address to Store TME Object
CreateGUI() ;Build the GUI
Exit ; End AES

ContextMenuHandler(MenuTitle) {
	MsgBox % MenuTitle
}

WM_LBUTTONUP(wParam, lParam, Msg, Hwnd) {
	DllCall("TrackMouseEvent", "UInt", &TME)
	MouseGetPos,,,, MouseCtrl, 2
	For Each, Control in GuiObj
		If (MouseCtrl = GuiObj[Each, "Handle"]) {
				ControlGetPos, ctlX, ctlY, ctlW, ctlH, , % "ahk_id " GuiObj[Each, "Handle"]
				Menu, % SubStr(Each,11,-1), Show, %ctlX%, % ctlY + ctlH
		}
}

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
	Global
	DllCall("TrackMouseEvent", "UInt", &TME)
	MouseGetPos,,,, MouseCtrl, 2
	GuiControl, % (MouseCtrl = GuiObj["ButtonMenuFileT", "Handle"]) ? "Show" : "Hide", % hButtonMenuFileH
	GuiControl, % (MouseCtrl = GuiObj["ButtonMenuEditT", "Handle"]) ? "Show" : "Hide", % hButtonMenuEditH
	GuiControl, % (MouseCtrl = GuiObj["ButtonMenuViewT", "Handle"]) ? "Show" : "Hide", % hButtonMenuViewH
	GuiControl, % (MouseCtrl = GuiObj["ButtonMenuSettingsT", "Handle"]) ? "Show" : "Hide", % hButtonMenuSettingsH
	GuiControl, % (MouseCtrl = GuiObj["ButtonMenuHelpT", "Handle"]) ? "Show" : "Hide", % hButtonMenuHelpH

;	for each, Item in GuiObj
;	{
;		if (GuiObj["ButtonMenu" SubStr(Each,11,-1) "T", "Handle"] = MouseCtrl) {
;			GuiControl, % (MouseCtrl = GuiObj["ButtonMenu" SubStr(Each,11,-1) "T", "Handle"]) ? "Show" : "Hide", % GuiObj["ButtonMenu" SubStr(Each,11,-1) "H", "Handle"] 
;		}
;	}
}

AddControl(ControlType, Name_Control, Options := "", Function := "", Value := "", DIB := ""){
	Static
	Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%, %Value%
	Handle_Control := h%Name_Control%
	GuiObj[Name_Control, "Handle"] := Handle_Control
	ControlHandler := Func(Function).Bind(GuiObj[Name_Control, "Handle"])
	GuiControl +g, %Handle_Control%, %ControlHandler%

	If (DIB != "")
		DllCall("SendMessage", "Ptr", GuiObj[Name_Control, "Handle"], "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB(DIB, 1, 1))
}

CreateDIB(Input, W, H, ResizeW := 0, ResizeH := 0, Gradient := 1 ) {
	_WB := Ceil((W * 3) / 2) * 2, VarSetCapacity(BMBITS, (_WB * H) + 1, 0), _P := &BMBITS
	Loop, Parse, Input, |
		_P := Numput("0x" . A_LoopField, _P + 0, 0, "UInt") - (W & 1 && Mod(A_Index * 3, W * 3) = 0 ? 0 : 1)
	hBM := DllCall("CreateBitmap", "Int", W, "Int", H, "UInt", 1, "UInt", 24, "Ptr", 0, "Ptr")
	hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2008, "Ptr")
	DllCall("SetBitmapBits", "Ptr", hBM, "UInt", _WB * H, "Ptr", &BMBITS)
	If (Gradient != 1) 
		hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x0008, "Ptr")
	return DllCall("CopyImage", "Ptr", hBM, "Int", 0, "Int", ResizeW, "Int", ResizeH, "Int", 0x200C, "UPtr")
}

CreateToolbar() {
	Static
	Toolbar := ["File", "Edit", "View", "Settings", "Help"]
	Menus 	:= {"File":"New,Open...,Save,Save As...,,Page Setup...,Print...,,Exit"
			  , "Edit": "Undo,,Cut,Copy,Paste,Delete"
			  , "View": "Font,Word Wrap"
			  , "Settings": "Titlecase,Uppercase,Lowercase"
			  , "Help": "About,Help"}

	Gui Font, s9 cFFFFFF, Segoe UI  

	Loop % Toolbar.Length() {
		AddControl("Picture", "ButtonMenu" . Toolbar[A_Index] . "N", (A_Index = 1) ? " x0 yp w65 h24 Hidden0 +0x4E" : " x+ yp w65 h24 Hidden0 +0x4E", "", "","0173C7")
		AddControl("Picture", "ButtonMenu" . Toolbar[A_Index] . "H", " xp yp wp h24 Hidden1 +0x4E", "", "","2A8AD4")
		AddControl("Text"	, "ButtonMenu" . Toolbar[A_Index] . "T", " xp yp wp h24  +BackgroundTrans +0x201 ","", Toolbar[A_Index])
	}

	For each, Item in Menus {
		Array := StrSplit(Item, ",")
			Loop % Array.Length()
				Menu, % each, Add, % Array[A_Index], ContextMenuHandler
	}
}

CreateGUI(){
	Gui Font, cBlack
	Gui Add, Text, x8 y42 w95 h20 +Right +BackgroundTrans +0x201, Client ID:
	Gui Add, Edit, x108 y39 w74 h20
	Gui Add, Button, x185 y38 w124 h22 +BackgroundTrans gContextMenuHandler, Load Client
	Gui Add, Text, x9 y66 w95 h20 +Right +BackgroundTrans +0x201, Client Name:
	Gui Add, Text, x8 y91 w95 h20 +Right +BackgroundTrans +0x201, Address:
	Gui Add, Edit, x108 y63 w201 h20
	Gui Add, Edit, x108 y88 w201 h20
	Gui Add, Edit, x108 y138 w201 h20
	Gui Add, Text, x7 y165 w95 h20 +Right +BackgroundTrans +0x201, City / Town:
	Gui Add, Edit, x108 y163 w201 h20
	Gui Add, Text, x6 y190 w95 h20 +Right +BackgroundTrans +0x201, Phone:
	Gui Add, Text, x6 y216 w95 h20 +Right +BackgroundTrans +0x201, Email:
	Gui Add, Edit, x108 y188 w201 h20
	Gui Add, Edit, x108 y216 w201 h20
	Gui Add, Text, x6 y275 w95 h20 +Right +BackgroundTrans +0x201, Amount:
	Gui Add, Text, x6 y317 w95 h20 +Right +BackgroundTrans +0x201, Description:
	Gui Add, Text, x6 y296 w95 h20 +Right +BackgroundTrans +0x201, Cost Code:
	Gui Add, Edit, x108 y274 w201 h20
	Gui Add, Edit, x108 y296 w201 h20
	Gui Add, Edit, x108 y318 w201 h20
	Gui Add, Edit, x108 y112 w201 h20
	Gui Add, GroupBox, x12 y25 w305 h225 -BackgroundTrans , Client Details:
	Gui Add, GroupBox, x12 y257 w305 h91 -BackgroundTrans , Invoice Details:
	Gui Add, Button, x12 y350 w304 h23 -BackgroundTrans , Process Invoice
	Gui Add, Button, x12 y374 w304 h23 -BackgroundTrans , Process Customer
	Gui, Show, h400  w324, PDR Invoice Wizard
}
