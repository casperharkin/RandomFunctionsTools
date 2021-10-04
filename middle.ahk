#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



	SysGet, Display_, MonitorCount
	SysGet, Primary_, MonitorPrimary

	Loop % Display_ 
	{
		SysGet, Mon, Monitor, % A_Index
		;MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom%.

		WinGetTitle, windowName, A
		WinGetPos, X, Y, W, H, % windowName

;		if (X > MonLeft) {
;			MsgBox % X " < " MonLeft
;			WinMove, a,, (A_ScreenHeight/2)-(W/2), (A_ScreenHeight/2)-(H/2)
;		}

		if (X < MonRight) and (X > MonLeft){
			MsgBox % X " < " MonRight
			MsgBox, Left: %MonLeft% -- Top: %MonTop% -- Right: %MonRight% -- Bottom %MonBottom%.

			WinMove, a,, (MonRight-MonLeft)-(W/2), (A_ScreenHeight/2)-(H/2)
		}

	}	



Exit
    windowWidth := A_ScreenWidth * 0.5 ; desired width
    windowHeight := A_ScreenHeight * 0.5 ; desired height
    WinGetTitle, windowName, A
    WinMove, A,, A_ScreenWidth/2 - windowWidth/2, A_ScreenHeight/2 - windowHeight/2, windowWidth, windowHeight
