#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


			Xl := ComObjActive("Excel.Application")
			ComObjError(false)

			Pointer := StrReplace(Xl.ActiveSheet.Range("A:H").Find("Superannuation to be recovered from fund").Offset(5, 0).address,"$")
			Letter := SubStr(Pointer,1,1)
			Number := SubStr(Pointer,2)
			
			Loop 24
				if (Letter = Chr(96+A_Index))
					OtherLetter := Chr(96+A_Index+3)

			Xl.ActiveSheet.Range(Letter Number).value := ("Actions Taken for Super Recovery")
			Selected_Cells := Letter Number . ":" . OtherLetter Number

			Xl.ActiveSheet.Range(Selected_Cells).select
			Xl.Selection.HorizontalAlignment:=-4108
			Xl.Selection.VerticalAlignment:=-4107
			Xl.Selection.WrapText := (False)
			Xl.Selection.Orientation := (0)
			Xl.Selection.AddIndent := (False)
			Xl.Selection.ShrinkToFit := (False)
			Xl.Selection.MergeCells := (False)
			Xl.Selection.Font.Bold := (True)
			Xl.Selection.Interior.Pattern := 1
       		Xl.Selection.Interior.PatternColorIndex := -4105
			Xl.Selection.Interior.ThemeColor := 10.5

        	Xl.Selection.Interior.TintAndShade := 0-0.249977111117893
        	Xl.Selection.Interior.PatternTintAndShade := 0
			Xl.Selection.Merge
	
			Merge_and_Center(Letter Number+1, OtherLetter Number+1,"Select Action Taken")
			Xl.Rows(Number+1 ":" Number+1).EntireRow.AutoFit

			xlEdgeLeft = 7 ; http://techsupt.winbatch.com/ts/T000001033005F9.html
			xlEdgeTop = 8
			xlEdgeBottom = 9
			xlEdgeRight = 10
			xlContinuous = 1
			xlThick = 4
			xlAutomatic = -4105
			xlThin = 2

		    Xl.Range(Letter Number ":" OtherLetter Number+1).Select
		    Xl.Selection.Borders(xlDiagonalDown).LineStyle := xlNone
		    Xl.Selection.Borders(xlDiagonalUp).LineStyle := xlNone
			Xl.Selection.Borders.LineStyle := xlContinuous 
			Xl.Selection.Borders.ColorIndex := 0
			Xl.Selection.Borders.TintAndShade := 0
			Xl.Selection.Borders.Weight := xlThin 

			Xl.ActiveSheet.Range(Letter Number+1).select
			xl.Selection.Validation.Add[Type:=3,AlertStyle:=1,Operator:=3, Formula1:="Created SGR.COM, Added to Total Overpayment,Applied to Super Fund for Refund, Mixture of Processes"]
