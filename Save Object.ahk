#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Global Client_Info := OrderedArray()
Client_Info()

Clipboard := Obj2String(Client_Info)

Exit
q::q

Obj2String(Obj,FullPath:="Client_Info",BottomBlank:=0){
	static String,Blank
	if(FullPath=1)
		String:=FullPath:=Blank:=""
	if(IsObject(Obj)){
		for a,b in Obj{
			if(IsObject(b))
				Obj2String(b,FullPath "." a,BottomBlank)
			else{
				if(BottomBlank=0)
					String.=FullPath "." a " = " b "`n"
				else if(b!="")
					String.=FullPath "." a " = " b "`n"
				else
					Blank.=FullPath "." a " =`n"
			}
	}}
	return String Blank
}

Client_Info() 
{

Client_Info.ServiceNo := 83260042
Client_Info.Initialise_Given_Names := "Mrs C. A. Wilson"
Client_Info.Person_Cost_Code := "79FFEF01T"
Client_Info.Person_Courtesy_Title := "MRS"
Client_Info.Person_Date_Of_Birth := "06 May 1965"
Client_Info.Person_Given_Name := "Cheryl Ann"
Client_Info.Person_Last_Name := "WILSON"
Client_Info.Person_Pay_Centre := 575

Client_Info.Address_Personal_Email := ""
Client_Info.Address_Personal_Mobile := 0889621239
Client_Info.Address_Postal_Line_1 := "PO BOX 1262"
Client_Info.Address_Postal_Line_2 := ""
Client_Info.Address_Postal_Line_3 := ""
Client_Info.Address_Postal_PostCode := "0861"
Client_Info.Address_Postal_State := "NT"
Client_Info.Address_Postal_Suburb := "TENNANT CREEK"
Client_Info.Address_Work_Email := "cheryla.wilson@nt.gov.au"

Client_Info.Super_Fund_ID := "OTN143"
Client_Info.Super_Fund_Name := "AustralianSuper Industry"
Client_Info.Super_Fund_State := "Melbourne Vic  3000"
Client_Info.Super_Fund_Street := "GPO Box 1901R"
Client_Info.Super_Member_No := 83260042


Client_Info.Date_Ceased := "24/06/2020"
Client_Info.Date_Commenced := "1/06/2020"
Client_Info.Date_Detected := "30/06/2020"
Client_Info.Distance := 1
Client_Info.Error_Cause := "Process"
Client_Info.Error_Source := "Payee"
Client_Info.Error_Type := "Salary"
Client_Info.FBT_Date := "0/8/2020"
Client_Info.Gross_Amount := "-4160.09"
Client_Info.Location := "Tennant Creek"
Client_Info.Pay_Cycle := 02
Client_Info.Pay_Date := "22/07/2020"
Client_Info.PayCentre := "575.000000"
Client_Info.Percentage := "239.49"
Client_Info.Previous_Fin_Year_Super := "-395.2"
Client_Info.RCYCOM := "-4160.09"
Client_Info.RDRENT := 0
Client_Info.Reason := "being paid during leave without pay 1/06/2020 to 24/06/2020. ($4160.09)"
Client_Info.RecoveryRate := "239.49"
Client_Info.RPMENT := 0
Client_Info.SalarySac_Amount_Gross := 0

Client_Info.TAXPYM := 0
Client_Info.TotalAmount := "4160.09"
}