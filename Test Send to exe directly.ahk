#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



item_1 =
(
Send, hi1111
Sleep 1000
Send, hi again
MsgBox Done
Return
)

ExecScript(item_1,,A_AhkPath)
Return


ExecScript(Script, Params="", AhkPath="")
{
	static Shell := ComObjCreate("WScript.Shell")
	Name := "\\.\pipe\AHK_CQT_" A_TickCount
	Pipe := []
	Loop, 3
	{
		Pipe[A_Index] := DllCall("CreateNamedPipe"
		, "Str", Name
		, "UInt", 2, "UInt", 0
		, "UInt", 255, "UInt", 0
		, "UInt", 0, "UPtr", 0
		, "UPtr", 0, "UPtr")
	}
	if !FileExist(AhkPath)
		throw Exception("AutoHotkey runtime not found: " AhkPath)
	if (A_IsCompiled && AhkPath == A_ScriptFullPath)
		AhkPath .= " /E"
	if FileExist(Name)
	{
		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
		DllCall("ConnectNamedPipe", "UPtr", Pipe[2], "UPtr", 0)
		DllCall("ConnectNamedPipe", "UPtr", Pipe[3], "UPtr", 0)
		FileOpen(Pipe[3], "h", "UTF-8").Write(Script)
	}
	else ; Running under WINE with improperly implemented pipes
	{
		FileOpen(Name := "AHK_CQT_TMP.ahk", "w").Write(Script)
		Exec := Shell.Exec(AhkPath " /CP65001 " Name " " Params)
	}
	Loop, 3
		DllCall("CloseHandle", "UPtr", Pipe[A_Index])
	return Exec
}
