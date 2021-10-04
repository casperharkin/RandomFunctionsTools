#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

	Gui, -Resize -Caption -Border +HWNDhGui1 +ToolWindow  -SysMenu +AlwaysOnTop  
	Gui, Add, Picture, x0 y0 w199 h65 +BackgroundTrans  +0x4E +HWNDhGUIBG_TOP1,
	DllCall("SendMessage", "Ptr", hGUIBG_TOP1, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	Gui, Show

	Gui New
	Gui, -Resize -Caption -Border +HWNDhGui2 +ToolWindow  -SysMenu +AlwaysOnTop  
	Gui, Add, Picture, x0 y0 w199 h65 +BackgroundTrans  +0x4E +HWNDhGUIBG_TOP2,
	DllCall("SendMessage", "Ptr", hGUIBG_TOP2, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("0173C7", 1, 1))
	Gui, Show, x0 y0

Return

q::
	Gui %hGui1%:Default
	DllCall("SendMessage", "Ptr", hGUIBG_TOP1, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("227447", 1, 1))

	Gui %hGui2%:Default
	DllCall("SendMessage", "Ptr", hGUIBG_TOP2, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("227447", 1, 1))

Return

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