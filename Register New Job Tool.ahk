#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global Obj
		
		Obj := {}
		InputBox, OutputVar, Checklist Complete, What is the AGS?, All Items on Checklist Have Been Reviewd.`n`nEnter AGS Number and press Okay to being next Process.
		Obj.AGS := OutputVar


		List = 
		(
Check ePOD for prev overpayment being submited from payroll
Are there any notes or instructions or important background in the email from Payroll? 
Are the attachment for the same person as the email subject line? (This has caught you out twice now!)
Is the workbook template a current one? 
Do the letters generate and have the right letter heads?
Has the workbook been filled out and Spell Checked? 
Check Paycentres on Workbook vs PIPS
Are the Financial Years and the Paid Due Diff Sheets on the right templates? ******THIS IS IMPORTANT******
Is the Payment Summary Amendment amount is correct?
Check if there is any strange outliers, eg. 1 pay the super is $48 and the super for the other pays is $84. Super is 10`% of Salary (from July 2021, 9.5`% Pre-July 2021)
		)
		
		New Checklist(List, ReturnFunction := "Validated")
		Exit
		
		Validated(){
			;MsgBox % "All Items on Checklist Have Been Reviewd.`n`nPress Okay to being next Process."

			Person_Details(a := Obj.AGS)
			Add_to_TRIM()

			Add_INFO_PTR()

			Clipboard := "Registered | Pay  | " Obj.AGS " | " Obj.SURNAME ", " Obj.NAME " (" Obj.PC ") " Obj.Date_Commenced " - " Obj.Date_Ceased
			MsgBox % "Email Subject Added to Clipboard.`n`nReady to Trim Overpayment Email and Docs."

;			for each, item in Obj
;				MsgBox % Item

		}

		Person_Details(Active_AGS)
		{
			
			MsgBox % Active_AGS
			Obj.EMPSTATUS := "Current"
			winactivate, Mochasoft
			sendinput, {F4}
			loop, 5
			{
			clipboard := 
			ClipWait, 2
			
			winactivate, Mochasoft
			sendinput, {Alt}ES
			sendinput, ^c
			
			ClipWait, 2
			if ErrorLevel
				MsgBox, The attempt to copy text onto the clipboard failed.
			
			Array := StrSplit(Clipboard, "`n")
			
				if (substr(Array[3],33,16) = "M A I N  M E N U" )
				{
					winactivate, Mochasoft
					sendinput, 1.2.1
					sendinput,{enter}
					sendinput, %Active_AGS%
					sendinput, {enter}
					Array := 
				}
			
				if (substr(Array[20],16,40) = " DO YOU WISH TO CONTINUE WITH THE DISPLA")
				{
					Obj.EMPSTATUS := "Ceased"
					winactivate, Mochasoft
					sendinput, {enter}
		
					clipboard := 
					ClipWait, 2
					
					winactivate, Mochasoft
					sendinput, {Alt}ES
					sendinput, ^c
					
					ClipWait, 2
					if ErrorLevel
						MsgBox, The attempt to copy text onto the clipboard failed.
					
					Array := StrSplit(Clipboard, "`n")
		
				}

				if (substr(Array[4],3,8) = "Casual  ")
				{
					Array :=
					winactivate, Mochasoft
					sendinput, {Alt}ES
					sendinput, ^c
					ClipWait, 2
					if ErrorLevel
						MsgBox, The attempt to copy text onto the clipboard failed.
				
					Array := StrSplit(Clipboard, "`n")
				
					Obj.SURNAME := Change_String(substr(Array[6],22,23),"Clean")
					Obj.NAME := Change_String(substr(Array[7],30,45),"Clean")
					Obj.PC := Change_String(substr(Array[18],30,4),"Clean")
					
					return 
				}

				if (substr(Array[2],3,7) = "(1.2.1)")
				{
					Array :=
					winactivate, Mochasoft
					sendinput, {Alt}ES
					sendinput, ^c
					ClipWait, 2
					if ErrorLevel
						MsgBox, The attempt to copy text onto the clipboard failed.
				
					Array := StrSplit(Clipboard, "`n")
				
					Obj.SURNAME := Change_String(substr(Array[6],22,23),"Clean")
					Obj.NAME := Change_String(substr(Array[7],22,45),"Clean")
					Obj.PC := Change_String(substr(Array[12],22,4),"Clean")
					
					return 
				}
			}
		}

		
		GetCellValue(Find,offset_X,offset_Y)
		{
			Global
			Temp := ComObjActive("Excel.Application")
			ComObjError(false)
			Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
			return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
		}

		Add_INFO_PTR()
		{

			FormatTime, Time,, dd/MM/yyyy
			Sleep 200
			winactivate, Mochasoft
			Sleep 200
			sendinput, {F4}
			Sleep 200
			sendinput, PTRC{Enter}
			sendinput, {F8}
			Sleep 2000
			Sleep 200
			sendinput, {F7}
			Sleep 200
			sendinput, INF.PTR{Enter}
			Sleep 500
			sendinput, DRTASPINF
			Sleep 200
			sendinput, Job Registered %Time% by BABB
			Sleep 200
			sendinput, % "{Tab}{Tab}INFOVP Dates: " Obj.Date_Commenced " - " Obj.Date_Ceased
			Sleep 200
			sendinput, {Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}
			sendinput,	26
			sendinput, {Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}{Shift}+{Tab}
			Sleep 200
			sendinput, Y
			Sleep 200
			sendinput, {Enter}
			Sleep 200
			sendinput, {Enter}
		}

		
		Add_to_TRIM()
		{
			Gui +OwnDialogs
			OnMessage(0x44, "OnMsgBox")
			MsgBox 0x40020, Open Workbook, Please Open the Workbook to the OP Investigation Report sheet. `n`nOnce Open`, Click Continue.
			OnMessage(0x44, "")
		
			Xl := ComObjActive("Excel.Application")
			ComObjError(false)
			Xl.Sheets("OP Investigation Report").activate
		
			Obj.Date_Commenced := GetCellValue("Date O/P commenced", 1, 0)
			Obj.Date_Ceased := GetCellValue("Date O/P ceased", 1, 0)
		
			Clipboard := "OVERPAYMENT - " Obj.SURNAME ", " Obj.NAME " (" Obj.PC ") " Obj.Date_Commenced " - " Obj.Date_Ceased
		
			Gui +OwnDialogs
			OnMessage(0x44, "OnMsgBox")
			MsgBox 0x40020, Create TRIM File:, Please Create a TRIM File. `n`nThe Title is in the clipboard.
			OnMessage(0x44, "")
		}
		
		Class Checklist {
		
			__New(List, ReturnFunction){
				Obj.ReturnFunction := ReturnFunction 
				Obj.List := List
				This.CheckListGUI(Obj)
			}
		
			CheckListGUI(Obj){
				Obj["Checklist"] := {}
		
				GUI, Color, 0xFFF7D1
				Gui, Add, Tab3,, Page 1
		
				Array := StrSplit(Obj.List, "`n")
					for each, item in Array {
						Gui, Add, Checkbox, Wrap y+10 wp +hwndh%each% -Theme, % item 
						Obj["Checklist"]["h"each] := h%each%
						If (A_Index = 5) or (A_Index = 10) or (A_Index = 15){
							GuiControl, Text, SysTabControl321, % (A_Index = 5) ? "|Page 1|Page 2" : (A_Index = 10) ? "|Page 1|Page 2|Page 3" : (A_Index = 15) ? "|Page 1|Page 2| Page 3|Page 4" :
							Gui, Tab, % (A_Index = 5) ? "2" : (A_Index = 10) ? "3" : (A_Index = 15) ? "4" :
						}  
					}
		
				Gui, Tab  
				
				Gui, Add, Button, xp y+5 wp  +hwndhOkay , Okay
		
				MenuHandler := ObjBindMethod(this,"ValidateChecklist", Obj)
				GuiControl +g, % hOkay , % MenuHandler
		
				Gui, Show,, CheckList
			}
			
			ValidateChecklist(Obj){
				for each, item in Obj["Checklist"] {
					GuiControlGet, tick,, % item 
					If (tick = 0){
						Gui, Font, cRed 
						GuiControl, Font, % item  
						s := 0
					}
				}
		
				If (s = 0)
					MsgBox % "Error: Not All Items on Checklist have been checked.`n`nMissed Items are marked red."
				Else {
					Gui, Destroy
					ReturnFunction := Obj.ReturnFunction
					%ReturnFunction%()
				}
			}
		}

		Change_String(String, Options := "") 
		{
			
			if (Options = "Title") {
				StringUpper, string, string, T
				return % string
			}
			
			if (Options = "Upper") {
				StringUpper, string, string, 
				return % string
			}
			
			if (Options = "Lower") {
				StringLower, string, string, 
				return % string
			}
			
			if (Options = "Strip") {
				return RegExReplace(string, "[^0-9.]")
			}
			
			if (Options = "Clean") {
				string := regexreplace(string, "^\s+") 
				string := regexreplace(string, "\s+$") 
				return string
			}
			
			if (Options = "Plain") {
				string = %string%
				return string
			}

			MsgBox % "Option """ Options """ is not an Option. `n`nExiting Function." 
		}
