﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
    #Persistent

SetTimer, SetMouse, 100
Exit



SetMouse() {

; Put in the keys you want to turn off the mouse move for
KeyList := ["w","a","s","d","Ctrl","Space","LButton","Shift"]

; Change to the x and y you want to use
x := A_ScreenWidth/2
y := A_ScreenHeight/2

    For each, Key in KeyList
        if(GetKeyState(Key, "p") = "1") {
            SetTimer, SetMouse, 3000
            Return
        }
    MouseMove, % x, % y
    SetTimer, SetMouse, 100
}