#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

OnExit(ObjBindMethod(eReader, "Cleanup"))
Global __Handles := {}, New eReader
Exit

^Right::eReader.eReader_Next()

Class eReader {

	__New() {

		Gui, -Caption
		Gui Color, FFFFFF
		Gui Add, Edit,  w185 h117 -E0x200 +Multi +HwndhDisplayEditControl
		Gui, Show, x5 y552,

		This.SetParentByTitle("PDR Toolbar",1)

		if(!wb) {
			__Handles.wb := ComObjCreate("InternetExplorer.Application")
			__Handles.wb.Visible := 0
			__Handles.hDisplayEditControl := hDisplayEditControl

			IniRead, navURL, % "C:\Users\babb\Desktop\Workbook Class Settings.ini", General, navURL
			InputBox, navURL, URL, Please Enter the URL.,,,,,,,,%navURL%

			__Handles.wb.Navigate(navURL)

			This.LoadPage()
			This.eReader_Grab_InnerText()
		}
	}
	
	eReader_Next() {
		__Handles.wb.document.getElementById("next_chap").click()
		This.LoadPage()
		navURL := __Handles.wb.LocationURL
		IniWrite, % navURL, % "C:\Users\babb\Desktop\Workbook Class Settings.ini", General, navURL
		This.eReader_Grab_InnerText()
	}
	
	eReader_Grab_InnerText() {
		guicontrol, text, % __Handles.hDisplayEditControl, % text := StrReplace(__Handles.wb.document.getElementById("chapter-content").innerText, "`n`r")
	}
	
	LoadPage() {
		While __Handles.wb.readyState != 4 || __Handles.wb.document.readyState != "complete" || __Handles.wb.busy
			Sleep, 20
	}

	Cleanup() {
		DetectHiddenWindows On
		__Handles.wb.quit
		DetectHiddenWindows Off
	}
	
	SetParentByTitle(Window_Title_Text, Gui_Number) {
		WinGetTitle, Window_Title_Text_Complete, %Window_Title_Text% 
		Parent_Handle := DllCall( "FindWindowEx", "uint",0, "uint",0, "uint",0, "str", Window_Title_Text_Complete) 
		Gui, %Gui_Number%: +LastFound 
		Return DllCall( "SetParent", "uint", WinExist(), "uint", Parent_Handle )
	}
}