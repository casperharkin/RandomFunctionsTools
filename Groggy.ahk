MainGui := new GUI("Main", "Main Gui:", "+AlwaysOnTop")
Exit

class GUI { 

    __New(Name, WinTitle := "", Options := ""){ 
        static
		This.Controls := []
		this.Name := Name
		this.WinTitle := WinTitle
        Gui, % this.Name ":New", HWNDhGui, %WinTitle%
		this.Handle := hGui
        Gui, +Labelmy +Resize %Options%
	   	Gui, Margin, 10, 10
		This.Add("Edit", "TimeEdit", "w250",  "", "1200000")
		This.Add("DropDownList", "TimeDDL", "w250 r10","TimeDDL", "sec||min|hr|")
		This.Add("Text", "TimeDisplay",, "w250 h20", "00:00:00")
		This.Add("Button", "Button_1", "w250","ConvertTime","Convert Time")
		This.Add("Button", "Button_2", "w250","Delete","Gui Close")
		This.Show(50, 50)
	}

    Show(x := "Center", y := "Center"){
        Gui, % this.Name ":Show", x%x% y%y%
    }
	
	Add(ControlType:="Edit", Name_Control:="Edit1", Options:="", Function:="Edit_onTyping", Value:="", StringStatusBar:="", StringTooltip:="", DelayTooltip:=500){
		static
		Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%,%Value%
		Handle_Control := h%Name_Control%
		This.Controls[Name_Control, "Handle"]:=Handle_Control
		ControlHandler := ObjBindMethod(this, Function)
		GuiControl +g, %Handle_Control%, %ControlHandler%
	}

	ConvertTime(hwnd, GuiEvent, EventInfo){
		ControlGetText, milli,, % "ahk_id " This.Controls["TimeEdit"]["Handle"]
		ControlGetText, unit,, % "ahk_id " This.Controls["TimeDDL"]["Handle"]
		SetFormat, FLOAT, 0
		milli /= 1000.0
		secs := mod(milli, 60)
		SetFormat, FLOAT, 0.0
		milli //= 60
		mins := mod(milli, 60)
		hours := milli //60
	    GuiControl, Text, % This.Controls["TimeDisplay"]["Handle"], % Format("{:02}", hours) . ":" . Format("{:02}", mins) . ":" . Format("{:02}", secs)
    }

	Delete(){
		Gui, % this.Name ":Destroy"
		ExitApp
    }
	GUIClose() {
		This.Delete()
	}
}

