#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SwitchReplacement :=  {"btw" : "{backspace 5}by the way"  
                      ,"otoh": "{backspace 5}on the other hand" 
                      ,"fl"  : "{backspace 5}Florida" 
                      ,"ca"  : "{backspace 5}California" 
                      ,"Default"  : "Run Default"}

ErrorLevelObj	  :=  {"Max" : "You entered UserInput, which is the maximum length of text."  
                      ,"Timeout": "You entered UserInput at which time the input timed out." 
                      ,"NewInput"  : "" 
                      ,"Default"  : "Run Default"}


~[::
Input, UserInput, V T5 L4 C, {Tab}{space}
if (SwitchReplacement(ErrorLevel,UserInput, ErrorLevelObj) = "Run Default")
	Send % SwitchReplacement(UserInput,"",SwitchReplacement)
Else
	MsgBox % SwitchReplacement(ErrorLevel,UserInput, ErrorLevelObj)
return


SwitchReplacement(Choice,UserInput, ChoiceObject) {

	For Each, Item in ChoiceObject {
		if (Choice = Each)
			return r := StrReplace(ChoiceObject[Each], "UserInput", UserInput)
	}

	Return ChoiceObject["Default"]
}



;~[::
;Input, UserInput, V T5 L4 C, {enter}.{esc}{tab}, btw,otoh,fl,ahk,ca
;switch ErrorLevel
;{
;case "Max":
;    MsgBox, You entered "%UserInput%", which is the maximum length of text.
;    return
;case "Timeout":
;    MsgBox, You entered "%UserInput%" at which time the input timed out.
;    return
;case "NewInput":
;    return
;default:
;    if InStr(ErrorLevel, "EndKey:")
;    {
;        MsgBox, You entered "%UserInput%" and terminated the input with %ErrorLevel%.
;        return
;    }
;}
;switch UserInput
;{
;case "btw":   Send, {backspace 4}by the way
;case "otoh":  Send, {backspace 5}on the other hand
;case "fl":    Send, {backspace 3}Florida
;case "ca":    Send, {backspace 3}California
;case "ahk":   Run, https://www.autohotkey.com
;}
;return