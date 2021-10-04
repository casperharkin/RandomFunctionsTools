#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#Persistent
#Include <General>
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1

Global Workbook, ExitThreadFlag, ContextMenu, LV1, Auto ;Make avalible from anywhere in script
ExitThreadFlag := False ; Settings Exit Flag to False
Initial()

#RButton::Menu, ContextMenu, Show ;Set Windows Key + Right Click as hotkey for Cotnext Menu
return

#q::ExitThreadFlag := !ExitThreadFlag ; Toggle Exit Thread
Return

; ############################### START OF CONTEXT MENU HANDLER ##############

ContextMenuHandler()
{

Sleep(0) ;Sleep Zero Seconds but check if ExitThreadFlag is True

If (A_ThisMenuItem = "Load Client Data")
{
	Inputbox, Workbook_AGS, Load Client via AGS, Please Enter AGS.,,,,,,,,85490589
		LoadAGS(Workbook_AGS)
}

If (A_ThisMenuItem = "Prepare Paid Due Diff")
{
	PreparePaidDueDiff(Workbook_AGS)
}

If (A_ThisMenuItem = "Process Workbook")
{
	ProcessWorkbook(Workbook_AGS)
}

If (A_ThisMenuItem = "Create ePOD Record")
{
	CreateePODRecord()
}

If (A_ThisMenuItem = "Adjust Cumlative Totals")
{
	AdjustCumlativeTotals()
}

If (A_ThisMenuItem = "Enter Recovery PTR")
{
	EnterRecoveryAction()
}

If (A_ThisMenuItem = "Edit Client Data")
{
	EditClientData:
	Gui, Destroy
	Gui New: 
	Gui +Resize
	Gui, Add, Button, w240 gSave,Save Changes
	Gui, Add, Button, w240 gRefresh,Refresh
	Gui, Add, ListView, -readonly gSubLV1 hwndHLV1 r20 hwndHLV1 AltSubmit vLV1, Variable Names:|Variable Contents: 
	LV_ModifyCol(1, "")  ; Allows room for vertical scrollbar.
	LV_ModifyCol(2, "")
	
	TreeRoot := "Edit Client Details:"
	
	Array_Gui(Workbook,TreeRoot)
	ICELV1 := New LV_InCellEdit(HLV1)
	Gui, Show,w400, %TreeRoot%  ; Display the source directory (TreeRoot) in the title bar.
	ICELV1.OnMessage()
}

If (A_ThisMenuItem = "Clear Client Data")
{
	Workbook := ""
	Menu, ContextMenu, DeleteAll
	Initial()
}


}
return 
; ############################### END OF CONTEXT MENU HANDLER ###############################

LoadAGS(AGS)
{
if(!AGS) 
	InputBox, AGS,Enter AGS No.,Please Enter the AGS No. of the Client.,,200,150
		if ErrorLevel
		    {
				MsgBox,,, % "User Cancelled Request.`n`n`nExiting Application.",1
				return
			}

Workbook.AGS := AGS
Person_Details(Workbook.AGS)
Superannuation_Details(Workbook.AGS)
SuperInfoFetch(Workbook.SuperFund)
Address_Details(Workbook.AGS)

NewMenuTitle := Workbook.AGS " | " Workbook.Surname . ", " . Workbook.Given_names

Menu NewMenuTitle, Add, Edit Client Data, ContextMenuHandler
Menu NewMenuTitle, Add, Clear Client Data, ContextMenuHandler
Menu, ContextMenu, Rename, 1&,%NewMenuTitle%
Menu, ContextMenu, add, 1&, :NewMenuTitle
msgbox % "Client: `n`n" Workbook.AGS " | " Workbook.Surname . ", " . Workbook.Given_names  "`n`nhas been Loaded."

}


