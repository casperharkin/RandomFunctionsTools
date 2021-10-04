#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
#SingleInstance Force
SetTitleMatchMode 2

global AppsOBJ := {}

AppsOBJ["SelectionForm"] :=  	{"Title":"Selection Form ahk_exe myapp.exe"
					   			 ,"State":0}

AppsOBJ["Reminder"] :=   	{"Title":"Reminder(s) ahk_class #32770"
					   			 ,"State":0}

AppsOBJ["Meeting"] :=    	{"Title":"- Meeting AHK_class rctrl_renwnd32"
					   			 ,"State":0}

SetTimer, MoveWindow, 250
Exit

MoveWindow(){

	For Each, Item in AppsOBJ 
		If WinExist(AppsOBJ[Each]["Title"]) and (AppsOBJ[Each]["State"] != 1) {
				CenterWindowDesktop(AppsOBJ[Each]["Title"])
				AppsOBJ[Each]["State"] := 1
		}
}
Return

CenterWindowDesktop(WinTitle)
{
    ;Center Window on middle monitor
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}


