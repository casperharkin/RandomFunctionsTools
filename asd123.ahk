#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
		
		SetStoreCapsLockMode Off
		
		CapsLock::
		
		Loop
		{
			Send {f down}
			Sleep()
			Send {f up}
			Sleep()
			Send {d down}
			Sleep()
			Send {d up}
			Sleep()
			Send {s down}
			Sleep()
			Send {s up}
			Sleep()
			Send {a down}
			Sleep()
			Send {a up}
			Sleep()
			Send {c down}
			Sleep()
			Send {c up}
			Sleep()
			Send {RShift down}
			Sleep()
			Send {RShift up}
			Sleep()													
		}
		
		Return
		
		Sleep(time := 15) {
		
		if (a := GetKeyState("CapsLock","P") = 0)
			exit 
		Sleep % time 
		}