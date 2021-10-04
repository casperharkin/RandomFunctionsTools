#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"


if !FileExist("C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp")
	First_Run_Check()
Else
	{
	MsgBox % "Welcome " . A_UserName . ",`n`nLoading Details..."
	IniRead,U, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
	IniRead,S, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
	IniRead,P, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, P
	}

Gui Settings: Add, GroupBox, x111 y74 w0 h0, GroupBox
Gui Settings: Add, Edit, x113 y36 w77 h21 vU, %U%
Gui Settings: Add, Edit, x113 y58 w77 h21 vS, %S%
Gui Settings: Add, Text, x46 y33 w65 h23 +0x200 +Right, User Name:
Gui Settings: Add, Text, x46 y57 w65 h23 +0x200 +Right, Password:
Gui Settings: Add, Button, x48 y87 w141 h23 gSettings, Save && Encrypt
Gui Settings: Add, GroupBox, x10 y7 w215 h117 , Logon Details:
Gui Settings: Add, GroupBox, x10 y135 w215 h86, User Profile:
Gui Settings: Add, DropDownList, x37 y160 w162 vP, Payroll Debt Recovery Unit||Accounts Receivable 
Gui Settings: Add, Button, x47 y186 w141 h23 gSettings, Save Selection
Gui Settings: Show, w236 h229, Settings Window:
Return

Settings:
Gui Settings: Submit, nohide

if (U != "")
{
	IniWrite, % Base64Encode(U) , % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
	ControlSetText, Edit1, % Base64Encode(U), Settings Window:
	U := ""
}

if (S != "")
{
	IniWrite, % Base64Encode(S), % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
	ControlSetText, Edit2, % Base64Encode(S), Settings Window:
	S := ""
}

if (P != "")
{
	P := Base64Encode(P) 
	IniWrite, %P%, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, P
	P := ""
}
Return


Return

First_Run_Check()
{
		Path := "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp"
		MsgBox, 1st Run`n`nCreating ProjectCorp Folder: `n`n%Path%
		FileCreateDir, % Path
		FileCreateDir, % Path . "\Resources"
		FileCreateDir, % Path . "\Templates"
		IniWrite, BLANK, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, U
		IniWrite, BLANK, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, S
		IniWrite, BLANK, % "C:\Users\" . A_UserName . "\AppData\Local\Temp\_ProjectCorp\Settings.ini", Settings, P

		Return
}


Base64Encode(string) {
   Loop Parse, string
   {
      m := Mod(A_Index,3)
      IfEqual      m,1, SetEnv buffer, % Asc(A_LoopField) << 16

      Else IfEqual m,2, EnvAdd buffer, % Asc(A_LoopField) << 8
      Else {
         buffer += Asc(A_LoopField)
         out := out Code(buffer>>18) Code(buffer>>12) Code(buffer>>6) Code(buffer)
      }
   }
   IfEqual m,0, Return out
   IfEqual m,1, Return out Code(buffer>>18) Code(buffer>>12) "=="
   Return out Code(buffer>>18) Code(buffer>>12) Code(buffer>>6) "="
}

Base64Decode(code) {
   StringReplace code, code, =,,All
   Loop Parse, code
   {
      m := A_Index & 3 ; mod 4
      IfEqual m,0, {
         buffer += DeCode(A_LoopField)
         out := out Chr(buffer>>16) Chr(255 & buffer>>8) Chr(255 & buffer)
      }
      Else IfEqual m,1, SetEnv buffer, % DeCode(A_LoopField) << 18
      Else buffer += DeCode(A_LoopField) << 24-6*m
   }
   IfEqual m,0, Return out
   IfEqual m,2, Return out Chr(buffer>>16)
   Return out Chr(buffer>>16) Chr(255 & buffer>>8)
}

Code(i) {   ; <== Chars[i & 63], 0-base index
   Global Chars
   StringMid i, Chars, (i&63)+1, 1
   Return i
}

DeCode(c) { ; c = a char in Chars ==> position [0,63]
   Global Chars
   Return InStr(Chars,c,1) - 1
}