Initial()
{

Workbook := OrderedArray() ;Creating Empty Workbook Obeject

;1.2.1 Screen
Workbook.AGS := "85490589"
Workbook.Courtesy_Title := "Ms"
Workbook.Given_names := "Helen"
Workbook.Surname  := "Shih"
Workbook.Date_of_birth  :=  "21 Oct 1981"
Workbook.Pay_centre :=  "441"

;5.6.1 Screen
Workbook.SuperRef  :=  ""
Workbook.SuperFund := ""
Workbook.SuperFundAddress  := ""
Workbook.SuperFundName  := ""
Workbook.SuperAmount  := ""
Workbook.CantRecovreSuper := "" 

;1.2.3 Screen
Workbook.Street_1 := ""
Workbook.Street_2 := ""
Workbook.Street_3 := ""
Workbook.City  := ""
Workbook.State  := ""
Workbook.PostCode  := ""
Workbook.Phone  := ""
Workbook.FAX  := ""
Workbook.Email  := ""


Workbook.TaxAmount  := ""
Workbook.NettAmount  := ""
Workbook.SalarySacAmount  := ""
Workbook.DeductionsAmount  := ""
Workbook.GrossAmount  := ""
Workbook.SalarySacAmountGross  := ""
Workbook.Pay_Cycle := ""
Workbook.Paydate := ""
Workbook.Percentage := ""
Workbook.FBT := ""
Workbook.Date_Detected := ""
Workbook.Date_Commenced := ""
Workbook.Date_Ceased := ""
Workbook.TotalAmount := ""
Workbook.Reason  := ""
Workbook.Error_Source := ""
Workbook.Error_Type := ""
Workbook.Error_Cause := ""
Workbook.Location := ""
Workbook.RPMENT := ""
Workbook.TAXPYM := ""
Workbook.RDRENT := ""
Workbook.RCYCOM := ""
Workbook.Percentage := ""
Workbook.AgeOfDebt := ""

; ################## Build the Context Menu #############################

Menu ContextMenu, Add, No Client Loaded, ContextMenuHandler, :NewMenuTitle
;Menu ContextMenu, Icon, Chrome, C:\Users\babb\AppData\Local\Google\Chrome\Application\chrome.exe,,32
Menu ContextMenu, Add,
Menu ContextMenu, Add, Load Client Data, ContextMenuHandler
;Menu ContextMenu, Icon, Load Client Data, shell32.dll, 171,32
Menu ContextMenu, Add, Prepare Paid Due Diff, ContextMenuHandler
;Menu ContextMenu, Icon, Prepare Paid Due Diff, shell32.dll, 171,32	
Menu ContextMenu, Add, Process Workbook, ContextMenuHandler
;Menu ContextMenu, Icon, Process Workbook, shell32.dll, 89,32
Menu ContextMenu, Add, Create ePOD Record, ContextMenuHandler
;Menu ContextMenu, Icon, Create ePOD Record, C:\Users\babb\Desktop\Temp File\output_onlinepngtools_dld_icon (1).ico,,32
Menu ContextMenu, Add, Adjust Cumlative Totals, ContextMenuHandler
;Menu ContextMenu, Icon, Adjust Cumlative Totals,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,,32
Menu ContextMenu, Add, Enter Recovery PTR, ContextMenuHandler
;Menu ContextMenu, Icon, Enter Recovery PTR,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,, 32
return
}

SubLV1()
{  
If (A_GuiEvent == "F") {
   If (ICELV1["Changed"]) {
      Msg := ""
      For I, O In ICELV1.Changed
         Msg .= "Row " . O.Row . " - Column " . O.Col . " : " . O.Txt
      ICELV1.Remove("Changed")
   }
}
}
return

GuiSize:  ; Expand/shrink the ListView and TreeView in response to user's resizing of window.
if (A_EventInfo = 1)  ; The window has been minimized. No action needed.
    return

GuiControl, Move, LV1, % "H" . (A_GuiHeight-75) . " W" . (A_GuiWidth-20)
GuiControl, Move, Refresh, % " W" . (A_GuiWidth-20)
GuiControl, Move, Save, % " W" . (A_GuiWidth-20)
GuiWidth := A_GuiWidth
Refresh()
return

GuiClose%TreeRoot%: 
Gui, Destroy 
return

Array_Gui(Array, Parent="") 
{

	For Key, Value in Array
		{
			Item := TV_Add(Key, Parent)
			if (IsObject(Value))
				Array_Gui(Value, Item)
		}
	return
	
	GuiArrayClose:
	Gui, Destroy
	return
	
	GuiArraySize:
	GuiControl, Move, SysTreeView321, % "w" A_GuiWidth - 10 " h" A_GuiHeight - 100
	return
}

Refresh()
{
	LV_Delete()
	GuiControl, -Redraw, MyListView 
	
	For Key, Value in Workbook
		LV_Add("", Key , Value )
	
	LV_ModifyCol(1,"")   
	LV_ModifyCol(2,Auto)
	GuiControl, +Redraw, MyListView
}
Return

Save:
Loop % LV_GetCount()
	{
		LV_GetText(VarName, A_Index)
		LV_GetText(VarData, A_Index, 2)
		workbook[VarName] := VarData
	}
Return

