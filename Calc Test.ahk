#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
#Persistent
#Include C:\Users\babb\Documents\Autohotkey\Lib\classMemory.ahk
settimer, setMemory, 50
msgbox This requires ClassMemory version 2.8 or greater!
return 


doScans:
myAOBscan := TargetProcess.stringToPattern("ggghhh", "UTF-16")
myAOBaddress := TargetProcess.processPatternScan(,, myAOBscan*)
if (myAOBaddress > 0) 
{
    SetFormat, IntegerFast, H
    myAOBaddress += 0
    myAOBaddress .= ""
    SetFormat, IntegerFast, D
    msgbox patterns found at %myAOBaddress% 
	;writeString(address, string, encoding := "utf-8", aOffsets*)
	writeString(myAOBaddress,"1222")

}
return 


setMemory:
; If new _ClassMemory() has never been called then TargetProcess.isHandleValid() will return null (as TargetProcess isn't an object yet)
; If new _ClassMemory() has been successfully called, then isHandleValid() will return false after notepad closes or restarts
; otherwise it returns true
if TargetProcess.isHandleValid()
    return 
else if WinExist("ahk_exe notepad.exe")
{
    TargetProcess := new _ClassMemory("ahk_exe notepad.exe", "", hProcessCopy)
    SetTimer, doScans, 100 ; enable all memory reading timers
}
else ; handle is invalid and target process doesn't exist
{
    settimer, doScans, off ; disable all memory reading timers 
}
return
