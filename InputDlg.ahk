
;; FIRST EXAMPLE - ACTION WITHIN THE OKAY() FUNC
GUI := InputDlg("Radio", "Red", "Blue", "Green")
GUI := InputDlg("Button", "Okay")
GUI, Show

WinWaitClose, % "ahk_id " MyGuiHwnd


Exit ; END OF AES

; EXAMPLE 1 – SELF CONTAINED 
Okay() {
WinGet, OutputVar, ControlList, a
Loop, Parse, OutputVar, "`n" 
	{
		GuiControlGet, MyEdit,, % A_LoopField
		if (MyEdit = "1") 
			ControlGetText, OutputVar , % A_LoopField
	}
MsgBox % "You have Selected: " OutputVar 
Gui, destroy
}

; EXAMPLE 2 – REDIRECTS 
Which() {
WinGet, OutputVar, ControlList, a
Loop, Parse, OutputVar, "`n" 
	{
		GuiControlGet, MyEdit,, % A_LoopField
		if (MyEdit = "1") { 
			Option%A_Index%()
			exit
		}
	}
}

Option1() {
	MsgBox % "Option 1 Selected"
	Gui, destroy
}

Option2() {
	MsgBox % "Option 2 Selected"
	Gui, destroy
}

Option3() {
	MsgBox % "Option 3 Selected"
	Gui, destroy
}

; MAIN FUNCTION FOR BUILDING SIMPLE TEMP RADIO BASED GUI’S
InputDlg(Type, Options*) {
Global
Gui +HwndMyGuiHwnd
if (Type = "Radio")
	for index,Options in Options 
		Gui, Add, %Type%, % "v" Type . index , % Options
		
else if (Type = "Button")
	for index,Options in Options 
		Gui, Add, %Type%, % " g" . Options, % Options
}

