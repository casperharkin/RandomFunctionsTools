#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent

Global  __OBJECT
New Populate_Data_From_Excel

Exit


Class Populate_Data_From_Excel {

	__New() {

		

		__OBJECT := 
		__OBJECT := {}
		__OBJECT.Address_Personal_Email :=  
		__OBJECT.Address_Personal_Mobile :=  
		__OBJECT.Address_Postal_Line_1 := This.GetCellValue("Number and Street Address",0,1)
		__OBJECT.Address_Postal_Line_2 :=  
		__OBJECT.Address_Postal_Line_3 := 
		__OBJECT.Address_Postal_PostCode :=  
		__OBJECT.Address_Postal_State :=  
		__OBJECT.Address_Postal_Suburb :=  
		__OBJECT.Address_Work_Email :=  
		__OBJECT.Date_Ceased := This.GetCellValue("Ceased Date",0,1)
		__OBJECT.Date_Commenced := This.GetCellValue("Date O/P commenced",1,0)
		__OBJECT.Date_Detected := This.GetCellValue("Date O/P ceased",1,0)
		__OBJECT.Distance :=  
		__OBJECT.Error_Cause := This.GetCellValue("Error Source",1,0)
		__OBJECT.Error_Source := This.GetCellValue("Error Type",1,0)
		__OBJECT.Error_Type := This.GetCellValue("Error Cause",1,0)
		__OBJECT.FBT_Date := This.GetCellValue("FBT Date",0,1)
		__OBJECT.Gross_Amount := This.GetCellValue("",0,0)
		__OBJECT.Initialise_Given_Names :=  
		__OBJECT.Location := This.GetCellValue("Location",1,0)
		__OBJECT.Pay_Cycle :=  
		__OBJECT.Pay_Date := This.GetCellValue("Date recovery will commence",0,1)
		__OBJECT.PayCentre := This.GetCellValue("Pay Centre",0,1)
		__OBJECT.Percentage := This.GetCellValue("10% of gross salary",0,1)
		__OBJECT.Person_Cost_Code := This.GetCellValue("",0,0)
		__OBJECT.Person_Courtesy_Title :=  
		__OBJECT.Person_Date_Of_Birth :=  
		__OBJECT.Person_Given_Name :=  
		__OBJECT.Person_Last_Name :=  
		__OBJECT.Person_Pay_Centre := This.GetCellValue("Pay Centre",0,1)
		__OBJECT.Previous_Fin_Year_Super := 
		__OBJECT.RCYCOM := This.GetCellValue("",0,0)
		__OBJECT.RDRENT := This.GetCellValue("",0,0)
		__OBJECT.Reason := This.GetCellValue("",0,0)
		__OBJECT.RecoveryRate := This.GetCellValue("",0,0)
		__OBJECT.RPMENT := This.GetCellValue("",0,0)
		__OBJECT.SalarySac_Amount_Gross := This.GetCellValue("",0,0)
		__OBJECT.ServiceNo := This.GetCellValue("",0,0)
		__OBJECT.Super_Fund_ID := This.GetCellValue("",0,0)
		__OBJECT.Super_Fund_Name := This.GetCellValue("",0,0)
		__OBJECT.Super_Fund_State := This.GetCellValue("",0,0)
		__OBJECT.Super_Fund_Street := This.GetCellValue("",0,0)
		__OBJECT.Super_Member_No := This.GetCellValue("",0,0)
		__OBJECT.TAXPYM := This.GetCellValue("",0,0)
		__OBJECT.TotalAmount := This.GetCellValue("",0,0)
	}

	GetCellValue(Find,offset_X,offset_Y) {
		ComObj := ComObjActive("Excel.Application")
		Pointer := ComObj.ActiveSheet.Range("A:H").Find(Find)
		return ComObj.Range(Pointer.Offset(offset_X, offset_Y).address).Value
	}

}