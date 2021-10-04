#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

P := PayPeriod()

MsgBox % "The Next Pay for Processing is: " P["PD"] 
Return

PayPeriod() 
{

Paydates :=	{ 01:"11/07/2019" 
			, 02:"25/07/2019" 
			, 03:"08/08/2019"
			, 04:"22/08/2019"
			, 05:"05/09/2019"
			, 06:"19/09/2019"
			, 07:"03/10/2019" 
			, 08:"17/10/2019" 
			, 09:"31/10/2019" 
			, 10:"14/11/2019" 
			, 11:"28/11/2019" 
			, 12:"12/12/2019" 
			, 13:"00/00/0000" 
			, 14:"00/00/0000" 
			, 15:"00/00/0000" 
			, 16:"00/00/0000" 
			, 17:"00/00/0000" 
			, 18:"00/00/0000" 
			, 19:"19/03/2020" 
			, 20:"02/04/2020" 
			, 21:"16/04/2020" 
			, 22:"30/04/2020" 
			, 23:"14/05/2020" 
			, 24:"28/05/2020" 
			, 25:"11/06/2020" 
			, 26:"25/06/2020" }

	vNow := A_Now

	for each, date in Paydates 
	{
		vDate1 := date
		vDate1 := Format("{3}{2:02}{1:02}000000", StrSplit(vDate1, "/")*)
	
		If (vDate1 < vNow) 
			PP := A_Index+2
	}

	datefrom := vNow
	distance := Paydates[PP]
	distance -= datefrom, days

	If (distance < 10) 
	{
		PP := PP+1
		Obj := {PP:PP,PD:Paydates[PP]}
		Return Obj
	}

Obj := {PP:PP,PD:Paydates[PP]}
Return Obj
}