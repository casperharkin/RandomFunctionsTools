#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Msgbox % Pay_hash("28/11/2019")
Msgbox % Pay_hash("11")

Return

Pay_hash(Input)
{	
	hash :=	{ "01":"11/07/2019" 
			, "02":"25/07/2019" 
			, "03":"08/08/2019"
			, "04":"22/08/2019"
			, "05":"05/09/2019"
			, "06":"19/09/2019"
			, "07":"03/10/2019" 
			, "08":"17/10/2019" 
			, "09":"31/10/2019" 
			, "10":"14/11/2019" 
			, "11":"28/11/2019" 
			, "12":"12/12/2019" 
			, "13":"26/12/2019" 
			, "14":"09/01/2020" 
			, "15":"23/01/2020" 
			, "16":"06/02/2020" 
			, "17":"20/02/2020" 
			, "18":"05/03/2020" 
			, "19":"19/03/2020" 
			, "20":"02/04/2020" 
			, "21":"16/04/2020" 
			, "22":"30/04/2020" 
			, "23":"14/05/2020" 
			, "24":"28/05/2020" 
			, "25":"11/06/2020" 
			, "26":"25/06/2020" }

if (StrLen(Input) = 10)
	for key, value in hash
		if (value = Input)
			Return _Pay_Date := Key

if (StrLen(Input) = 2)
	return _Pay_Cycle := hash["" . Input . ""]
}
