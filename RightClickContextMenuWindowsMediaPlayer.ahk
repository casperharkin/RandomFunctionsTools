#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu ContextMenu, Add, Mini Player Mode, MenuHandler
Menu ContextMenu, Check, Mini Player Mode
Menu ContextMenu, Add, Select File, MenuHandler
Menu ContextMenu, Add, Close WMP Instance, MenuHandler

OnMessage(0x202, "WM_LBUTTONUP")
Exit

MenuHandler:

Return




	WM_LBUTTONUP(wParam, lParam, Msg, Hwnd) {
		DllCall("TrackMouseEvent", "UInt", &TME)
		MouseGetPos,,,, MouseCtrl, 2
		If (MouseCtrl = __Handles.hButtonMenuFileText) {
			ControlGetPos, ctlX, ctlY, ctlW, ctlH, , % "ahk_id " __Handles.hButtonMenuFileText
			Menu ContextMenu, Show %ctlX%, % ctlY + ctlH


}