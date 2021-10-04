#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



RunMoveResize("C:\Users\babb\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\DBE Financial Systems\Production\EPod.appref-ms", 0,0,500,500,10,1)

Return ; AES End

;#########################################
;############### FUNCTIONS ###############
;#########################################

RunMoveResize(PathOrTitle, X, Y, W, H, WaitTime := "", Maximize := "", Active := "") {

PathOrTitle := StrReplace(PathOrTitle, """")

Run % PathOrTitle
SplitPath, PathOrTitle, PathOrTitle
Result := InStr(PathOrTitle, "EPod")?PathOrTitle:"Payback.exe"
Prefix := "ahk_exe ", Suffix := InStr(PathOrTitle, ".exe")?PathOrTitle:PathOrTitle . ".exe"
WinWait, % Prefix . Suffix,, % WaitTime!=""?WaitTime:"6"
WinMove, % Prefix . Suffix,, % X, % Y, % W, % H
Result := Maximize=1?WinMax(WinTitle):""
Result := Active=1?WinAct(WinTitle):""
}

WinMax(WinTitle) {
	WinMaximize % WinTitle
}
WinAct(WinTitle) {
	WinActivate % WinTitle
}