#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


^Space::
    InputBox, runInput, Searcher,   ; This portion creates the search box + criteria
if (errorLevel)
return

RegExMatch(runInput, "[\w]+", searchMod)
    searchTerm := SubStr(runInput, StrLen(searchMod) + 1)
    searchTerm := trim(searchTerm)

	wb := ComObjCreate("InternetExplorer.Application")
	wb.Visible := 1


    if (searchMod = "x")
    {
    wb.Navigate("https://www.xe.com/currencyconverter/convert/?Amount=" searchTerm "&From=USD&To=CAD")
	While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy
	Sleep, 20
	MsgBox % "$" wb.document.getElementById("optToAmount").value " | USD To CAD"
	wb.quit()
	}


    else if (searchMod = "c")
    {
    wb.Navigate("https://www.xe.com/currencyconverter/convert/?Amount=" searchTerm "&From=CAD&To=USD")
	While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy
	Sleep, 20
	MsgBox % "$" wb.document.getElementById("optToAmount").value " | CAD To USD"
	wb.quit()
}


else
    MsgBox,,Invalid search terms,   ; Error box for Invalid search terms
return