Global Answers := {}

GUI := New InputDlg("Edit","", "Okay","What is Your Name:","What is Your Age:")
WinWaitClose, % "ahk_id " GUI

GUI := New InputDlg("Radio","Sex:", "Okay","Male", "Female")
WinWaitClose, % "ahk_id " GUI

GUI := New InputDlg("Checkbox", "Pets:", "Okay","Cats", "Dogs", "Fish")
WinWaitClose, % "ahk_id " GUI

for each, Answers in Answers 
	 R .= Answers "`n" 

MsgBox % R

ExitApp
Exit 

Okay(GuiHwnd, SubmitHWND) {
	WinGet, Output, ControlList, a
	Loop, Parse, Output, "`n" 
		{
			GuiControlGet, MyEdit,, % A_LoopField
			;MsgBox % A_LoopField
					If (instr(A_LoopField,"Static") = "1")
					{
						ControlGetText, Output, % A_LoopField
						Prefix := Output
					}

			If (MyEdit != "0") and (instr(A_LoopField,"Static") != "1"){
				ControlGetText, Output, % A_LoopField
				If (Output != "Okay")
					If (Prefix != "")
						Answers.Push(Prefix "`nAnswer: " Output)
			}
		}
	Gui %GuiHwnd%:Destroy
}

Class InputDlg
{
	
	__New(Type, static, BoundFunc, Options*) {
		Global 
		if (GuiHwnd)
			Gui, Destroy

		Gui +HwndGuiHwnd
		if (Type = "Radio") {
			Gui, Add, Text,, % static 
			for index, Options in Options 
				Gui, Add, %Type%, % "v" Type . index, % Options
		}

		if (Type = "Checkbox") {
			Gui, Add, Text,, % static 
			for index, Options in Options 
				Gui, Add, %Type%, % "v" Type . index, % Options
		}

		if (Type = "Edit")
			for index, Options in Options {
				Gui, Add, Text,, % Options
				Gui, Add, %Type%, % "v" Type . index,
			}

		Gui, Add, Button, wp HwndSubmitHWND, Okay
		fn_1 := Func(BoundFunc).bind(GuiHwnd,SubmitHWND)
		GuiControl, +g, % SubmitHWND, % fn_1
		This.Show(GuiHwnd)
		Return GuiHwnd
	}

	Show(GuiHwnd) {
		Gui %GuiHwnd%:Show
	}

	Destroy(GuiHwnd) {
		Gui %GuiHwnd%:Destroy
	}
}
