		
		New Percentage_Calc
		Exit
		
		Class Percentage_Calc {
		
			__New(){
				static
				This.Controls := []
				This.Name := "Percentage_Finder"
		
				Gui, % this.Name ":New", HWNDhGui +AlwaysOnTop +ToolWindow +Border, % This.Name
					This.Handle := hGui
		
				Gui, Color, Black, 282a2e
				Gui Font, s11 Cwhite, Consolas
		
				This.Add("Text","Calc1"," x10 y10  h16   ","onClick","What is         % of")
				This.Add("Edit","1st_Calc1"," x70 y08 w65 h20 +BackgroundTrans ")
				This.Add("Edit","2nd_Calc1"," x180 y08 w55 h20 ","onTyping")
				This.Add("Edit","Answer_Calc1"," x240 y08 w70 h20 +readonly")
		
				This.Add("Text","Calc2"," x80 y40   h16 +0x200 ","onClick","is what % of ")
				This.Add("Edit","1st_Calc2"," x10 y38 w65 h20 ")
				This.Add("Edit","2nd_Calc2"," x180 y38 w55 h20 ","onTyping")
				This.Add("Edit","Answer_Calc2"," x240 y38 w70 h20 +readonly")
		
				This.Add("Text","Calc3"," x80 y72   h16 +0x200 ","onClick","is        % of what")
				This.Add("Edit","1st_Calc3"," x10 y68 w65 h20  ")
				This.Add("Edit","2nd_Calc3"," x100 y68 w55 h20 ","onTyping")
				This.Add("Edit","Answer_Calc3"," x240 y68 w70 h20 +0x200 +readonly")
		
				This.Add("Text","Static4"," x10 y100 w300 h16 +0x200 ", ,"-------- Find % of Gain/Loss --------")
		
				This.Add("Edit","Answer_Calc4"," x240 y125 w70 h20 +0x200 +readonly")
				This.Add("Edit","1st_Calc4"," x55 y125 w70 h20 ")
				This.Add("Edit","2nd_Calc4"," x160 y125 w75 h20 ","onTyping")
				This.Add("Text","Calc4"," x10 y128 h16 +0x200 ","onClick","From:")
				This.Add("Text","Calc4_2"," x128 y128 h16 +0x200 ","onClick","To:")
		
				This.Show()
			}
		
			onTyping(hwnd, GuiEvent, EventInfo){ ; Handling of Typing events
			If (hwnd = This.Controls["2nd_Calc1"]["Handle"])
				GuiControl, Text, % This.Controls["Answer_Calc1"]["Handle"] , % Floor(Round(((This.GuiControlGet(This.Controls["1st_Calc1"]["Handle"])*This.GuiControlGet(This.Controls["2nd_Calc1"]["Handle"]))/100),2) )
			If (hwnd = This.Controls["2nd_Calc2"]["Handle"])
				GuiControl, Text, % This.Controls["Answer_Calc2"]["Handle"] , % Round(((This.GuiControlGet(This.Controls["1st_Calc2"]["Handle"])*100)/This.GuiControlGet(This.Controls["2nd_Calc2"]["Handle"])),2)`%  
			If (hwnd = This.Controls["2nd_Calc3"]["Handle"])
				GuiControl, Text,  % This.Controls["Answer_Calc3"]["Handle"], % Round(((This.GuiControlGet(This.Controls["1st_Calc3"]["Handle"])*100) / This.GuiControlGet(This.Controls["2nd_Calc3"]["Handle"])))  
			If (hwnd = This.Controls["2nd_Calc4"]["Handle"])
				GuiControl, Text,  % This.Controls["Answer_Calc4"]["Handle"], % Round(((This.GuiControlGet(This.Controls["2nd_Calc4"]["Handle"])-This.GuiControlGet(This.Controls["1st_Calc4"]["Handle"])) / This.GuiControlGet(This.Controls["1st_Calc4"]["Handle"])) * 100 ,2)`%
			}
		
			onClick(hwnd, GuiEvent, EventInfo){ ; Handling of Click events (Not really needed; as you can swap the Order of Control Creations to get same result)
				If (A_GuiControl = "Calc1")
					GuiControl, Focus, % This.Controls["1st_Calc1"]["Handle"]
				If (A_GuiControl = "Calc2")
					GuiControl, Focus, % This.Controls["2nd_Calc2"]["Handle"]
				If (A_GuiControl = "Calc3")
					GuiControl, Focus, % This.Controls["2nd_Calc3"]["Handle"]
			}
		
			Add(ControlType:="Edit", Name_Control:="Edit1", Options:="", Function:="Edit_onTyping", Value:=""){
				static
				Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%,%Value%
				Handle_Control := h%Name_Control%
				This.Controls[Name_Control, "Handle"]:= Handle_Control
				ControlHandler := ObjBindMethod(this, Function)
				GuiControl +g, %Handle_Control%, %ControlHandler%
			}
		
		    Show(x := "Center", y := "Center"){
		        Gui, % "Show", x%x% y%y%
		    }
		
			GuiControlGet(Control){
				GuiControlGet, Output,, % Control
				return Output
			}
		}
