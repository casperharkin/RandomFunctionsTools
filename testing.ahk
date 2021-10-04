#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

New TreeViewCreator 
Exit

class TreeViewCreator { 
	
    __New(){ 

		This.CreateHoverButton( Name_Control, Options := "", Function := "", Value := "", DIB := "")
		Gui,Show, w260
	}


	CreateHoverButton( Name_Control, Options := "", Function := "", Value := "", DIB := ""){

		this.AddControl("Picture", Name_Control . "N", Options . " Hidden0 ", "", "","0173C7")
;		this.AddControl("Picture", Name_Control . "H", Options . " Hidden1 ", "", "","2A8AD4")
;		this.AddControl("Text"	 , Name_Control . "Text", Options . " +BackgroundTrans +0x201 ","", Value )
	}
	


	AddControl(ControlType, Name_Control, Options := "", Function := "", Value := "", DIB := ""){
		Static	
		Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%, %Value%
		Handle_Control := h%Name_Control%
		This.GuiObj[Name_Control, "Handle"] := Handle_Control
;		ControlHandler := Func(Function).Bind(This.GuiObj[Name_Control, "Handle"])
;		GuiControl +g, %Handle_Control%, %ControlHandler%
		If !DIB {
			DllCall("SendMessage", "Ptr", Handle_Control, "UInt", 0x172, "Ptr", 0, "Ptr", this.CreateDIB(DIB, 1, 1))

		}
	}

}