#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

		#Persistent
		
		~LButton::
		
		; Get the Y Coord of the mouse
		MouseGetPos, , Start_Y
		
		; Set Timmer to run the DragCheck Sub every 400
		SetTimer, DragCheck, 400
		Exit
		
		DragCheck:
		
		; Checking if the left mouse is being held after the 400 wait
		If (KeyIsDown := GetKeyState("LButton", "P") = 1) {
		
			;Get the new Y Coord of the mouse
			MouseGetPos, , End_Y
		
			; Calc the diff of the start and end Y Coords
			PixelsMoved := Start_Y-End_Y 
			
			; If Mouse has moved downward in the Y axis, run Notepad
			if (PixelsMoved < "-50"){
				Run Notepad
			}
			
		}
		Return