#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global Workbook
Workbook := OrderedArray()
Workbook.AGS := "85568665"
Workbook.Surname  := "Milliken"
Workbook.Given_names := "Rosemary"
Workbook.Date_of_birth  := ""
Workbook.Pay_centre := ""
Workbook.Courtesy_Title := "Miss"
Workbook.SuperRef  := ""
Workbook.SuperFund := ""
Workbook.SuperFundAddress  := ""
Workbook.SuperFundName  := ""
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
Workbook.SuperAmount  := ""
Workbook.GrossAmount  := ""
Workbook.SalarySacAmountGross  := ""
Workbook.CantRecovreSuper := "" 
Workbook.Pay_Cycle := ""
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
Workbook.Paydate := ""
Workbook.Distance := ""


Gui +Resize
Gui Add, Treeview,  w250 h300 gMenuHand2
Gui Add,  ListView, x+5 w350 h250 hwndhLV1 gMenuHand, Data
Gui Show, , Variables


For key, value in Array_Gui(Workbook,"Variables")
    TV_Add(key)

Return

MenuHand:

Return

MenuHand2:
LV_Delete()
TV_GetText(NameOfTreeSelection, A_EventInfo)
LV_Add("",Workbook[NameOfTreeSelection])
	
Return

Array_Gui(Array, Parent="") {
	if !Parent
	{
		Gui, +HwndDefault
		Gui, New, +HwndGuiArray +LabelGuiArray +Resize
		Gui, Margin, 5, 5
		Gui, Add, TreeView, w300 h200
		
		Item := TV_Add("Array", 0, "+Expand")
		Array_Gui(Array, Item)
		
		Gui, Show,, GuiArray
		Gui, %Default%:Default
		
		WinWait, ahk_id%GuiArray%
		WinWaitClose, ahk_id%GuiArray%
		return
	}
	
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
	GuiControl, Move, SysTreeView321, % "w" A_GuiWidth - 10 " h" A_GuiHeight - 10
	GuiControl, Move, hLV1, % "w" A_GuiWidth - 10 " h" A_GuiHeight - 10
	return
}

