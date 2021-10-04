#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
	
	hBitmap := LoadPicture( "user32.dll", "w64 h64 Icon2" )
	Menu, Tray, Icon, user32.dll, 2
	Count := 10
	
	Gui Add, Button, x236 y94 w75 h23 gMenuHand, OK
	Gui Add, Button, x320 y94 w75 h23 gMenuHand, Cancel
	Gui Add, Picture, x20 y23 w64 h64, % "HBITMAP:*" hBitmap
	Gui Add, Text, x90 y23 w318 h41 vStatic, Windows would Shut down Automatically in %Count% Seconds. `n`nPress OK to Shut down immidiately.
	Gui Show, w410 h127, Shutdown
	SetTimer, Countdown, 1000
	Exit
	
	Countdown() {
	Global Count
	Count := Count-1
	Text := "Windows would Shut down Automatically in " . Count . " Seconds. `n`nPress OK to Shut down immidiately."
	GuiControl, , Static, %Text%
		If (Count < 1) {
			SetTimer, Countdown, Off
			Gui, destroy
			MsgBox % "Shutdown, 1"
		}
	}
	
	MenuHand() {
	If (A_GuiControl = "OK") {
			SetTimer, Countdown, Off
			Gui, destroy
			MsgBox % "Shutdown, 1"
		}
	}