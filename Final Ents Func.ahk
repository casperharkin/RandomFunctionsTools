#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


q::

FinalEntsHotKey() {
FinalEntsLine := StrSplit(clipboard,A_Tab)
FormatTime, TimeString,, shortDate
WinActivate Mochasoft - mainframe.nt.gov.au
sleep 200
SetKeyDelay, 90, 0,

If (FinalEntsLine[2] = "ENT.PYM")
		send % "{F7}" FinalEntsLine[2] "{enter}" FinalEntsLine[3] TimeString "{tab}{tab}"  FinalEntsLine[4] := RegExReplace(FinalEntsLine[4], "[^0-9.]") "{tab}{+}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}{tab}Y{F9}" FinalEntsLine[5] := FinalEntsLine[5]="" ? FinalEntsLine[1]:FinalEntsLine[1] " - " FinalEntsLine[5]
If (FinalEntsLine[2] = "LVB.PYM") 
		send % "{F7}" FinalEntsLine[2] "{enter}" FinalEntsLine[3]FinalEntsLine[4] := RegExReplace(FinalEntsLine[4], "[^0-9.]") "{tab}{+}" StrSplit(FinalEntsLine[1],A_Space).1 "{tab}{tab}{tab}{tab}y{F9}" FinalEntsLine[5] := FinalEntsLine[5]="" ? FinalEntsLine[1]:FinalEntsLine[1] " - " FinalEntsLine[5]
If (FinalEntsLine[2] = "TAX.PYM")
		send % "{F7}" FinalEntsLine[2] "{enter}FTTAX1" FinalEntsLine[4] := RegExReplace(FinalEntsLine[4], "[^0-9.]") "{TAB}{TAB}Y{F9}" FinalEntsLine[5] := FinalEntsLine[5]="" ? FinalEntsLine[1]:FinalEntsLine[1] " - " FinalEntsLine[5]
If (FinalEntsLine[1] = "RCY.PYM")
		send % "{F7}" FinalEntsLine[1] "{enter}rcy002n" TimeString "{TAB}" FinalEntsLine[3] := RegExReplace(FinalEntsLine[3], "[^0-9.]") "{TAB}{TAB}{TAB}{TAB}Y{F9}Final Ents offset against salary overpayment."
If (FinalEntsLine[2] = "EMP.PYM") {
		InputBox, Ref,,What is the Member Number?,,150,150		
		WinActivate Mochasoft - mainframe.nt.gov.au
		send % "{F7}" FinalEntsLine[2] "{enter}" FinalEntsLine[3] FinalEntsLine[4] := RegExReplace(FinalEntsLine[4], "[^0-9.]") "{TAB}{+}{TAB 5}" Ref "{TAB}{TAB}{TAB}y{F9}{F9}Super Due on Final Ents" ;{F9}Super Due on Final Ents"
	}
}