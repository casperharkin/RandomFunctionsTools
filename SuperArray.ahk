#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SuperDetails := {}

Loop, Read, C:\Users\babb\Documents\Autohotkey\Lib\SuperList.txt 
{
    Key := StrSplit(A_LoopReadLine, ",").1
    RegexMatch(A_LoopReadLine, "i)(?<=Name:"").*?(?="",)", name)
    RegexMatch(A_LoopReadLine, "i)(?<=Street:"").*?(?="",)", street)
    RegexMatch(A_LoopReadLine, "i)(?<=State:"").*?(?=""\})", state )
    SuperDetails[key, "Name"] := Name
    SuperDetails[key, "Street"] := Street
    SuperDetails[key, "State"] := State
}
MsgBox % "Name: " SuperDetails["NEPNV1"].Name "`nStreet: " SuperDetails["NEPNV1"].Street "`nState: " SuperDetails["NEPNV1"].State

