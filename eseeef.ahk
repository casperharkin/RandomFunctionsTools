#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

imageFile := A_Desktop "\Test1.png"

;Top left corner of game !!!(CoordMode = Window)
X1 := 0
Y1 := 0

;Bottom right corner of game !!!(CoordMode = Window)
X2 := 480
Y2 := 1006

NotFound:
WinActivate, ahk_exe chrome.exe
sleep, 300
ImageSearch, foundX, foundY, % X1, % Y1, % X2, % Y2, % imageFile
If (ErrorLevel = 2){
    MsgBox Could not conduct the search.
    Goto NotFound
    }

If (ErrorLevel = 1){
    MsgBox Icon could not be found on the screen.
    Goto NotFound
    }

Else{
	MsgBox Found
;    TrayTip, Found, Found button at`n`nx%foundX% y%foundY%, 5, 1
;    MouseClick, left, 954, 617
;    sleep, 15000     ;waits milliseconds
;    MouseClick, left, 351, 600
;    sleep, 10000     ;waits milliseconds
    Goto NotFound
    }

p::exitapp
Return      ;ends instructions