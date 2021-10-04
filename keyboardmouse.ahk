#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

		
		Exit ; EOEAS
		
		NumpadLeft::
		NumpadRight::
		NumpadUp::
		NumpadDown::
		
		Loop:
		loop 
		{
			Speed := 2
			r := ""
			KeyIsDown_Array := KeyCheck()
		
			DllCall("mouse_event", "UInt", 0x0001, "Int", "-" . keyIsDown_Array.KeyIsDown_NumpadLeft*Speed, "Int", "-" . KeyIsDown_Array.KeyIsDown_NumpadUp*Speed, "UInt", 0, "UPtr", 0)
			DllCall("mouse_event", "UInt", 0x0001, "Int", KeyIsDown_Array.KeyIsDown_NumpadRight*Speed, "Int", KeyIsDown_Array.KeyIsDown_NumpadDown*Speed, "UInt", 0, "UPtr", 0)
		
			for each, item in KeyIsDown_Array
				{
					r .= item 
					If (r = "0000")
						Break Loop
				}
		}
		return
		
		KeyCheck(){
			Array := {}
			Array.KeyIsDown_NumpadLeft := GetKeyState("NumpadLeft","P")
			Array.KeyIsDown_NumpadRight := GetKeyState("NumpadRight","P")
			Array.KeyIsDown_NumpadUp := GetKeyState("NumpadUp","P")
			Array.KeyIsDown_NumpadDown := GetKeyState("NumpadDown","P")
		Return Array
		}
