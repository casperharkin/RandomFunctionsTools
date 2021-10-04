#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

oSM := ComObjCreate("com.sun.star.ServiceManager")
oDesk := oSM.createInstance("com.sun.star.frame.Desktop")
oArray := ComObjArray(0xC, 2) ;VT_VARIANT := 0xC
oArray.1 := MakePropertyValue(oSM, "Hidden", ComObject(0xB, True)) ;VT_BOOL := 0xB
oDoc := oDesk.loadComponentFromURL("private:factory/scalc", "_blank", 0, oArray)

oSheet := oDoc.getSheets().getByName("Pricing")
Col := 7
Row := 50
oSheet.getCellByPosition(Col, Row).clearContents(0x3FF)
