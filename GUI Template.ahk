#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Gui, Font, cWhite
Gui, Add, Picture, x10 y10 w70 h50 +BackgroundTrans  +0x4E +HWNDhButtonMenuFileN Hidden0,
DllCall("SendMessage", "Ptr", hButtonMenuFileN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
Gui, Add, Picture, x10 y10 w70 h50  +BackgroundTrans  +0x4E +HWNDhButtonMenuFileH Hidden1,
DllCall("SendMessage", "Ptr", hButtonMenuFileH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
Gui, Add, Picture, x80 y10 w70 h50 +BackgroundTrans +0x4E +HWNDhButtonMenuEditN Hidden0,
DllCall("SendMessage", "Ptr", hButtonMenuEditN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
Gui, Add, Picture, x80 y10 w70 h50 +BackgroundTrans +0x4E +HWNDhButtonMenuEditH Hidden1,
DllCall("SendMessage", "Ptr", hButtonMenuEditH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))
Gui, Add, Picture, x150 y10 w70 h50 +BackgroundTrans +0x4E +HWNDhButtonMenuToolsN Hidden0,
DllCall("SendMessage", "Ptr", hButtonMenuToolsN, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
Gui, Add, Picture, x150 y10 w70 h50 +BackgroundTrans +0x4E +HWNDhButtonMenuToolsH Hidden1,
DllCall("SendMessage", "Ptr", hButtonMenuToolsH, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("2A8AD4", 1, 1))

Gui, Add, Text, x10 y10 w70 h50 +BackgroundTrans +0x201 +Center +HWNDhButtonMenuFileText, `nFile
Gui, Add, Text, x80 y10 w70 h50 +BackgroundTrans +0x201 +Center +HWNDhButtonMenuEditText, `nEdit
Gui, Add, Text, x150 y10 w70 h50 +BackgroundTrans +0x201 +Center +HWNDhButtonMenuToolsText, `nTools
Gui, Font,
Gui, Show, 

OnMessage(0x200, "WM_MOUSEMOVE")
OnMessage(0x201, "WM_LBUTTONUP")
Return


WM_LBUTTONUP(wParam, lParam, Msg, Hwnd) 
{
	Global
	MouseGetPos,,,, MouseCtrl, 2

	If (MouseCtrl = hButtonMenuFileText) 
		MsgBox % "You Clicked the File Button"

	Else if (MouseCtrl = hButtonMenuEditText) 
		MsgBox % "You Clicked the Edit Button"	

	Else if (MouseCtrl = hButtonMenuToolsText) 
		MsgBox % "You Clicked the Tools Button"
}

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) 
{
    Global
		DllCall("TrackMouseEvent", "UInt")
		MouseGetPos,,,, MouseCtrl, 2
			GuiControl, % (MouseCtrl = hButtonMenuFileText) ? "Show" : "Hide", % hButtonMenuFileH
			GuiControl, % (MouseCtrl = hButtonMenuEditText) ? "Show" : "Hide", % hButtonMenuEditH   
			GuiControl, % (MouseCtrl = hButtonMenuToolsText) ? "Show" : "Hide", % hButtonMenuToolsH   
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
