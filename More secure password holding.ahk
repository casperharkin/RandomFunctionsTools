#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

Global Chars 

IniRead, OutputVar, C:\Users\babb\AppData\Local\Temp\_ProjectCorp\Settings.ini, settings, u
IniRead, OutputVar2, C:\Users\babb\AppData\Local\Temp\_ProjectCorp\Settings.ini, settings, s

MsgBox % Base64Decode(OutputVar) "`n`n" Base64Decode(OutputVar2)
Return

Encode:
Gui, Submit

MsgBox % "Encoded Password is:`n`n" Clipboard := Base64Encode(Password)
Return

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


