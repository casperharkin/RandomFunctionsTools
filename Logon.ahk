#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui Login: Add, Text, x32 y27 w85 h20, User ID:
Gui Login: Add, Edit, x124 y24 w127 h22 vU
Gui Login: Add, Text, x32 y55 w85 h20, ePOD Password:
Gui Login: Add, Edit, x124 y52 w127 h22 +Password vS2
Gui Login: Add, Text, x32 y81 w85 h20, PIPS Password:
Gui Login: Add, Edit, x124 y79 w127 h22 +Password vS
Gui Login: Add, Button, x277 y20 w96 h39 gLogin, Connect
Gui Login: Add, Button, x277 y79 w96 h39 gLoginGuiEscape, Cancel
Gui Login: Add, Text, x21 y138 w448 h20, Note: Password and User Details are not kept in plain text.
Gui Login: Show, w387 h166, PDR Login - Toolbar

Return

LoginGuiEscape:
GuiClose:
    ExitApp

Login:
Gui Login: Submit, destroy

	IniWrite, U, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
	IniWrite, S, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
	IniWrite, S2, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S2

Return

