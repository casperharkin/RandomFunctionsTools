#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Del:=0
Loop, % "C:\Users\" A_Username "\Documents\Offline Records (34)\*", 2, 1
  FL .= ((FL<>"") ? "`n" : "" ) A_LoopFileFullPath
Sort, FL, R D`n ; Arrange folder-paths inside-out
Loop, Parse, FL, `n
{
  FileRemoveDir, %A_LoopField% ; Do not remove the folder unless is  empty
  If ! ErrorLevel
       Del := Del+1,  RFL .= ((RFL<>"") ? "`n" : "" ) A_LoopField
}

Loop, Files, % "C:\Users\" A_Username "\Documents\Offline Records (34)\*.*", R
{
    FileGetTime, FileTime, % A_LoopFileLongPath
    If (FileTime > LatestFileTime) OR (A_Index = 1)
        LatestFileTime := FileTime, LatestFilePath := A_LoopFileLongPath
}
SplitPath, LatestFilePath,, dir
Run % dir 
