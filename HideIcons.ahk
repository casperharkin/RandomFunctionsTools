#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force
#Persistent


global hwnd, ico, transp, hwnd2

Gui +LastFound
hWndHookWindow := WinExist()
DllCall("RegisterShellHookWindow", UInt, hWndHookWindow)
MsgNum := DllCall("RegisterWindowMessage", "Str", "SHELLHOOK")					
OnMessage(MsgNum, "ShellMessage")

hwnd:= WinExist("ahk_class Progman")
ControlGet, ico, hwnd,, SysListView321, ahk_id %hwnd%
WinSet, transparent, 255, ahk_id %ico% 
WinHide, ahk_id %ico%
Return

ShellMessage(wParam, lParam)
{
	If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
	{
		If !DllCall("IsWindowVisible",UInt,ico)
		{
			while (transp != 255)
			{
				WinShow, ahk_id %ico%
				transp += 15
				WinSet, Transparent, %transp%, % "ahk_id" ico
				sleep, 20
			}
			ShellMessage("wParam", "lParam")
		} 
	} 
	else 
	{
		If DllCall("IsWindowVisible",UInt,ico)
		{
			while (transp != 0)
			{
				transp -= 15
				WinSet, Transparent, %transp%, % "ahk_id" ico
				sleep, 20
			}

			WinHide, ahk_id %ico%
		}
		
	}
}
