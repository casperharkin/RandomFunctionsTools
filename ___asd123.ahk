#Persistent

global _CURSORAREA, Obj := {}

Gui New, +LastFound +HwndGuiHwnd 
c := 1
loop 3
{
	AddControl("Text", "Text" . A_Index, "", "Bar","Hello world!")
    loop 3
    	gui, add, edit
}
AddControl("Text", "TextMain", " y+15 xs w300 h100 0x8 ", "Foo", "")

VarSetCapacity(TME, 16, 0), NumPut(16, TME, 0), NumPut(2, TME, 4), NumPut(hGui1, TME, 8)

Gui Show

OnMessage(0x200, "WM_MOUSEMOVE") ; WM_MOUSEMOVE
img1 := "C:\Windows\Cursors\aero_move_xl.cur", img2 := "C:\Windows\Cursors\aero_unavail.cur"
hCur := DllCall("User32\LoadImageW", "Uint",0, "Ptr",&img1, "Uint",0x1, "int",0, "int",0, "Uint",0x10)
hCurOn := DllCall("LoadImageW", "Uint", 0, "Ptr", &img2, "Uint", 0x1, "int", 0, "int", 0, "Uint", 0x10)


return
;---------------------------------------


WM_MOUSEMOVE(wParam, lParam, msg, hWnd){
	Global


	DllCall("TrackMouseEvent", "UInt", &TME)
	MouseGetPos,,,, MouseCtrl, 2
    s := (MouseCtrl = Obj["TextMain"]["Handle"]) ? DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", hWnd, "Ptr",-12, "Ptr", hCur) : DllCall("User32\SetClassLong" (A_PtrSize = 8 ? "Ptr" : ""), "Ptr", hWnd, "Ptr",-12, "Ptr", 0x10)
	MouseGetPos,,,, MouseCtrl,
	
}

AddControl(ControlType, Name_Control, Options := "", Function := "", Value := ""){
	Static
	Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%, %Value%
	Handle_Control := h%Name_Control%
	Obj[Name_Control, "Handle"] := Handle_Control
	ControlHandler := Func(Function).Bind(Obj[Name_Control, "Handle"])
	GuiControl +g, %Handle_Control%, %ControlHandler%
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