#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Line1 := "NEPNV1",{Name:"SPNT NL - FM",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}
Line2 := "NEPNV2",{Name:"SPNT NL - ECM",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}

SuperDetails := {}
SuperDetails.Insert(Line1)
SuperDetails.Insert("NEPNV2",{Name:"SPNT NL - ECM",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"})

MsgBox % SuperDetails["NEPNV1"].Name
MsgBox % SuperDetails["NEPNV2"].Name
Return
