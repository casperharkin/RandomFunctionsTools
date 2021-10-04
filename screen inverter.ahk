#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
#Persistent
SetWorkingDir, A_Scriptdir
invertArray := []
invertState := checkInversion()
Loop, Read, colorInversionGroups.txt
{
    if (a_loopreadline != "`n") {
        GroupAdd, invert, %A_LoopReadLine%
        invertArray.push(A_LoopReadLine)
    }
}
GroupAdd, invert, Cortana
GroupAdd, invert, ahk_class shell_traywnd
SetTimer, checkForInvert, 100

checkForInvert:
invertState :=  checkInversion() 

ifwinactive, ahk_group invert
{
    if (!invertState) {
        KeyWait, Tab
        KeyWait, LALt
        sleep, 200
        ifwinactive, ahk_group invert
            send, ^#c
    }
    return
}
ifwinNotactive, ahk_group invert
{
    if (invertState) {
        KeyWait, Tab
        KeyWait, LALt
        sleep, 200
        ifwinNotactive, ahk_group invert && ifwinNotactive, ahk_class shell_traywnd &&  ifwinNotactive, Cortana &&  ifwinNotactive, Task View && ifwinNotactive, Jump List &&   ifwinNotactive, ""
            send, ^#c
    return
    }
}
#If

checkInversion() {
    regread, x, HKEY_CURRENT_USER\Software\Microsoft\ColorFiltering, Active
    return, x
}
~^#c::

WinGetActiveTitle, title
WinGet, activeProcess, ProcessName,%title%
if (!invertState) {
    IfWinNotActive, ahk_group invert
    {
        GroupAdd, invert, %activeProcess%
        exelist := ""
        for key, val in invertArray
            exelist.= val "`n"
        exelist.= "ahk_exe " activeProcess "`n"
        invertArray.push(activeProcess)
        FileAppend, %exelist%, temp.txt
        FileMove, temp.txt, colorInversionGroups.txt, 1
        FileDelete, temp.txt
    }
    Reload
} else {
    IfWinActive, ahk_group invert   
    {
        exelist := ""
        for key, val in invertArray {
            if (val != "ahk_exe " activeProcess) && (val != "ahk_exe ")
                exelist .= val "`n"
        }
        FileAppend, %exelist%, temp.txt
        FileMove, temp.txt, colorInversionGroups.txt, 1
        FileDelete, temp.txt
    }
    Reload
}