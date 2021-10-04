		New TreeViewCreator()
		Exit ; EOAES
		
		
		class TreeViewCreator { ; GUI update to EntropicBlackhole's TreeView List Creator v1.1 
								; https://old.reddit.com/r/AutoHotkey/comments/py1oac/treeview_list_creator_v11_completed/
			
		    __New(){ 
				Global 
				Gui, +HWNDhGUI +LastFound -Resize +Caption +Border -ToolWindow  +SysMenu  
				Gui, Color, FFFFFF
				
				Gui Font, s15 cFFFFFF +Bold, Segoe UI  
				Gui Add, Picture, % " x" 0 " y" 0 " w" 260 " h" 60 " +0x4E +HWNDhTitleN Hidden0"
				Gui Add, Text, % " x" 0 " y" 0 " w" 260 " h" 60 " +HWNDhTitleText +BackgroundTrans +0x201", % "TreeView List Creator"
				DllCall("SendMessage", "Ptr", hTitleN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				Gui Font,
				
				Gui,Add,GroupBox,x5 y69 w250 h75,Add Items:
				Gui,Add,Edit,x12 y84 w240 h21 +HWNDhEditControl,
		
;				Gui Font, s9 cFFFFFF +Bold, Segoe UI  
;				Gui Add, Picture, % " x" 11 " y" 108 " w" 120 " h" 30 " +0x4E +HWNDhButtonAddBranchN Hidden0"
;				Gui Add, Picture, % " x" 11 " y" 108 " w" 120 " h" 30 " +0x4E +HWNDhButtonAddBranchH Hidden1"
;				Gui Add, Text, % " x" 11 " y" 108 " w" 120 " h" 30 " +HWNDhButtonAddBranchText +BackgroundTrans +0x201", % "Add Branch"
;				DllCall("SendMessage", "Ptr", hButtonAddBranchN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
;				DllCall("SendMessage", "Ptr", hButtonAddBranchH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
;				Gui Font,

				this.BuildHoverEl("ButtonAddBranch", " x11 y108 w120 h30 ", Function := "", "Add Branch", DIB := "")
				
				


				Gui Font, s9 cFFFFFF +Bold, Segoe UI  
				Gui Add, Picture, % " x" 132 " y" 108 " w" 120 " h" 30 " +0x4E +HWNDhButtonAddChildN Hidden0"
				Gui Add, Picture, % " x" 132 " y" 108 " w" 120 " h" 30 " +0x4E +HWNDhButtonAddChildH Hidden1"
				Gui Add, Text, % " x" 132 " y" 108 " w" 120 " h" 30 " +HWNDhButtonAddChildText +BackgroundTrans +0x201", % "Add Child"
				DllCall("SendMessage", "Ptr", hButtonAddChildN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				DllCall("SendMessage", "Ptr", hButtonAddChildH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
				Gui Font,
				
				Gui,Add,GroupBox,x5 y146 w250 h305,Live View:
				Gui,Add,TreeView,x11 y162 w240 h250 +HWNDhListViewControl,
				
				Gui Font, s9 cFFFFFF +Bold, Segoe UI  
				Gui Add, Picture, % " x" 11 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonEditN Hidden0"
				Gui Add, Picture, % " x" 11 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonEditH Hidden1"
				Gui Add, Text, % " x" 11 " y" 416 " w" 60 " h" 28 " +HWNDhButtonEditText +BackgroundTrans +0x201", % "Edit"
				DllCall("SendMessage", "Ptr", hButtonEditN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				DllCall("SendMessage", "Ptr", hButtonEditH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
				Gui Font,
		
				Gui Font, s9 cFFFFFF +Bold, Segoe UI 
				Gui Add, Picture, % " xp+" 60 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonDeleteN Hidden0"
				Gui Add, Picture, % " xp" 0 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonDeleteH Hidden1"
				Gui Add, Text, % " xp" 0 " y" 416 " w" 60 " h" 28 " +HWNDhButtonDeleteText +BackgroundTrans +0x201", % "Delete"
				DllCall("SendMessage", "Ptr", hButtonDeleteN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				DllCall("SendMessage", "Ptr", hButtonDeleteH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
				Gui Font,
		
				Gui Font, s9 cFFFFFF +Bold, Segoe UI 
				Gui Add, Picture, % " xp+" 60 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonCopyN Hidden0"
				Gui Add, Picture, % " xp" 0 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonCopyH Hidden1"
				Gui Add, Text, % " xp" 0 " y" 416 " w" 60 " h" 28 " +HWNDhButtonCopyText +BackgroundTrans +0x201", % "Copy"
				DllCall("SendMessage", "Ptr", hButtonCopyN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				DllCall("SendMessage", "Ptr", hButtonCopyH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
				Gui Font,
		
				Gui Font, s9 cFFFFFF +Bold, Segoe UI 
				Gui Add, Picture, % " xp+" 60 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonResetN Hidden0"
				Gui Add, Picture, % " xp" 0 " y" 416 " w" 60 " h" 28 " +0x4E +HWNDhButtonResetH Hidden1"
				Gui Add, Text, % " xp" 0 " y" 416 " w" 60 " h" 28 " +HWNDhButtonResetText +BackgroundTrans +0x201", % "Reset"
				DllCall("SendMessage", "Ptr", hButtonResetN, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("0173C7", 1, 1))
				DllCall("SendMessage", "Ptr", hButtonResetH, "UInt", 0x172, "Ptr", 0, "Ptr", This.CreateDIB("2A8AD4", 1, 1))
				Gui Font,
		
				Gui,Show, w260
				
				OnMessage(0x200, ObjBindMethod(this,"WM_MOUSEMOVE"))
				OnMessage(0x202, ObjBindMethod(this,"WM_LBUTTONUP"))
				VarSetCapacity(TME, 16, 0), NumPut(16, TME, 0), NumPut(2, TME, 4), NumPut(hGUI, TME, 8)
			}

			BuildHoverEl(Name_Control, Options := "", Function := "", Value := ""){
				Gui Font, s9 cFFFFFF +Bold, Segoe UI 
				This.AddControl("Picture", Name_Control . "N", Options . " +0x4E  Hidden0", Function := "", , DIB := "0173C7")
				This.AddControl("Picture", Name_Control . "H", Options . " +0x4E  Hidden1", Function := "", , DIB := "2A8AD4")
				This.AddControl("Text", Name_Control . "Text", Options . " +BackgroundTrans +0x201 ", Function := "", Value, DIB := "")
				Gui Font,
			}


			AddControl(ControlType, Name_Control, Options := "", Function := "", Value := "", DIB := ""){
				Global
				Gui, Add, %ControlType%, HWNDh%Name_Control% v%Name_Control% %Options%, %Value%
				Handle_Control := h%Name_Control%

				If DIB
					DllCall("SendMessage", "Ptr", Handle_Control, "UInt", 0x172, "Ptr", 0, "Ptr", this.CreateDIB(DIB, 1, 1))
			}		

			AddBranch(){
				GuiControlGet, OutputVar,, Edit1
				If !OutputVar
					InputBox, OutputVar, New Name, , , 140, 100
		
				TV_Add(OutputVar, , "Expand")
				GuiControl, , Edit1
				GuiControl, Focus, Edit1
			}
		
			AddChild(){
				Selected := TV_GetSelection()
				If !Selected 
					Return
				GuiControlGet, OutputVar,, Edit1
				If !OutputVar
					InputBox, OutputVar, New Name, , , 140, 100
		
				TV_Add(OutputVar, Selected, Options "Expand")
				GuiControl, , Edit1
				GuiControl, Focus, Edit1
			}
		
			Copy(){
				MsgBox % clipboard := This.TV_GetTree()
			}
		
			TV_GetTree(ItemID := 0, Level := 0) { ; just me - https://www.autohotkey.com/boards/viewtopic.php?style=17&t=94814&p=421735
			   Text := ""
			   If (ItemID = 0) {
			      ItemID := TV_GetNext()
			      Text := "ID0 := 0`r`n"
			   }
			   While (ItemID){
			      TV_GetText(ItemText, ItemID)
			      Text .= "ID" . (Level + 1) . " := TV_Add(""" . ItemText . """, ID" . Level . ")`r`n"
			      If ChildID := TV_GetChild(ItemID)
			         Text .= This.TV_GetTree(ChildID, Level + 1)
			      ItemID := TV_GetNext(ItemID)
			   }
			   Return (Level = 0 ? RTrim(Text, "`r`n") : Text)
			}
		
			Edit(){
				GuiControlGet, OutputVar,, Edit1
				If !OutputVar
					InputBox, OutputVar, New Name, , , 140, 100
				Selected := TV_GetSelection()
				TV_Modify(Selected, , OutputVar)
			}
		
			Delete(){
				Selected := TV_GetSelection()
				if (Selected = 0)
				    MsgBox, 8208, Sorry, Select an item first., 0
				else
				    TV_Delete(Selected)
			}
		
			WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) 
			{
				Global
				DllCall("TrackMouseEvent", "UInt", &TME)
				MouseGetPos,,,, MouseCtrl, 2
				GuiControl, % (MouseCtrl = hButtonAddBranchText) ? "Show" : "Hide", % hButtonAddBranchH
				GuiControl, % (MouseCtrl = hButtonAddChildText) ? "Show" : "Hide", % hButtonAddChildH
				GuiControl, % (MouseCtrl = hButtonEditText) ? "Show" : "Hide", % hButtonEditH
				GuiControl, % (MouseCtrl = hButtonDeleteText) ? "Show" : "Hide", % hButtonDeleteH
				GuiControl, % (MouseCtrl = hButtonCopyText) ? "Show" : "Hide", % hButtonCopyH
				GuiControl, % (MouseCtrl = hButtonResetText) ? "Show" : "Hide", % hButtonResetH
			}
			
			WM_LBUTTONUP(wParam, lParam, Msg, Hwnd) {
				Global
				If (MouseCtrl = hButtonAddBranchText) {
					This.AddBranch()
				}
				If (MouseCtrl = hButtonAddChildText) {
					This.AddChild()
				}
				If (MouseCtrl = hButtonEditText) {
					This.Edit()
				} 
				If (MouseCtrl = hButtonDeleteText) {
					This.Delete()
				} 
				If (MouseCtrl = hButtonCopyText) {
					This.Copy()
				} 
				If (MouseCtrl = hButtonResetText) {
					Reload
				} 
			}
			
			CreateDIB(Input, W, H, ResizeW := 0, ResizeH := 0, Gradient := 1 ) ; TheDewd - https://www.autohotkey.com/boards/viewtopic.php?t=3851&start=140
			{
				_WB := Ceil((W * 3) / 2) * 2, VarSetCapacity(BMBITS, (_WB * H) + 1, 0), _P := &BMBITS
				Loop, Parse, Input, |
				{
					_P := Numput("0x" . A_LoopField, _P + 0, 0, "UInt") - (W & 1 && Mod(A_Index * 3, W * 3) = 0 ? 0 : 1)
				}
				hBM := DllCall("CreateBitmap", "Int", W, "Int", H, "UInt", 1, "UInt", 24, "Ptr", 0, "Ptr")
				hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x2008, "Ptr")
				DllCall("SetBitmapBits", "Ptr", hBM, "UInt", _WB * H, "Ptr", &BMBITS)
				If (Gradient != 1) {
					hBM := DllCall("CopyImage", "Ptr", hBM, "UInt", 0, "Int", 0, "Int", 0, "UInt", 0x0008, "Ptr")
				}
				return DllCall("CopyImage", "Ptr", hBM, "Int", 0, "Int", ResizeW, "Int", ResizeH, "Int", 0x200C, "UPtr")
			}
		
		}