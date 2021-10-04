#NoEnv
#SingleInstance, Force

Global MouseMorse := 1

MainGui := new GUI("Main", "", "+AlwaysOnTop")
MainGui.Show()

#if (MouseMorse = 1)
        $a:: Send Morse
        $d:: Send Code


#if (MouseMorse = 0)
        $a:: Send Mouse
        $d:: Send Move
        $s:: MainGui.Toggle()
#if

Exit  
Esc:: 
Gui.Delete()
ExitApp


class GUI { 
	
    __New(Name, WinTitle := "", Options := ""){ 
        static
		This.Controls := []
		This.Name := Name
		This.WinTitle := WinTitle
		
        Gui, % this.Name ":New", HWNDhGui, %WinTitle%
		This.Handle := hGui
        Gui, +Labelmy +Resize %Options%
		
        Gui, Font, s16
		Gui, Add, Button, HWNDhButton_1 vButton_1, Toggle

		Handle_Control := hButton_1

		This.Controls["Button_1", "Handle"] := Handle_Control
		ControlHandler := ObjBindMethod(This, "Toggle")
		GuiControl +g, %Handle_Control%, %ControlHandler%
    }
	
	Toggle() {  
	WinGetActiveTitle, Title
    MouseMorse := !MouseMorse
	if MouseMorse {
		This.Show()
		WinActivate, % Title
	}
	Else
		This.Hide()
	}

    Show(){
        Gui, % this.Name ":Show" 
    }
	
    Hide(){
        Gui, % this.Name ":hide" 
    }
	
	Delete(){
		Gui, % this.Name ":Destroy"
    }
}  