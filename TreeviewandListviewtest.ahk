#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines, -1
#Include C:\Users\babb\Documents\Autohotkey\Lib\LV_InCellEdit.ahk

TreeRoot := "Edit Client Details:"

Global Workbook
Workbook := OrderedArray()

;1.2.1 Screen
Workbook.AGS := "85568665"
Workbook.Courtesy_Title := "Miss"
Workbook.Given_names := "Rosemary"
Workbook.Surname  := "Milliken"
Workbook.Date_of_birth  := "Date_of_birth"
Workbook.Pay_centre := "Pay_centre"

;5.6.1 Screen
Workbook.SuperRef  := "SuperRef"
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
Workbook.Distance := ""


Gui +Resize
Gui, Add, Button, w240 gSave,Save Changes
Gui, Add, Button, w240 gRefresh,Refresh
Gui, Add, ListView, -readonly gSubLV1 hwndHLV1 r20 hwndHLV1 AltSubmit vLV1, Variable Names:|Variable Contents: 

LV_ModifyCol(1, "")  ; Allows room for vertical scrollbar.
LV_ModifyCol(2, "")

Array_Gui(Workbook,TreeRoot)
ICELV1 := New LV_InCellEdit(HLV1)
Gui, Show,w400, %TreeRoot%  ; Display the source directory (TreeRoot) in the title bar.
ICELV1.OnMessage()
return

SubLV1:  
If (A_GuiEvent == "F") {
   If (ICELV1["Changed"]) {
      Msg := ""
      For I, O In ICELV1.Changed
         Msg .= "Row " . O.Row . " - Column " . O.Col . " : " . O.Txt
      ICELV1.Remove("Changed")
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

GuiClose: 
ExitApp


Array_Gui(Array, Parent="") {

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

KillToolTip:
   ToolTip
Return

Save:

Loop % LV_GetCount()
{
LV_GetText(VarName, A_Index)
LV_GetText(VarData, A_Index, 2)
workbook[VarName] := VarData
}
Return
