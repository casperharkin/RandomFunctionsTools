#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Global PathObj := {}
XStepValue := 1 ; X step value ( How many lines to be drawn will be determined by this - Determines the clarity of the line )
XValue := 10 ; Starting X value
VHeight := A_ScreenHeight


CoordMode, Mouse, Screen
MouseGetPos, MX, MY

q::

;MsgBox % "Start:	X: " StartX "	Y: " StartY "`nEnd:	X: " EndX "	Y: " EndY  

Loop 300
{

a := (0-VHeight)/((0-(MX/2))**2) 
Y1 := (-a*((XValue-(MX/2))**2))+VHeight-A_ScreenHeight ; Negative a because of AHKs Y Coordinate system (Higher coordinates = Lower on the screen)

;PathObj.Push(XValue . "|" . Y1)
MouseMove, % XValue, % Y1, 10

PreviousX := XValue
PreviousY := Y1

XValue += XStepValue ; Next value
}






