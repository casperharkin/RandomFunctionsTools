#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui Add, ListView, x12 y25 w200 h150 +LV0x4000, Stocks|Buy|Goal
Gui Add, GroupBox, x6 y6 w212 h179, Live Stocks
;Gui Add, Button, x11 y192 w201 h23, Apply
;Gui Add, Button, x11 y218 w201 h23, Close

LV_Add(,"LIT","0.053","0.059")
LV_Add(,"PAK","0.025", "0.030")
LV_Add(,"CAD","0.016", "0.019")

LV_ModifyCol()
LV_ModifyCol(1, 50)








Gui Show, w224 , Live Stocks