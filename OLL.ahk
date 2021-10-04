#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Gui +LastFound
hWnd := WinExist()

DllCall("RegisterShellHookWindow", UInt,hWnd)
MsgNum := DllCall("RegisterWindowMessage", Str,"SHELLHOOK")
OnMessage(MsgNum,"ShellMessage")

Return ;                                                 // End of Auto-Execute Section //

ShellMessage( wParam,lParam ) {

  If (wParam = 4) ;  HSHELL_WINDOWACTIVATED
     {
		MsgBox % "LOL"
       WinGetTitle, Title, ahk_id %lParam%

       If InStr( Title, "- Notepad" )
          MsgBox SetTimer, notepad, -1

       If InStr( Title, "Character Map" )
          MsgBox SetTimer, Charmap, -1

     }
}

Charmap:
    TrayTip, Notepad, Detected
    WinMinimize, - Notepad ahk_class Notepad 
    WinWaitClose, - Notepad ahk_class Notepad 
return

notepad:
    TrayTip, Charmap, Detected
    WinMinimize, Character Map ahk_class #32770 
    WinWaitClose, Character Map ahk_class #32770 
return