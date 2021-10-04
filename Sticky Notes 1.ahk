#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


GUI, -Toolwindow -Caption +resize

GUI, Add, Picture, Hwndhborder +0x4E x0 y0 w318 h20 -border -VScroll ,
GUI, Add, Text, x0 y0 w318 h20 gMove +BackgroundTrans ,+
	DllCall("SendMessage", "Ptr", hborder, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB("FFF2AB ", 1, 1))

GUI, Add, Edit, HwndhMain -E0x200  -border -VScroll x0 y20 w318 h334, 


Control_Colors(hMain, "Set", RGBtoBGR("0xFFF7D1"), "")
OnMessage(0x0133, "Control_Colors")


GUI, Show, w318
Return

move:
	PostMessage, 0xA1, 2
Return

RGBtoBGR(BkColor){
Return "0x" . SubStr(BkColor, 7, 2) . SubStr(BkColor, 5, 2) . SubStr(BkColor, 3, 2)
}

Control_Colors(wParam, lParam, Msg, Hwnd) {
	   Static Controls := {}

	   If (lParam = "Set") {
	      If !(CtlHwnd := wParam + 0)
	         GuiControlGet, CtlHwnd, Hwnd, %wParam%
	      If !(CtlHwnd + 0)
	         Return False
	      Controls[CtlHwnd, "CBG"] := Msg + 0
	      Controls[CtlHwnd, "CTX"] := Hwnd + 0
	      Return True
	   }

	   ;Critical
	   If (Msg = 0x0133) {
	      If Controls.HasKey(lParam) {
	         If (Controls[lParam].CTX >= 0)
	            DllCall("Gdi32.dll\SetTextColor", "Ptr", wParam, "UInt", Controls[lParam].CTX)
	         DllCall("Gdi32.dll\SetBkColor", "Ptr", wParam, "UInt", Controls[lParam].CBG)
	         Return DllCall("Gdi32.dll\CreateSolidBrush", "UInt", Controls[lParam].CBG)
	      }
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
