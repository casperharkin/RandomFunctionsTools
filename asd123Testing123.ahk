#Persistent

global _CURSORAREA, active, changed

Gui New, +LastFound +HwndGUIhWnd
loop 3
{
    Gui Add, Text, gBar, Hello world!
    loop 3
    Gui Add, Edit
}
Gui Add, Text, y+15 xs w300 h100 0x8 +HwndhThe_Text_I_Care_About gFoo

Gui Show

OnMessage(0x200, "MouseMove") ; WM_MOUSEMOVE
VarSetCapacity(TME, 16, 0), NumPut(16, TME, 0), NumPut(2, TME, 4), NumPut(hGui1, TME, 8)

img1 := "C:\Windows\Cursors\aero_move_xl.cur", img2 := "C:\Windows\Cursors\aero_unavail.cur"
global hCur := DllCall("User32\LoadImageW", "Uint",0, "Ptr",&img1, "Uint",0x1, "int",0, "int",0, "Uint",0x10)
    , hCurOn := DllCall("LoadImageW", "Uint", 0, "Ptr", &img2, "Uint", 0x1, "int", 0, "int", 0, "Uint", 0x10)

return
;---------------------------------------


MouseMove(wParam, lParam, msg, hWnd)
{
	global
	DllCall("TrackMouseEvent", "UInt", &TME)
	MouseGetPos,,,, MouseCtrl, 2
	s := (MouseCtrl = hThe_Text_I_Care_About) ? DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", GUIhWnd, "Ptr",-12, "Ptr", hCur) : DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", GUIhWnd, "Ptr",-12, "Ptr", 0x10)
}

Foo:    
    active := true
    ; Do other stuff
    Tooltip % "Doing stuff"

    DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", _CURSORAREA, "Ptr",-12, "Ptr",hCurOn)
    KeyWait, LButton, U
    active := changed := false
    Tooltip
return

Bar:
    ; Whatever
return