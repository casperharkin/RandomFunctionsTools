#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


WhatFont := "cBlue"
GUI()
Return

Menu:
Gui, Submit, Nohide

if (A_GuiControl = "Method 1") ; Change Each Control 1 by 1.
	{
		Gui Font, cRed
		GuiControl, Font, % hControl1
		GuiControl, Font, % hControl2
		GuiControl, Font, % hControl3
		GuiControl, Font, % hControl4
	}

if (A_GuiControl = "Method 2") ; Change Each Control with loop.
	{
		Gui Font, cBlue
		Loop, 4
			GuiControl, Font, % hControl%A_Index%
	}

if (A_GuiControl = "Method 3") ; Creating a new gui all at once
	{
		WhatFont := "FFFFFF"
		WhatColor := "000000"
		GUI()
	}
Return

GUI() 
{
Global
Gui Destroy
Gui Color, %WhatColor% 
Gui Font, c%WhatFont%
Gui Add, Text, x4 y3 w251 h23 +Center hwndhControl1, Example Title:
Gui Font, c%WhatFont%
Gui Add, Text, x2 y34 w79 h23 +Center hwndhControl2, Text 1
Gui Add, Text, x89 y34 w79 h23 +Center hwndhControl3, Text 2
Gui Add, Text, x177 y34 w79 h23 +Center hwndhControl4, Text 3
Gui Add, Button, x2 y64 w80 h23 gMenu, Method 1
Gui Add, Button, x88 y64 w80 h23 gMenu, Method 2
Gui Add, Button, x175 y64 w80 h23 gMenu, Method 3
Gui Show, w261 h91, Fun with Fonts
}
