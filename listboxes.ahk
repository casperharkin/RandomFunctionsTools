#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, Add, Text, Section, Active Whitelist:
Gui, Add, Listbox, h160 

Gui, Add, Button, w55, Save
Gui, Add, Button, w55 x+10, Load

Gui, Add, Text, xp-65 yp+30, Stored WhiteList:
Gui, Add, Listbox, h160

Gui, Add, Button,w55  , Save
Gui, Add, Button,w55 yp x+10, Load

Gui, Add, Text, ys , Active BlackList:
Gui, Add, Listbox , h160

Gui, Add, Button,w55, Save
Gui, Add, Button,w55 x+10, Load

Gui, Add, Text,  xp-65 yp+30, Stored BlackList:
Gui, Add, Listbox, h160

Gui, Add, Button,w55, Save
Gui, Add, Button,w55 yp x+10, Load




Gui, Show