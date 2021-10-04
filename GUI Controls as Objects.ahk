#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global _Controls := {}




Construct_GUI()
Exit

Construct_GUI(){
GUIOBJ()

		Gui,Main:+HwndhGUI

	For Each, Item in _Controls	{

		Gui,Main: Font,, % _Controls[Each]["Font_Name"]
		Gui,Main: Font, % _Controls[Each]["Font_Size"] 

		Gui,Main: Add, Picture, % _Controls[Each]["Options"] " +BackgroundTrans +0x4E +HWNDh" _Controls[Each]["Name"] "N Hidden0" 
		Gui,Main: Add, Picture, % _Controls[Each]["Options"] " +BackgroundTrans +0x4E +HWNDh" _Controls[Each]["Name"] "H Hidden1" 
		Gui,Main: Add, % _Controls[Each]["Type"], % _Controls[Each]["Options"]  " BackgroundTrans 0x200 +HWNDh" _Controls[Each]["Name"] "U Hidden0", % _Controls[Each]["Value"]

		Gui,Main: Font,
		
		This := _Controls[Each]["Name"]
		_Controls[Each]["Hwnd_Normal"] := h%This%N
		_Controls[Each]["Hwnd_Hover"]  := h%This%H
		_Controls[Each]["Hwnd_Under"]  := h%This%U

		If (_Controls[Each]["DIB"] != "") {
			DllCall("SendMessage", "Ptr", h%This%N, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB(StrSplit(_Controls[Each]["DIB"],"|").1, 1, 1))
		 	DllCall("SendMessage", "Ptr", h%This%H, "UInt", 0x172, "Ptr", 0, "Ptr", CreateDIB(StrSplit(_Controls[Each]["DIB"],"|").2, 1, 1))
		}

		ControlHandler := Func("Process_String").Bind(h%This%U)
		GuiControl +g, % h%This%U, % ControlHandler
	}

	VarSetCapacity(tme,16,0)
	NumPut(16,tme,0), NumPut(2,tme,4), NumPut(hGUI,tme,8)

	OnMessage(0x200, "WM_MOUSEMOVE")
	Gui,Main: Show, w339 h538 , Calculator 
}

Process_String(){
	MsgBox % A_GuiControl
}

WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {

	global tme
	DllCall( "TrackMouseEvent","uint",&tme )

	MouseGetPos,,,id, MouseCtrl, 2
	WinGetTitle, title, ahk_id %id%

	GuiControl, % (MouseCtrl = _Controls["Button_Close"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Close"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_menu"]["Hwnd_Under"]) 	? "Show" : "Hide", % _Controls["Button_menu"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Close"]["Hwnd_Under"]) ? "Show" : "Hide", % GUI["Close"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_History"]["Hwnd_Under"]) ? "Show" : "Hide", % GUI["History"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_M_Plus"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_M_Plus"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_MC"]["Hwnd_Under"]) 	? "Show" : "Hide", % _Controls["Button_MC"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_MR"]["Hwnd_Under"]) 	? "Show" : "Hide", % _Controls["Button_MR"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_M_Minus"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_M_Minus"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_MS"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_MS"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_M_Dot"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_M_Dot"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Delete"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Delete"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_C"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_C"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_CE"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_CE"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Perc"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Perc"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_1byx"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_1byx"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_2x"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_2x"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_sqr"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_sqr"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Div"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Div"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_7"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_7"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_8"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_8"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_9"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_9"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Mult"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Mult"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_4"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_4"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_5"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_5"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_6"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_6"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Sub"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_Sub"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_1"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_1"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_2"]["Hwnd_Under"]) ? "Show" : "Hide", % _Controls["Button_2"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_3"]["Hwnd_Under"]) 	? "Show" : "Hide", % _Controls["Button_3"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Add"]["Hwnd_Under"])	? "Show" : "Hide", % _Controls["Button_Add"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_AddMinus"]["Hwnd_Under"])	? "Show" : "Hide", % _Controls["Button_AddMinus"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_0"]["Hwnd_Under"])	? "Show" : "Hide", % _Controls["Button_0"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Dot"]["Hwnd_Under"])	? "Show" : "Hide", % _Controls["Button_Dot"]["Hwnd_Hover"]
	GuiControl, % (MouseCtrl = _Controls["Button_Enter"]["Hwnd_Under"])	? "Show" : "Hide", % _Controls["Button_Enter"]["Hwnd_Hover"]
	SetTimer,MouseLeave,On
}

