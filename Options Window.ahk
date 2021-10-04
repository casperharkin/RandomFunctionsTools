#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui Add, ListView, x12 y25 w200 h150 +LV0x4000, Options|Value
Gui Add, GroupBox, x6 y6 w212 h179, Settings Window
Gui Add, Button, x11 y192 w201 h23, Apply
Gui Add, Button, x11 y218 w201 h23, Close

LV_Add(,"Invoice Description:","SALARY OVERPAYMENT")
LV_Add(,"Class:","OVERPAID EMPLOYEES (EX-NTG)")
LV_Add(,"Region:","ALICE SPRINGS")
LV_Add(,"Contact Name:","PAYROLLDEBTRECOVERY ASP")
LV_Add(,"Contact No.:","08 8951 6490")
LV_Add(,"Contact Email:","PAYROLLDEBTRECOVERY.ASP@NT.GOV.AU")
LV_Add(,"Agency Email:","PAYROLLDEBTRECOVERY ASP")
LV_Add(,"Agency Phone:","08 8951 6490")
LV_Add(,"Instructions:","Return Original Invoice to Requesting Officer")
LV_Add(,"Cost Code Sufix:","211111")
LV_Add(,"Tax Code:","Z00")



LV_ModifyCol()








Gui Show, w224 h251, Settings Window