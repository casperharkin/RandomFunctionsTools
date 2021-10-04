#Persistent

global _CURSORAREA, active, changed

Gui New, +LastFound
loop 3
{
    Gui Add, Text,  , Hello world!
	
    loop 3
    Gui Add, Edit, +hwndh%A_Index%
}
Gui Add, Text, y+15 xs w300 h100 0x8 +Hwnd_CURSORAREA gFoo

GuiControl +g, h1, Bar
Gui Show

OnMessage(0x200, "MouseMove") ; WM_MOUSEMOVE

img1 := "C:\Windows\Cursors\aero_move_xl.cur", img2 := "C:\Windows\Cursors\aero_unavail.cur"
global hCur := DllCall("User32\LoadImageW", "Uint",0, "Ptr",&img1, "Uint",0x1, "int",0, "int",0, "Uint",0x10)
    , hCurOn := DllCall("LoadImageW", "Uint", 0, "Ptr", &img2, "Uint", 0x1, "int", 0, "int", 0, "Uint", 0x10)

return
;---------------------------------------


MouseMove(wParam, lParam, msg, hWnd)
{
    if (hWnd = _CURSORAREA && !active && !changed) {
    ; Correct control, not being clicked, cursor wasn't changed yet
        DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", hWnd, "Ptr",-12, "Ptr", hCur)
       changed := true
    }
}

Foo:    
;    active := true
;    ; Do other stuff
;    Tooltip % "Doing stuff"
;
;    DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", _CURSORAREA, "Ptr",-12, "Ptr",hCurOn)
;    KeyWait, LButton, U
;    active := changed := false
;    Tooltip
return

Bar(){
    MsgBox % "Doing bar stuff"
}
return