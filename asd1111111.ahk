#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F1::                                        
LoadM7a() {
global ListBoxText 
Gui, Add, Text,, Drop something here!
Gui, Add, ListBox, altsubmit vListBoxText gMyListBox W600 R20
Gui, Add, Button, x618 y20 w50 h25 gUpbutton, Up 
Gui, Add, Button, x618 y50 w50 h25 gDownbutton, Down
Gui, Add, Button, x10 y300 w50 h25 gMybutton, OK
Gui, Show,, ItemOrder
FullList :=""
return
}

GuiDropFiles:                                               ; Support drag & drop.             
Loop, Parse, A_GuiEvent, `n                         
{    
    GuiControl,, ListBoxText, %A_LoopField% 
    FullList .= A_LoopField . "`n"
}
return         

MyListBox:                          
if (A_GuiEvent != "DoubleClick")                
    return
gui, submit, nohide
ControlGet, Items, List,, Listbox1, ItemOrder
Loop, Parse, Items, `n
    if (ListBoxText = A_Index)
		MsgBox, You pressed %A_LoopField%
return


Downbutton:
gui, submit, nohide
ControlGet, Items, List,, Listbox1, ItemOrder

Array := StrSplit(Items, "`n")

Loop, Parse, Items, `n
    if (ListBoxText = A_Index) {
		RemovedValue := Array.RemoveAt(A_Index)
		Array.InsertAt(ListBoxText+1, A_LoopField)
	}

r := "|"
for each, item in Array
	r .= item "|"
GuiControl,, ListBoxText, % r

return
Upbutton:
gui, submit, nohide
ControlGet, Items, List,, Listbox1, ItemOrder

Array := StrSplit(Items, "`n")

Loop, Parse, Items, `n
    if (ListBoxText = A_Index) {
		RemovedValue := Array.RemoveAt(A_Index)
		Array.InsertAt(ListBoxText-1, A_LoopField)
	}

r := "|"
for each, item in Array
	r .= item "|"
GuiControl,, ListBoxText, % r

return

Mybutton:
gui, submit, nohide
ControlGet, Items, List,, Listbox1, ItemOrder
Array := StrSplit(Items, "`n")
s := ""
for each, item in Array
	s .= item "`n"

MsgBox % s
return

GuiClose:
Gui, Destroy            
Reload 