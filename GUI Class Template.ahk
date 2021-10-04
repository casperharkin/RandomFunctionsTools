#NoEnv
#SingleInstance, Force


MainGui := new GUI("Main", "Gui1", "+AlwaysOnTop")
Gui, Font, s16
MainGui.Add("Edit", "Edit_1", "w250",  "Edit_onTyping", "Hello, World!", "Status:Edit_1", "The content of Edit_1 will be copied to Edit_2")
MainGui.Add("Button", "Button_1", "wp hp","Button_onClick", "Send", "Press this button", "Press this button to display a msgbox.", "0")
MainGui.Add("Button", "Button_2", "wp hp","Button_onClick", "Send", "Press this button", "Press this button to display a msgbox.", "0")
MainGui.Add("Button", "Button_3", "wp hp","Button_onClick", "Send", "Press this button", "Press this button to display a msgbox.", "0")
MainGui.Show(50, 50)

return

class GUI { 
	
    __New(Name, WinTitle := "", Options := ""){ 
		
        static
		This.Controls := []
		this.Name := Name
		this.WinTitle := WinTitle
		
		; Building the Gui
        Gui, % this.Name ":New", HWNDhGui, %WinTitle%
		this.Handle := hGui
        Gui, +Labelmy +Resize %Options%
		
		
        OnMessage(0x05, ObjBindMethod(this, "WM_SIZE")) 
		OnMessage(0x112, ObjBindMethod(this, "WM_SYSCOMMAND"), "1") 
		OnMessage(0x200, ObjBindMethod(this, "WM_MOUSEMOVE"), "1") 
    }
	
    Button_onClick(){ ; Handling the Buttons
		Test.Button_onClick(A_GuiControl)
    }
	
    Show(x := "Center", y := "Center"){
        Gui, % this.Name ":Show", x%x% y%y%
    }
	
	Add(ControlType:="Edit", Name_Control:="Edit1", Options:="", Function:="Edit_onTyping", Value:=""){
		static
		Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%,%Value%
		Handle_Control := h%Name_Control%
		
		This.Controls[Name_Control, "Handle"]:=Handle_Control
		ControlHandler := ObjBindMethod(this, Function)
		GuiControl +g, %Handle_Control%, %ControlHandler%
	}
	
	
	Delete(){
		Gui, % this.Name ":Destroy"
    }
	
	WM_MOUSEMOVE(wParam, lParam, msg, hwnd){
        ; Run when the mouse is moving,  this function is activated
		static
		
		if (this.Name != a_gui) {
			return
		}
		
		MouseGetPos, , , WhichWindow, Curr_Control, 2
		ToolTip % Curr_Control
	
	
		
    }
	
	WM_SIZE(wParam, lParam, msg, hwnd){ ; resize events	
        if this.Handle != hwnd
			return
		
        /* wParam = "event info"
			0: The window has been restored or dragged by its edges.
			1: The window has been minimized.
			2: The window has been maximized.
        */
		
        ; lParam = (width and height)
        w := lParam & 0xFFFF    ; low word  (bits 16..32)
        h := lParam >> 16       ; high word (bits  1..15)
		
        ToolTip, Resizing ...`n%w%`n%h%`n%wParam%
    }
	
	WM_SYSCOMMAND(wParam, lParam, msg, hwnd){
		
		static SC_CLOSE := 0xF060
		if (wParam = SC_CLOSE && this.Handle = hwnd) { ; fired when closing the Gui
			MsgBox, Closing Gui %A_Gui%
			This.Delete()
		}
		return
	}
	
} ; end of class


class Test
{

    Button_onClick(GuiControl){ ; Handling the Buttons
        MsgBox % GuiControl
    }


}