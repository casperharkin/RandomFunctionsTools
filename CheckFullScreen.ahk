#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
		
		#Persistent
		
		SetTimer, FullscreenCheck, 500
		Exit ; End of AES
		
		FullscreenCheck()
		{
			WinGetActiveTitle, OutputVar
			ToolTip % "Fullscreen Mode: "(WhatStyle(OutputVar) = 0 ? "false" : "true")
		}
		
		
		WhatStyle(Title) ; https://autohotkey.com/board/topic/38882-detect-fullscreen-application/
		{
			UniqueID := WinExist(Title)
			WinGet style, Style, ahk_id %UniqueID%
			WinGetPos ,,,winW,winH, %Title%
			Return ((style & 0x20800000) or winH < A_ScreenHeight or winW < A_ScreenWidth) ? false : true
		}