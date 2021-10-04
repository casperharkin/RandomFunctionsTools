#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



Raw = 
(
AddControl("Text","StaticTitle", " x12 y7 w250 h16| s13","Calculator")
AddControl("Text","Menu", " x8 y35 w32   +Center| s25|Segoe MDL2 Assets", Chr(0xE8C4),"F1F1F1|C7C7C7")
AddControl("Text","History", " x300 y45 w32 +Center |s18|Calculator MDL2 Assets",Chr(0xE81C),"E6E6E6|E81123")
AddControl("Text","Close", " x312 y0 w28 h28  +Center||Segoe MDL2 Assets",Chr(0xEF2C),"E6E6E6|E81123")
AddControl("Edit","Edit", " x14 y90 w310 h75  12 +readonly +0x4E 0x802 -E0x200 +Cener -VScroll|Bold s50","0")
AddControl("Text","BTN_MC", "x16 y175 w48 h20 +Disabled +Center|s13|Segoe MDL2 Assets","MC","E6E6E6|C7C7C7")
AddControl("Text","BTN_MR", "x68 y175 w48 h20 +Disabled +Center|s13 Bold|Segoe MDL2 Assets","MR","E6E6E6|C7C7C7")
AddControl("Text","BTN_M_Plus", "x120 y175 w49 h20 +Center|s13|Segoe MDL2 Assets","M+","E6E6E6|C7C7C7")
AddControl("Text","BTN_M_Minus", " x173 y175 w48 h20 +Center|s13|Segoe MDL2 Assets","M-","E6E6E6|C7C7C7")
AddControl("Text","BTN_MS", "x223 y175 w48 h20 +Center|s13|Segoe MDL2 Assets","Ms","E6E6E6|C7C7C7")
AddControl("Text","BTN_M_Dot", "x274 y175 w48 h20 +Disabled +Center|s13|Segoe MDL2 Assets","M.","E6E6E6|C7C7C7")
AddControl("Text","BTN_Perc","x14 y208 w75 h49 +Center|  s13|Segoe MDL2 Assets", Chr(0xE94C),"F1F1F1|C7C7C7")
AddControl("Text","BTN_CE","x92 y208 w75 h49 +Center|  s16", "CE","F1F1F1|C7C7C7")
AddControl("Text","BTN_C","x170 y208 w75 h49 +Center |  s16", "C","F1F1F1|C7C7C7")
AddControl("Text","BTN_Delete"," x250 y208 w74 h49 +Center|  s13|Calculator MDL2 Assets", Chr(0xE94F),"F1F1F1|C7C7C7")
AddControl("Text","BTN_1byx", "x13 y261 w75 h49 +Center|  s13|Calculator MDL2 Assets", Chr(0xF7C9),"F1F1F1|C7C7C7")
AddControl("Text","BTN_2x", "x92 y261 w75 h49 +Center|  s13|Calculator MDL2 Assets", "x2","F1F1F1|C7C7C7")
AddControl("Text","BTN_sqr", "x171 y261 w75 h49 +Center|  s13|Calculator MDL2 Assets", Chr(0x221A),"F1F1F1|C7C7C7")
AddControl("Text","BTN_Div", " x250 y261 w74 h49 +Center|  s13|Calculator MDL2 Assets", Chr(0xE94A),"F1F1F1|C7C7C7")
AddControl("Text","BTN_7"," x13 y314 w75 h49 +Center |Bold s16", "7","F7F7F7|C7C7C7")
AddControl("Text","BTN_8"," x92 y314 w75 h49 +Center |Bold s16", "8","F7F7F7|C7C7C7")
AddControl("Text","BTN_9"," x171 y314 w75 h49 +Center |Bold s16", "9","F7F7F7|C7C7C7")
AddControl("Text","BTN_Mult"," x249 y314 w75 h49 +Center |  s13|Calculator MDL2 Assets", Chr(0xE947),"F1F1F1|C7C7C7")
AddControl("Text","BTN_4","x12 y367 w75 h49 +Center |Bold s16", "4","F7F7F7|C7C7C7")
AddControl("Text","BTN_5"," x92 y367 w75 h49 +Center |Bold s16", "5","F7F7F7|C7C7C7")
AddControl("Text","BTN_6"," x171 y367 w75 h49 +Center |Bold s16", "6","F7F7F7|C7C7C7")
AddControl("Text","BTN_Sub"," x250 y367 w74 h49 +Center |  s13|Calculator MDL2 Assets", Chr(0xE949),"F1F1F1|C7C7C7")
AddControl("Text","BTN_1", "x13 y420 w75 h49 +Center |Bold s16", "1","F7F7F7|C7C7C7")
AddControl("Text","BTN_2", "x92 y420 w75 h49 +Center |Bold s16", "2","F7F7F7|C7C7C7")
AddControl("Text","BTN_3"," x171 y420 w75 h49 +Center |Bold s16", "3","F7F7F7|C7C7C7")
AddControl("Text","BTN_Add"," x250 y420 w75 h49 +Center |  s13|Calculator MDL2 Assets", Chr(0xE948),"F1F1F1|C7C7C7")
AddControl("Text","BTN_AddMinus", " x13 y472 w75 h49 +Center |  s13|Segoe MDL2 Assets", Chr(0xE94D),"F1F1F1|C7C7C7")
AddControl("Text","BTN_0", "x92 y473 w75 h48 +Center |Bold s16", "0","F7F7F7|C7C7C7")
AddControl("Text","BTN_Dot", "x171 y473 w75 h48 +Center |  s13", ".","F1F1F1|C7C7C7")
AddControl("Text","BTN_Enter", "x250 y472 w75 h49 +Center | Default s13|Calculator MDL2 Assets", Chr(0xE94E),"8ABAE0|4599DB")
)
;
Loop, Parse, Raw, `n
{
	Array := StrSplit(A_LoopField,",")
	;MsgBox % Array[A_Index]
	Name := StrReplace(Array[2], "`""")
	Options := Array[3]
	Value := Array[4]
	DIB := Array[5]
r =
( 
_Controls.Button_%Name%  :=    	{ "Type":"Text"
								, "Name": `"%Name%`"
								, "Options": %Options%
								, "Value":%Value%
								, "DIB":%DIB%
								, "Font_Size":16
								, "Font_Name":"Calculator MDL2 Assets"
								, "Font_Bold":"True"}
	)
s .= "`n`n" r
}
Clipboard := s