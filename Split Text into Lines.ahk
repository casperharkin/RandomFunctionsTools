

Return

~^v::
MouseGetPos, , , , OutputVarControl

if (OutputVarControl = "Edit5")
{
Array := StrSplit(SplitTextForGAS(Clipboard),"`n")
ControlSetText, Edit5, % Array[1] , GAS Notes Wizard
ControlSetText, Edit6, % Array[2] , GAS Notes Wizard
ControlSetText, Edit7, % Array[3] , GAS Notes Wizard
ControlSetText, Edit8, % Array[4] , GAS Notes Wizard
ControlSetText, Edit9, % Array[5] , GAS Notes Wizard
}
Else
	Return
Return

SplitTextForGAS(vText)
{
VarSetCapacity(vOutput, StrLen(vText)*2)

Loop, Parse, vText, `n, `r
{
	vTemp := A_LoopField
	Loop
	{
		if (StrLen(vTemp) <= 55)
		{
			vOutput .= vTemp "`n"
			break
		}
		vPos := 56
		vPosB := vPos - StrLen(vTemp) - !vIsV1
		vPos := InStr(vTemp, " ", 0, vPosB)
		if !vPos
		{
			MsgBox, % "script ended: space not found"
			return
		}
		vOutput .= SubStr(vTemp, 1, vPos-1) "`n"
		vTemp := SubStr(vTemp, vPos+1)
	}

}
return vOutput
}

