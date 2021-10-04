#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui Add, Text, x8 y7 w120 h23 +0x200 +Center, Customer ID:
Gui Add, Text, x141 y7 w120 h23 +0x200 +Center, Invoice No.:
Gui Add, Text, x274 y7 w120 h23 +0x200 +Center, Name:
Gui Add, Text, x408 y7 w120 h23 +0x200 +Center, Email:
Gui Add, Edit, x8 y31 w120 h21 vCID, QUAI00123325
Gui Add, Edit, x141 y31 w120 h21 vInvoiceNo, 709048901
Gui Add, Edit, x275 y31 w120 h21 vName, SUHAD ARNAB
Gui Add, Edit, x409 y31 w120 h21 vEmail, SUHAD.ARNAB@GMAIL.COM
gui, font, s20 underline
Gui Add, Button, x8 y59 w522 h58 gOkay, Covid Invoice
gui, font,

Gui Show, w540 h129, Covid Window

Exit

Okay() {
Global

App := ComObjCreate("AcroExch.App")
AVDoc := App.GetActiveDoc()
AVPageView := AVDoc.GetAVPageView()


_PageNo := ""
gui, submit, nohide

WinActivate, ahk_exe Acrobat.exe
App.MenuItemExecute("Print")
App.MenuItemExecute("Close")
MsgBox % AVPageView.GetPageNum+1 " - " AVPageView.GetPageNum+2
WinWait, Print
MsgBox
	ControlSend,ComboBox1,c,ahk_exe Acrobat.exe
	ControlClick,Button9,ahk_exe Acrobat.exe

ControlsetText,% AVPageView.GetPageNum+1 " - " AVPageView.GetPageNum+2,RICHEDIT50W2,ahk_exe Acrobat.exe
;ControlSend,RICHEDIT50W2, % AVPageView.GetPageNum+1 " - " AVPageView.GetPageNum+2,ahk_exe Acrobat.exe

Return
Sleep 500
ControlSend,RICHEDIT50W2,{Tab},ahk_exe Acrobat.exe

While WinExist("Print") {
	ControlClick,Button47,ahk_exe Acrobat.exe
}

WinWait,CutePDF Writer
ControlSetText,Edit1,% "C:\temp\" . CID . " " . Name . " Org 70 Invoice " . InvoiceNo ".pdf", CutePDF Writer
Sleep 1000

While WinExist("CutePDF Writer") {
	ControlClick,Button12,ahk_exe CutePDFWriter.exe
}

text =
(
Hello %Name%

Your prompt attention to this account would be greatly appreciated.

Please be advised that a 50`% reduction to the fee is available for low income earners.

To be eligible low income earners must provide their most recent Official Australian Tax Office Notice of Assessment (ie.2019-2020 or 2018-2019) or a Current Centrelink Statement demonstrating gross income of $52,706 per annum or less for an individual or joint gross income of $68,894 per annum or less for a family. 

For queries regarding this invoice, please call Accounts Receivable on (08) 8951 6488 or email DebtManagement.Dcis@nt.gov.au 

Payment of this invoice can me made via BPay, Payonline or via Credit Card over the Phone by calling 1300 796 729.  

To pay online, please go to www.payonline.nt.gov.au

Please use your customer ID: %CID%

)

m :=	ComObjActive("Outlook.Application").CreateItem(0)
m.Subject := CID . " " . Name . " Org 70 Invoice " . InvoiceNo
m.To :=	Email,m.Display
myInspector :=	m.GetInspector, myInspector.Activate
wdDoc :=	myInspector.WordEditor
wdRange :=	wdDoc.Range(0, wdDoc.Characters.Count)
wdRange.InsertBefore(text)
m.Attachments.Add("C:\temp\" . CID . " " . Name . " Org 70 Invoice " . InvoiceNo ".pdf")
m.SentOnBehalfOfName := "DebtManagement.Dcis@nt.gov.au"
}