MouseLeave(){
	MouseGetPos,,,id, MouseCtrl, 2
	WinGetTitle, title, ahk_id %id%
	if (title != "Calculator")
			For Each, Item in _Controls
				GuiControl, Hide, % _Controls[Each]["Hwnd_Hover"]
	SetTimer,MouseLeave,Off
}

CreateDIB(Input, W, H, ResizeW := 0, ResizeH := 0, Gradient := 1 ) {
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

GUIOBJ(){

	_Controls.Button_StaticTitle := { "Type":"Text"
									, "Name": "StaticTitle"
									, "Options":  " x12 y7 w250 h16 "
									, "Value": "Calculator"
									, "DIB": 
									, "Font_Size": " s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Menu  :=    	{ "Type":"Text"
									, "Name": "Menu"
									, "Options":  " x8 y35 w32   +Center "
									, "Value":  Chr(0xE8C4)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": " s25"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_History  :=    { "Type":"Text"
									, "Name": "History"
									, "Options":  " x300 y45 w32 +Center  "
									, "Value": Chr(0xE81C)
									, "DIB": "E6E6E6|E81123"
									, "Font_Size": "s18"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Close  :=    	{ "Type":"Text"
									, "Name": "Close"
									, "Options":  " x312 y0 w28 h28  +Center "
									, "Value": Chr(0xEF2C)
									, "DIB": "E6E6E6|E81123"
									, "Font_Size": "s18"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Edit  :=    	{ "Type":"Edit"
									, "Name": "Edit"
									, "Options":  " x14 y90 w310 h75  12 +readonly +0x4E 0x802 -E0x200 +Cener -VScroll "
									, "Value": "00000"
									, "DIB": 
									, "Font_Size": "Bold s50"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	
	_Controls.Button_MC  :=    		{ "Type":"Text"
									, "Name": "MC"
									, "Options":  "x16 y175 w48 h20 +Disabled +Center "
									, "Value": "MC"
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_MR  :=    		{ "Type":"Text"
									, "Name": "MR"
									, "Options":  "x68 y175 w48 h20 +Disabled +Center "
									, "Value": "MR"
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13 Bold"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_M_Plus  :=    	{ "Type":"Text"
									, "Name": "M_Plus"
									, "Options":  "x120 y175 w49 h20 +Center "
									, "Value": "M+"
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_M_Minus  :=    { "Type":"Text"
									, "Name": "M_Minus"
									, "Options":  " x173 y175 w48 h20 +Center "
									, "Value": "M-"
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_MS  :=    		{ "Type":"Text"
									, "Name": "MS"
									, "Options":  "x223 y175 w48 h20 +Center "
									, "Value": "Ms"
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_M_Dot  :=    	{ "Type":"Text"
									, "Name": "M_Dot"
									, "Options":  "x274 y175 w48 h20 +Disabled +Center "
									, "Value": "M."
									, "DIB": "E6E6E6|C7C7C7"
									, "Font_Size": "s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	
	
	_Controls.Button_Perc  :=    	{ "Type":"Text"
									, "Name": "Perc"
									, "Options": "x14 y208 w75 h49 +Center "
									, "Value":  Chr(0xE94C)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_CE  :=    		{ "Type":"Text"
									, "Name": "CE"
									, "Options": "x92 y208 w75 h49 +Center "
									, "Value":  "CE"
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_C  :=    		{ "Type":"Text"
									, "Name": "C"
									, "Options": "x170 y208 w75 h49 +Center  "
									, "Value":  "C"
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Delete  :=    	{ "Type":"Text"
									, "Name": "Delete"
									, "Options": " x250 y208 w74 h49 +Center "
									, "Value":  Chr(0xE94F)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_1byx  :=    	{ "Type":"Text"
									, "Name": "1byx"
									, "Options":  "x13 y261 w75 h49 +Center "
									, "Value":  Chr(0xF7C9)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_2x  :=    		{ "Type":"Text"
									, "Name": "2x"
									, "Options":  "x92 y261 w75 h49 +Center "
									, "Value":  "x2"
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_sqr  :=    	{ "Type":"Text"
									, "Name": "sqr"
									, "Options":  "x171 y261 w75 h49 +Center "
									, "Value":  Chr(0x221A)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Div  :=    	{ "Type":"Text"
									, "Name": "Div"
									, "Options":  " x250 y261 w74 h49 +Center "
									, "Value":  Chr(0xE94A)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_7  :=    	{ "Type":"Text"
									, "Name": "7"
									, "Options": " x13 y314 w75 h49 +Center  "
									, "Value":  "7"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_8  :=    		{ "Type":"Text"
									, "Name": "8"
									, "Options": " x92 y314 w75 h49 +Center  "
									, "Value":  "8"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_9  :=    		{ "Type":"Text"
									, "Name": "9"
									, "Options": " x171 y314 w75 h49 +Center  "
									, "Value":"9"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Mult  :=    	{ "Type":"Text"
									, "Name": "Mult"
									, "Options": " x249 y314 w75 h49 +Center  "
									, "Value":  Chr(0xE947)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_4  :=    		{ "Type":"Text"
									, "Name": "4"
									, "Options": "x12 y367 w75 h49 +Center  "
									, "Value":  "4"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_5  :=    		{ "Type":"Text"
									, "Name": "5"
									, "Options": " x92 y367 w75 h49 +Center  "
									, "Value":  "5"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_6  :=    		{ "Type":"Text"
									, "Name": "6"
									, "Options": " x171 y367 w75 h49 +Center  "
									, "Value":  "6"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Sub  :=    	{ "Type":"Text"
									, "Name": "Sub"
									, "Options": " x250 y367 w74 h49 +Center  "
									, "Value":  Chr(0xE949)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_1  :=    		{ "Type":"Text"
									, "Name": "1"
									, "Options":  "x13 y420 w75 h49 +Center  "
									, "Value":  "1"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_2  :=    		{ "Type":"Text"
									, "Name": "2"
									, "Options":  "x92 y420 w75 h49 +Center  "
									, "Value":  "2"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_3  :=    		{ "Type":"Text"
									, "Name": "3"
									, "Options": " x171 y420 w75 h49 +Center  "
									, "Value":  "3"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "Bold s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Add  :=    	{ "Type":"Text"
									, "Name": "Add"
									, "Options": " x250 y420 w75 h49 +Center  "
									, "Value":  Chr(0xE948)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_AddMinus  :=    	{ "Type":"Text"
									, "Name": "AddMinus"
									, "Options":  " x13 y472 w75 h49 +Center  "
									, "Value":  Chr(0xE94D)
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name": "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	
	_Controls.Button_0 := 		    { "Type":"Text"
									, "Name": "Button_0"
									, "Options":  "x92 y473 w75 h48 +Center  "
									, "Value": "0"
									, "DIB": "F7F7F7|C7C7C7"
									, "Font_Size": "s16"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	
	
	_Controls.Button_Dot  :=    	{ "Type":"Text"
									, "Name": "Dot"
									, "Options":  "x171 y473 w75 h48 +Center  "
									, "Value":  "."
									, "DIB": "F1F1F1|C7C7C7"
									, "Font_Size": "  s13"
									, "Font_Name":  "Segoe MDL2 Assets"
									, "Font_Bold":"True"}
	
	_Controls.Button_Enter  :=    	{ "Type":"Text"
									, "Name": "Button_Enter"
									, "Options":  "x250 y472 w75 h49 +Center  "
									, "Value":  Chr(0xE94E)
									, "DIB": "8ABAE0|4599DB"
									, "Font_Size": " Default s13"
									, "Font_Name": "Calculator MDL2 Assets"
									, "Font_Bold":"True"}
}

