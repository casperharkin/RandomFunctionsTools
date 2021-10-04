#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

VBA_Data := {}

VBA = 
(
Sub Macro1()
'
' Macro1 Macro
'

'
    Range("H203:I203").Select
    With Selection
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlTop
        .WrapText = False
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    Selection.Merge
    ActiveCell.FormulaR1C1 = "Test - 05/11/2019"
    Range("H203:I203").Select
    With Selection.Font
        .Color = -16776961
        .TintAndShade = 0
    End With
    With Selection.Interior
        .Pattern = xlSolid
        .PatternColorIndex = xlAutomatic
        .Color = 10498160
        .TintAndShade = 0
        .PatternTintAndShade = 0
    End With
    With Selection.Font
        .ThemeColor = xlThemeColorLight1
        .TintAndShade = 0
    End With
    Range("I204").Select
End Sub
)

Loop, parse, VBA, "`r`n"
	if InStr(A_Loopfield, "Range")
		 VBA_Data.Range[A_Index] := StrSplit(VBA,"`n")[A_Index]

Return
G::
		;MsgBox % "Line " A_index " is " A_Loopfield