	#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
	#Warn  ; Enable warnings to assist with detecting common errors.
	SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
	SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
		
		
		
	New GUI 

	Class GUI 
	{
	
		__New() {
	
			Gui, Add, Edit, HwndMyTextHwnd, Here is some text that is NOT given`na custom background color.
			Gui, Add, Edit, HwndMyEditHwnd wp, Here is some text that is given`na custom background color.
			
			This.Control_Colors(MyEditHwnd, "New", "0xFFBBBB", "0x000000")
			OnMessage(WM_CTLCOLOREDIT := 0x0133, ObjBindMethod(This, "Control_Colors"))
			
			Gui Show, NoActivate 
		}
	
		; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		;      Control_Colors Parameters
		; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; 1: Control_Hwnd := ie. 0x3010b8
		; 2: New_Flag := "New" 
		; 3: Background_Color := ie. "0xFFBBBB"
		; 4: Text_Color := ie. "0x000000"
		; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
		Control_Colors(wParam, lParam, Msg, Hwnd) {  
		   Static Controls := {}
				If (lParam = "New") {
			      	GuiControlGet, CtlHwnd, Hwnd, %wParam%
			      	Controls[CtlHwnd, "ControlBackground"] := Msg + 0
			      	Controls[CtlHwnd, "ControlText"] := Hwnd + 0
			      	Return True
			   	}
		
				Critical
				If (Msg = WM_CTLCOLOREDIT := 0x0133) {
					For Each, Control in Controls
						If (Each = lParam) {
					        If (Controls[lParam].ControlText >= 0)
					            DllCall("Gdi32.dll\SetTextColor", "Ptr", wParam, "UInt", Controls[lParam].ControlText)
	
					        DllCall("Gdi32.dll\SetBkColor", "Ptr", wParam, "UInt", Controls[lParam].ControlBackground)
					        Return DllCall("Gdi32.dll\CreateSolidBrush", "UInt", Controls[lParam].ControlBackground)
						} 
				} 
		} 
	}
	
		
