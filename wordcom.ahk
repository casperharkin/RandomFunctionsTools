#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


wdApp := ComObjCreate("Word.Application") 
wdApp.Documents.Add
wdApp.Visible := True
Exit

#c::
Send ^c
wdApp.Activate ; make Word visible and activate it.
wdApp.ActiveDocument.Content.InsertAfter(Clipboard "`n")    ; insert text at the end of the active document
