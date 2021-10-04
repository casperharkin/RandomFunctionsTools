#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


MsgBox 0x24, Generate Super Email?, Do you wish to Generate a Super Email?

IfMsgBox Yes	
	GenerateaSuperEmail := True
Else IfMsgBox No
	GenerateaSuperEmail := False

emailbuild(GenerateaSuperEmail)

Exit
emailbuild(GenerateaSuperEmail) {

	Client := {}

	winactivate, Mochasoft
	
	clipboard := 
	ClipWait, 2
	
	winactivate, Mochasoft
	sendinput, {Alt}ES
	sendinput, ^c
	
	ClipWait, 3
	if ErrorLevel
		MsgBox, The attempt to copy text onto the clipboard failed.
	
	Array := StrSplit(Clipboard, "`n")

	if (substr(Array[3],37,9) = "Addresses") {
		Client._AGS := StrReplace(substr(Array[4],22,21),A_Space)
		Client._NameLast := Change_String(substr(Array[5],22,21),"Clean")
		Client._NameFirst := Change_String(substr(Array[6],22,21),"Clean")
		Client._Email := Change_String(substr(Array[11],18,25),"Clean")
		Client._Title := substr(Array[7],22,4)
	}

default_Text =
(

I wish to advise that a salary overpayment has occurred with your pay. 

Please refer to the attached letter for further information. Full details of the overpayment are provided in the attached letter and ‘Paid/Due/Difference’ explanation. 

To advise your preferred repayment option, please complete and sign the attached Recovery Authorisation for Salary Overpayment and return to payrolldebtrecovery.asp@nt.gov.au within 10 working days from the date of this email. If you wish to repay at less than the scheduled amount per fortnight please complete Section 5 of the form and return for submission to your Agency for their consideration. 

If you have any queries regarding the calculations supplied please contact Payroll Debt Recovery Services.

We apologise for any inconvenience this may cause.
)
	
	m :=	ComObjActive("Outlook.Application").CreateItem(0)
	m.Subject := "Notification of Salary Overpayment - " . Client._AGS . " | " . Client._NameLast " , " Client._NameFirst
	m.To :=	Client._Email,m.Display
	myInspector :=	m.GetInspector, myInspector.Activate
	wdDoc :=	myInspector.WordEditor
	wdRange :=	wdDoc.Range(0, wdDoc.Characters.Count)
	wdRange.InsertBefore("Dear " . Workbook_Class.Change_String(Client._Title,"Clean") . " " . Workbook_Class.Change_String(Client._NameLast,"Title") . "`n`r" . default_Text)
	m.Attachments.Add("C:\Users\babb\Documents\Blank.txt")
	m.SentOnBehalfOfName := "Payrolldebtrecovery.asp@nt.gov.au"
	
	Val := Client._NameLast
	Val2 := Client._NameFirst
	Val3 := Client._AGS

	If (GenerateaSuperEmail = True) {
SuperText =
(

Please find attached request for reimbursement of overpaid superannuation contributions.

Employee Name: 		%Val%, %Val2%
Employee AGS Number: 	%Val3%
Reason for Overpayment: 	

Calculations of overpayment are attached for your information.


Super refund to DCIS
A/C Name: DCIS Payroll Super
BSB:	  085 933 
A/C:	  944 008 093
Ref:	  %Val3%

)

	m :=	ComObjActive("Outlook.Application").CreateItem(0)
	m.Subject := "Overpaid Super - " . Client._AGS . " | " . Client._NameLast " , " Client._NameFirst
	m.To :=	"BLANK",m.Display
	myInspector :=	m.GetInspector, myInspector.Activate
	wdDoc :=	myInspector.WordEditor
	wdRange :=	wdDoc.Range(0, wdDoc.Characters.Count)
	wdRange.InsertBefore(SuperText)
	m.Attachments.Add("C:\Users\babb\Documents\Blank.txt")
	m.SentOnBehalfOfName := "Payrolldebtrecovery.asp@nt.gov.au"
	Return
	}
}

Change_String(String, Options := "") {

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