#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global CheckingObj := {}

a := New Checking

a.test()



for each, item in CheckingObj["Data_from_PIPS"]
	MsgBox % "Each: " Each "`nItem: " item

Exit ; EOAE

Class Checking
{




		PreparePaidDueDiff(Client_Info)
		{
			IniRead, Current_Financial_Year, % "C:\Users\babb\Desktop\Workbook Class Settings.ini", General, Current_Financial_Year
			Xl := ComObjActive("Excel.Application")
			ComObjError(false)
			
			For sheet in Xl.Worksheets
				if InStr(Sheet.Name, "Year Summary") 
					Xl.Sheets(Sheet.Name).activate
			
			PDD_Financial_Year := This.GetCellValue("Financial Year",0,1)
			
			if (PDD_Financial_Year != Current_Financial_Year)
			{
				Xl.Sheets("Payment Summary Amendment").Visible := True
				Xl.Sheets("Payment Summary Amendment").activate
				Xl.ActiveSheet.Unprotect
				This.Sleep(1000)
				This.SetCellValue("Pay Centre:",Client_Info.Person_Pay_Centre ,0,1)
				FormatTime, Time,, dd/MM/yyyy
				This.SetCellValue("Section 3: Requested By (Payroll)","Bryn Abbott",6,1)
				This.SetCellValue("Section 3: Requested By (Payroll)",Time,6,4)
				
				PDD_Financial_Year := Xl.Range("D4").Value
				PDD_Financial_Year := SubStr(PDD_Financial_Year,1,4)
				
				winactivate, Mochasoft
				sendinput, {F4}
				clipboard := 
				This.Sleep(1000)
				
				winactivate, Mochasoft
				sendinput, {Alt}ES
				sendinput, ^c
				
				ClipWait, 2
				if ErrorLevel
					MsgBox, The attempt to copy text onto the clipboard failed.
				This.Sleep(1000)
				Array := StrSplit(Clipboard, "`n")
				
				if (substr(Array[3],33,16) = "M A I N  M E N U" )
				{
					This.Sleep(1000)
					winactivate, Mochasoft
					This.Sleep(500)
					sendinput, pay
					sendinput,{enter}
					This.Sleep(500)
					sendinput,{TAB 3}
					sendinput, %PDD_Financial_Year%26{F8}
					This.Sleep(500)
					sendinput,s{ENTER}
					clipboard := 
					ClipWait, 2
					
					This.Sleep(500)
					sendinput, {Alt}ES
					sendinput, ^c
					ClipWait, 2
					if ErrorLevel
						MsgBox, The attempt to copy text onto the clipboard failed.
					
					Array := StrSplit(Clipboard, "`n")
					GrossSumTotal := substr(Array[18],14,15)
				}
				This.Sleep(1000)
				This.SetCellValue("Reduce gross total:",GrossSumTotal,0,3)
				This.Sleep(500)
				Xl.ActiveWorkbook.save()
			}
			
			For sheet in Xl.Worksheets
				if InStr(Sheet.Name, "Year Summary") 
					Xl.Sheets(Sheet.Name).activate
			
			Xl.ActiveSheet.Unprotect
			
			Cell := Xl.Range("A:J").Find("Total Overpayment").address
			Cell_No := SubStr(Cell, 4) + 1
			Cell_Letter := SubStr(Cell, 1,3)
			Non_Zero_Pays := ""
			
			loop, 27
			{
				Cell_No := Cell_No + 1
				Cell := Cell_Letter . Cell_No
				if (Xl.ActiveSheet.Range(Cell).Value = "0") 
					Xl.Sheets("Pay " Cell_No - 6).Select(False)
				
				if (Xl.ActiveSheet.Range(Cell).Value != "0") {
					Non_Zero_Pays .= "Pay " Cell_No - 6 "`n"
				}
			}
			
			Xl.ActiveWindow.SelectedSheets.Visible := False 
			Xl.Sheets("Previous Financial Year Summary").Visible := True
			Xl.Sheets("Previous Financial Year Summary").activate
			Xl.Sheets("Current Financial Year Summary").Visible := True
			Xl.Sheets("Current Financial Year Summary").activate
			PDD_Financial_Year := This.GetCellValue("Financial Year",0,1)
			Xl.ActiveSheet.Range("C1").Value := "Name:"
			Xl.ActiveSheet.Range("C2").Value := "AGS:"
			This.SetCellValue("Name:",TRIM(Client_Info.Person_Last_Name) . ", " . TRIM(Client_Info.Person_Given_Name),0,1)
			This.SetCellValue("AGS:",Client_Info.ServiceNo,0,1)
			
			Document_Title := Client_Info.ServiceNo "_Paid Due Diff_" . StrReplace(PDD_Financial_Year, "/", "-")
			Document_Location := Xl.activeworkbook.path . "\" . Document_Title . ".pdf"
			
			Loop, parse, Non_Zero_Pays, `n,
				Xl.Sheets(A_LoopField).Select(False)
			
			xl.ActiveSheet.ExportAsFixedFormat(0, Document_Location ,0,True,False,1,100,False)
			
			if (Financial_Year := This.GetCellValue("Current", 0, 1) = Current_Financial_Year) {
				Financial_Year := RegExReplace(This.GetCellValue("Current", 0, 1), "/", "_")
				Client_Info.Tax_Amount := This.GetCellValue("TOTALS", 0, 1)
				Client_Info.Nett_Amount := This.GetCellValue("TOTALS", 0, 2)
				Client_Info.SalarySac_Amount := This.GetCellValue("TOTALS", 0, 3)
				Client_Info.Deductions_Amount := This.GetCellValue("TOTALS", 0, 4)
				Client_Info.Super_Amount := This.GetCellValue("TOTALS", 0, 6)
				
				WinActivate, Excel
				Xl.DisplayAlerts := (False)
				Xl.ActiveSheet.Unprotect
				Xl.Workbook.Close(0) 
				Xl.quit()
			}
			
			if (Financial_Year := This.GetCellValue("Previous", 0, 1) != Current_Financial_Year)
			{
				Past_Loaction := Xl.activeworkbook.path . "\"
				
				if (Client_Info.Gross_Amount != "")
				{
					Client_Info.Gross_Amount := Client_Info.Gross_Amount + This.GetCellValue("TOTALS", 0, 2)
					Client_Info.SalarySac_Amount_Gross := Client_Info.SalarySac_Amount_Gross + This.GetCellValue("TOTALS", 0, 3)
					Client_Info.Previous_Fin_Year_Super := Client_Info.Previous_Fin_Year_Super + This.GetCellValue("TOTALS", 0, 5)
				}
				
				else if (Client_Info.Gross_Amount = "")
				{
					Client_Info.Gross_Amount := This.GetCellValue("TOTALS", 0, 2)
					Client_Info.SalarySac_Amount_Gross := This.GetCellValue("TOTALS", 0, 3)
					Client_Info.Previous_Fin_Year_Super := This.GetCellValue("TOTALS", 0, 5)
				}
				
				Xl := ComObjActive("Excel.Application")
				ComObjError(false)
				WinActivate, Excel
				Xl.DisplayAlerts := (False)
				Xl.ActiveSheet.Unprotect
				Xl.Workbook.Close(0) 
				Xl.quit()
				
			}
			
			
			
		}































	__New()
	{
		;Ask Checker for the AGS Number of the Client we are going to check. 
		InputBox, UserInput, AGS Number of Job:, Please enter the AGS Number to Begin Checking., ,,,,,,, 870 64049  
		CheckingObj["AGS"] := StrReplace(UserInput, A_Space)

		This.CheckListArray :=  {"TIMEOUTCHECK":"|<>*48$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzsDw7kDUDz00TllztnznzTzLzjjjnyztwzszjz9zrrrzzDxzTwDrzizvvvzzbwzbybvzrTxxxzznyTnzNxznbyyyzzvzDxzgyzvvzzTzztzbyzrDTxwzzjzz1znzTvrjwyTzrzzwTtzjxtryzjzvzzzbwzryyPz03zxzzznyTvzTBzDxzyzzzxzDtzjmzjyzzTzzyzbwzrwTbzDzjzzyTvyTvyDnzrzrzvzDwyTxzbvzvzvzwSDzCTs7nkDUT07zUTzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
								,"MAINMENUCHECK":"|<>*45$41.zzzzzzzzzzzzzztzw7znznznbzbzDzDbzbyTyzjzDsztzDzDnznyTyTbzbyzwSDzDxzwwzyTvzttzwzrznnztzjzbbznzTzDDzbwzySTzDtzwwTzTnztwzyTDzXtzyQzzDlzy3zyTnzzzztzbzzzznzbzzzzDzjzzzyTzzzzzzz"							
				     			,"SEPARATEDCHECK":"|<>*106$78.zzzzzzzbzzzzzzzzzzzzbzzzzzzDzzzzzDzzzyTzDkD1zzDUy1yTyDwzrzyDwTnzDyTyzbzyTwTnzDwTyTDzyTwDnzbwzzDDzwzxDnzbwzziTzwzxbnzXszzYzztzxbnznszzkzztzxnnznszztzznzxtnzntzztzznzxtnzntzztzzbzxwnznszztzzbzxwnznszztzzDzxyHznszztzzDzxz3znwzztzzDzxz3zXwzztzyTzxzXzbwTy0DyTzkDXzbyTzzzwzzzzzzDyDzzzwzzzzzzDzDzzzzzzzzzyTzjzzzzzzzzzyTzzzzzzzzzzzzzU"
			          			,"CASUALCHECK":"|<>*106$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs7w2TzzzzzzzzzzzzzDXkzzzzzzzzzzzzzySTlzzzzzzzzzzzzzwxznzzzzzzzzzzzzztnzby1zy0DVsDy1zznbzzlszswTnyTlszzbTzzztzbwzbwzztzzCzzzzvzDtzDtzzvzyRzzzzrzDzyTnzzrzwvzzzzjz0Twzbzzjztrzzy0TzyTtzDy0TznbzzlwzzyTnyTlwzzbDzzDxzzyTbwzDxzzDDySTvzTwzDtyTvzyTTtwzbyTnzTXwzbzwzD7swDwTDyS7swDztz0zw33v0zy13w33k0Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
				  				,"TEMPCHECK":"|<>*47$101.zzzzzzwzzzzzzzzzzzzzzzztzzzzzzzzzzbzzzzzbzzzzDzzzzzDkT1zzDUy1yTzzzzwztzjzwztzjyTzzzztzvyTztzlzTwzzzzzXzntzzrzVyzwzzzzzDznrzzDzHxztzzzzyTzrDzyTynvzlzzzzszzYzztzxbrznzzzznzzXzznzvbjzbzzzzbzzbzzDzrjTzDzzzzDzzTzyTzjCzyTzzzyTzyzztzzTBzwzzzzwzzxzznzyyPztzzzztzzvzzDzxyLznzzzzlzzrzyTzvyDzbzzXznzzjzxzzrwTyDzy3zbzzTznzzjwzwzzw7z7zU3zjzw3tztzzwTzDzzzyTzzzzzbzzzzyTzzzwzzzzzzDzzzzyTzzzzzzzzzwzzzzzyzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzz"
				    			,"COFCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUHzUTs01zzzzzzzzwS7wSTwznzzzzzzzznyDnyTtzbzzzzzzzzjyT7yTnzDzzzzzzzyTwyTwzbyTzzzzzzzwzzwzwzDzzzzzzzzzvzznztyQzzzzzzzzzbzzbznwtzzzU0DzzzDzzDzbs3zzz00TzzyTzyTzDnbzzzzzzzzyzzwzyTbDzzzzzzzzwzzxzwzDzzzzzzzzztzztznyTzzzzzzzzztzntzbwzzzzzzzzzzvzDnyTtzzzzzzzzzztszltznzzzzzzzzzzs7zs7y0Dzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
								,"NTGPASSCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUy1s03zUHzzzzzzzzszbnnrwy7zzzzzzzzlzDbbjnzDzzzzzzzzVyTDDTjyTzzzzzzzzHwySSyTzzzzzzzzzyntwwxwzzzzzzzzzzxbnztzvzzzzzzzzzzvbbznzbzzzzU0DzzzrbDzbzDzzzz00TzzzjCTzDyTUDzzzzzzzzTAzyTyzwzzzzzzzzyyNzwzwztzzzzzzzzxyHztztznzzzzzzzzvy7znznzbzzzzzzzzrwDzbznzDzzzzzzzzjwTzDzlyTzzzzzzzw3szU3zs3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
								,"SPR":"|<>*108$71.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkC1w1zk0TUy1bzrzdztyTszbjzDyHznyTlzDTyTwrzbyzVySyQzvbzDwzHwwstzbDyTvynttlnzDTwzbxbnndbyyTtwTvbbaHDtwzk3zrbDAqznxzbbzjCTPhzU1zDbzTAyr/yTvyTbyyNxC7xznwzbxyHsQDnzbtzjvy7lwTbzjnzDrwDXszTzDbzTjwT7ls7kA1yA3szzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}

		; Build the Super Object that holds the Fund Details Objects
		SuperDetails := {}
		SuperDetails["NEPAXG"] := {Name:"AXA Generations Personal Super- Carol Duke",Street:"750 Collins Street", State:"West Victoria  VIC  8007"}
		SuperDetails["NEPAXG"] := {Name:"SPNT PTY LTD",Street:"PO Box 1827", State:"New Farm  QLD  4005"}
		SuperDetails["NEPNV1"] := {Name:"SPNT NL - FM (SALARY PACKAGING AND NEW TECHNOLOGY PTY LTD)",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}
		SuperDetails["NEPNV2"] := {Name:"SPNT NL - ECM (SALARY PACKAGING AND NEW TECHNOLOGY PTY LTD)",Street:"PO BOX 1827", State:"NEW FARM QLD 4005"}
		SuperDetails["NEPNV3"] := {Name:"EPAC NL - FM (EPAC SALARY SOLUTIONS PTY LTD)",Street:"PO BOX 373", State:"RUNDLE MALL SA 5000"}
		SuperDetails["NEPNV4"] := {Name:"EPAC NL - ECM (EPAC SALARY SOLUTIONS PTY LTD)",Street:"PO BOX 373", State:"RUNDLE MALL SA 5000"}
		SuperDetails["NEPNV5"] := {Name:"FLEETNETWORK NL - FM (FLEETNETWORK)",Street:"PO Box 2461", State:"MALAGA WA 6090"}
		SuperDetails["NEPNV6"] := {Name:"FLEETNETWORK NL - ECM (FLEETNETWORK)",Street:"PO Box 2461", State:"MALAGA WA 6090"}
		SuperDetails["NEPNV7"] := {Name:"Vehicle Solutions Australia (Novated Lease Company)",Street:"PO Box 1625", State:"PALMERSTON NT 0831"}
		SuperDetails["NEPNV8"] := {Name:"Fleet Choice NT (Novated Lease Company)",Street:"GPO Box 3961", State:"DARWIN NT 0801"}
		SuperDetails["NEPPOW"] := {Name:"PowerWater In-House Benefits",Street:"Salary Packaging Unit & Executive Payroll Unit", State:""}
		SuperDetails["NEPX09"] := {Name:"The Portfolio Service (Executive)",Street:"Locked Bag 800", State:"Milsons Point NSW 1565"}
		SuperDetails["NEPX13"] := {Name:"Smartsave Members Choice - J Harrison",Street:"PO Box 20314", State:"World Square"}
		SuperDetails["NEPX14"] := {Name:"QSuper",Street:"GPO Box 200", State:"Brinband QLD 4002"}
		SuperDetails["NEPX24"] := {Name:"MLC WRAP SUPER",Street:"GPO BOX 2567", State:"MELBOURNE  VIC  3001"}
		SuperDetails["OTENJTK"] := {Name:"Central Australia Hospital Network CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTENTC"] := {Name:"DCIS CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTENTE"] := {Name:"NT Land Corp CRA Fund",Street:"PO Q106, QVB Post Shop", State:"Sydney NSW 1229"}
		SuperDetails["OTENTG"] := {Name:"Government Printing Office CRA Fund",Street:"GPO Box 1447", State:"Darwin NT 0801"}
		SuperDetails["OTENTJ"] := {Name:"Top End Hospital Network CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTENTL"] := {Name:"Legal Aid Commission CRA Fund",Street:"GPO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTENTP"] := {Name:"PAWA CRA FUND",Street:"PO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTENTS"] := {Name:"Batchelor CRA fund",Street:"RTM Palm Court", State:"PO Box 2391"}
		SuperDetails["OTENTT"] := {Name:"Land Development Corporation CRA Fund",Street:"PO Box 2391", State:"Darwin  NT  0801"}
		SuperDetails["OTN000"] := {Name:"Commonwealth Life Personal Super",Street:"PO Box 3306", State:"Sydney  NSW  1030"}
		SuperDetails["OTN001"] := {Name:"Commonwealth Bank Superannuation Savings Account",Street:"GPO Box 3306", State:"Sydney NSW 2001"}
		SuperDetails["OTN003"] := {Name:"Health Super Fund",Street:"Locked Bag 2900 Collins Street", State:"West Melbourne  VIC  8007"}
		SuperDetails["OTN004"] := {Name:"AXA Australia",Street:"Super Department", State:"PO Box 14669"}
		SuperDetails["OTN005"] := {Name:"MLC Empl Retirement Plan",Street:"PO Box 200", State:"North Sydney  NSW 2059"}
		SuperDetails["OTN006"] := {Name:"MLC Universal Super",Street:"MLC Nominees Pty Ltd", State:"105-153 Miller Street"}
		SuperDetails["OTN007"] := {Name:"REST",Street:"PO Box 350", State:"Parramatta  NSW 2124"}
		SuperDetails["OTN008"] := {Name:"NAB All in One Super",Street:"PO Box 4341", State:"Melbourne  Vic  3001"}
		SuperDetails["OTN009"] := {Name:"LifeTrack Superannuation Fund",Street:"GPO Box 264C", State:"Melbourne VIC 3001"}
		SuperDetails["OTN012"] := {Name:"UNISUPER",Street:"Level 37 385 Burke", State:"Street Melbourne  Vic  3000"}
		SuperDetails["OTN013"] := {Name:"HESTA",Street:"PO Box 600", State:"CARLTON SOUTH VIC 3053"}
		SuperDetails["OTN015"] := {Name:"AMP Superleader Plan",Street:"Locked Bag 5095", State:"Parramatta, NSW 2124"}
		SuperDetails["OTN022"] := {Name:"Westpac Lifetime Super",Street:"GPO BOX 3960", State:"Sydney  NSW  2001"}
		SuperDetails["OTN024"] := {Name:"C+BUS",Street:"Locked Bag 999", State:"Carlton South  VIC 3053"}
		SuperDetails["OTN026"] := {Name:"Host Plus Superannuation Fund",Street:"Locked Bag 999", State:"Carlton South  Vic  3053"}
		SuperDetails["OTN027"] := {Name:"MTAA Superannuation Fund",Street:"Locked Bag 15", State:"HayMarket  NSW 1236"}
		SuperDetails["OTN028"] := {Name:"TAL Superannuation and Insurance Fund",Street:"PO Box 142", State:"Milsons Point NSW 1565"}
		SuperDetails["OTN030"] := {Name:"TWU Superannuation Fund",Street:"GPO Box 4689", State:"Melbourne  VIC  8060"}
		SuperDetails["OTN031"] := {Name:"Media Super",Street:"Locked Bag 1229", State:"Wollongong  NSW  2500"}
		SuperDetails["OTN032"] := {Name:"MLC Masterkey Superannuation Fund",Street:"PO Box 1315", State:"North Sydney  NSW  2059"}
		SuperDetails["OTN033"] := {Name:"ASGARD Independence Plan Division One",Street:"PO Box 7490", State:"Cloisters Square  WA  6850"}
		SuperDetails["OTN036"] := {Name:"Sunsuper Superannuation Fund",Street:"PO Box 2924", State:"Brisbane  QLD 4001"}
		SuperDetails["OTN037"] := {Name:"CARE Superannuation",Street:"Locked Bag 5087", State:"Parramatta NSW 2124"}
		SuperDetails["OTN039"] := {Name:"Asteron Life Ltd",Street:"GPO Box 1576", State:"Sydney  NSW 2001"}
		SuperDetails["OTN041"] := {Name:"SYNERGY Superannuation Fund",Street:"GPO Box 852", State:"Hobart  TAS 7001"}
		SuperDetails["OTN042"] := {Name:"The Portfolio Service",Street:"Locked Bag 800", State:"Milsons Point NSW 1565"}
		SuperDetails["OTN043"] := {Name:"VICSUPER",Street:"PO Box 89", State:"Melbourne  Vic  3001"}
		SuperDetails["OTN044"] := {Name:"BUSS(Q) Superannuation Fund",Street:"PO Box 902", State:"SPRING HILL QLD 4004"}
		SuperDetails["OTN046"] := {Name:"BT Life Super",Street:"BT Financial Group", State:"GPO Box 2675"}
		SuperDetails["OTN048"] := {Name:"ING Life Limited",Street:"GPO Box 5306", State:"Sydney  NSW  2001"}
		SuperDetails["OTN050"] := {Name:"Zurich Australia Superannuation",Street:"PO Box 994", State:"North Sydney  NSW  2059"}
		SuperDetails["OTN051"] := {Name:"ANZ Superannuation",Street:"GPO BOX 4028", State:"Sydney  NSW 2001"}
		SuperDetails["OTN052"] := {Name:"MAP Personal Pension Plan",Street:"PO Box 1130", State:"Brisbane  QLD 4001"}
		SuperDetails["OTN056"] := {Name:"APEX SUPER",Street:"GPO Box  398", State:"NORTH SYDNEY NSW 2059"}
		SuperDetails["OTN057"] := {Name:"Australian Ethical Retail Superannuation Fund (aka Australian Ethical Super Fund)",Street:"Attn: Emily Price", State:"GPO Box 529"}
		SuperDetails["OTN058"] := {Name:"Statewide Superannuation Trust",Street:"GPO Box 1749", State:"Adelaide  SA  5001"}
		SuperDetails["OTN059"] := {Name:"Advance Super",Street:"GPO Box B87", State:"Perth  WA  6838"}
		SuperDetails["OTN060"] := {Name:"Guild Super",Street:"GPO BOX 1088", State:"MELBOURNE  VIC  3001"}
		SuperDetails["OTN063"] := {Name:"Catholic Superannuation Fund",Street:"PO Box 2163", State:"Melbourne  Vic  3001"}
		SuperDetails["OTN064"] := {Name:"TASPLAN Super",Street:"PO Box 1547", State:"Hobart  TAS 7001"}
		SuperDetails["OTN065"] := {Name:"AUSTSAFE Superannuation Fund",Street:"GPO Box 3113", State:"Brisbane  QLD  4001"}
		SuperDetails["OTN066"] := {Name:"Colonial Mutual Super (aka Colonial Mutual Life Assurance)",Street:"PO Box 320", State:"Silverwater  NSW  2128"}
		SuperDetails["OTN067"] := {Name:"Australian Primary Superannuation Fund",Street:"Locked Bag 2229", State:"Wollongong DC NSW 2500"}
		SuperDetails["OTN068"] := {Name:"Summit Master Trust Personal Superannuation & Pension Plan",Street:"GPO Box 2754", State:"MELBOURNE  VIC  3001"}
		SuperDetails["OTN069"] := {Name:"Colonial Master Fund (aka Colonial Select Superannuation Fund)",Street:"Locked Bag 5075", State:"Parramatta  NSW 2124"}
		SuperDetails["OTN070"] := {Name:"AustralianSuper Corporate",Street:"GPO Box 4303", State:"Melbourne VIC 3001"}
		SuperDetails["OTN072"] := {Name:"ANZ Super Advantage",Street:"GPO BOX 4028", State:"Sydney  NSW 2001"}
		SuperDetails["OTN073"] := {Name:"Finium Super Master Plan",Street:"GPO Box 529", State:"Hobart  TAS  7001"}
		SuperDetails["OTN080"] := {Name:"SimpleWRAP",Street:"GPO Box 2945, Melbourne VIC 3001", State:""}
		SuperDetails["OTN081"] := {Name:"Health Industry Plan (HIP)",Street:"Locked Bag 20 Grosvenor Pl", State:"Sydney  NSW 1216"}
		SuperDetails["OTN083"] := {Name:"ASSET (Australian Superannuation Savings Employment Trust)",Street:"GPO Box 4030", State:"Sydney  NSW 2001"}
		SuperDetails["OTN090"] := {Name:"Symetry Lifetime Super",Street:"Locked Bag 3460", State:"Melbourne VIC 3001"}
		SuperDetails["OTN091"] := {Name:"Navigator Super Solutions",Street:"GPO Box 2567", State:"Melbourne Vic 3001"}
		SuperDetails["OTN092"] := {Name:"Plan B Superannuation Fund",Street:"Plan B Wealth Management", State:"PO Box 7008"}
		SuperDetails["OTN095"] := {Name:"Non Government Schools Superannuation Fund",Street:"NGS Super", State:"GPO Box 4303"}
		SuperDetails["OTN102"] := {Name:"Colonial Personal Super Fund",Street:"Locked Bag 5790", State:"Parramatta  NSW  2124"}
		SuperDetails["OTN103"] := {Name:"Colonial First State First Choice",Street:"GPO Box 3956", State:"Sydney NSW 2001"}
		SuperDetails["OTN107"] := {Name:"Retirement Portfolio Services",Street:"Locked Bag 50", State:"Australian Square NSW 1215"}
		SuperDetails["OTN109"] := {Name:"AustChoice Super Plan",Street:"Attn: Emily Price", State:"GPO Box 529"}
		SuperDetails["OTN117"] := {Name:"Christian Super",Street:"Locked Bag 5073", State:"Parramatta NSW 2124"}
		SuperDetails["OTN119"] := {Name:"AustralianSuper Industry",Street:"GPO Box 1901R", State:"Melbourne Vic  3000"}
		SuperDetails["OTN122"] := {Name:"New Name: MLC Navigator Retirement Plan",Street:"GPO Box 2567W", State:"Melbourne  Vic  3001"}
		SuperDetails["OTN123"] := {Name:"Strategy Retirement Fund",Street:"Locked Bag 1000", State:"Wollongong NSW 2500"}
		SuperDetails["OTN125"] := {Name:"QIEC Superannuation Trust",Street:"PO Box 2130", State:"MILTON QLD 4064"}
		SuperDetails["OTN127"] := {Name:"Recruitment Services Superannuation Fund",Street:"GPO Box 4839VV", State:"Melbourne  VIC  3001"}
		SuperDetails["OTN129"] := {Name:"WESTPAC Super Investment Fund",Street:"GPO Box 2362", State:"Adelaide  SA  5001"}
		SuperDetails["OTN130"] := {Name:"Suncorp Metway Easy Super",Street:"PO Box 1453", State:"Brisbane  QLD 4001"}
		SuperDetails["OTN131"] := {Name:"Perpetual Investor Choice Retirement Fund (aka Perpetual Wealth Focus Super Plan)",Street:"GPO Box 4171", State:"Sydney NSW 2001"}
		SuperDetails["OTN137"] := {Name:"Bendigo Super Plan",Street:"GPO Box 529", State:"Hobart  TAS  7001"}
		SuperDetails["OTN138"] := {Name:"AMP Retirement Savings Account",Street:"LOCKED BAG 5400", State:"PARAMATTA  NSW  1741"}
		SuperDetails["OTN139"] := {Name:"AMP Miscellaneous",Street:"LOCKED BAG 5400", State:"PARAMATTA NSW 1741"}
		SuperDetails["OTN140"] := {Name:"AMP Flexible Lifetime Super",Street:"LOCKED BAG 5400,", State:"PARAMATTA, NSW, 1741"}
		SuperDetails["OTN143"] := {Name:"AustralianSuper Industry",Street:"GPO Box 1901R", State:"Melbourne Vic  3000"}
		SuperDetails["OTN146"] := {Name:"Managed Australian Retirement Fund",Street:"PO Box 7074", State:"East Brisbane  QLD 4169"}
		SuperDetails["OTN148"] := {Name:"Colonial Super Retirement Fund",Street:"PO Box 320", State:"Silverwater  NSW  2128"}
		SuperDetails["OTN150"] := {Name:"Vision Super (aka Local Authorities Super)",Street:"PO Box 18041 Collins Street", State:"East Melbourne  VIC  8003"}
		SuperDetails["OTN153"] := {Name:"Australian Catholic Superannuation & Retirement Fund",Street:"PO Box 656", State:"Burwood NSW 1805"}
		SuperDetails["OTN161"] := {Name:"Mercer Super Trust",Street:"GPO Box 4303", State:"Melbourne  VIC   3001"}
		SuperDetails["OTN162"] := {Name:"Combined Fund",Street:"GPO Box 4559", State:"Melbourne  VIC  3001"}
		SuperDetails["OTN167"] := {Name:"IOOF Portfolio",Street:"GPO Box 264C", State:"Melbourne VIC 3001"}
		SuperDetails["OTN175"] := {Name:"Mentor Superannuation Master Trust",Street:"Matrix Superannuation Fund", State:"Locked Bag 1000"}
		SuperDetails["OTN180"] := {Name:"Club Super",Street:"PO Box 2239", State:"Milton QLD 4064"}
		SuperDetails["OTN190"] := {Name:"SuperWrap Superannuation",Street:"GPO Box 2337", State:"Adelaide SA 5001"}
		SuperDetails["OTN196"] := {Name:"Plum Superannuation Fund",Street:"GPO Box 63A", State:"Melbourne VIC 3000"}
		SuperDetails["OTN199"] := {Name:"Intrust Superannuation Fund",Street:"GPO Box 1416", State:"BRISBANE QLD 4001"}
		SuperDetails["OTN203"] := {Name:"Masterkey Custom Superannuation (aka Flexiplan Australia Ltd and aka HML Super fund - One source)",Street:"PO Box 7657", State:"Cloister Square WA 6850"}
		SuperDetails["OTN211"] := {Name:"FSP Superannuation Fund",Street:"FSP Super Pty Limited", State:"Locked Bag 3460"}
		SuperDetails["OTN223"] := {Name:"WA Local Government Superannuation Plan",Street:"PO Box Z5493", State:"St Georges Terrace"}
		SuperDetails["OTN224"] := {Name:"Maritime Super - Seafarers",Street:"Level 4, 6 Riverside Quay", State:"Southbank  VIC  3006"}
		SuperDetails["OTN230"] := {Name:"Medical & Associated Professions Superannuation Fund",Street:"c/- AMA", State:"14 Stirling Highway"}
		SuperDetails["OTN232"] := {Name:"AMP Custom Super",Street:"LOCKED BAG 5400,", State:"PARAMATTA, NSW, 1741"}
		SuperDetails["OTN242"] := {Name:"LUCRF (Labour Union Co-Operative Retirement Fund)",Street:"PO Box 211", State:"North Melbourne VIC 3051"}
		SuperDetails["OTN243"] := {Name:"Telstra Superannuation Scheme",Street:"PO Box 14309", State:"Melbourne VIC 8001"}
		SuperDetails["OTN249"] := {Name:"FuturePlus Super Fund",Street:"GPO Box 2617", State:"Sydney NSW 2001"}
		SuperDetails["OTN254"] := {Name:"IPAC Iaccess Personal Super Plan",Street:"C/- Investor Services", State:"GPO BOX 2754"}
		SuperDetails["OTN286"] := {Name:"Nationwide Superannuation Fund- NSF Super",Street:"PO Box 42", State:"Charlestown NSW 2290"}
		SuperDetails["OTN287"] := {Name:"Australian Enterprise Superannuation Fund (AESuper)",Street:"GPO Box 2258", State:"Melbourne  VIC  3001"}
		SuperDetails["OTN288"] := {Name:"Russell SuperSolutions",Street:"Locked Bag A4094", State:"Sydney South NSW 1235"}
		SuperDetails["OTN289"] := {Name:"IAccess Personal Superannuation",Street:"PO Box 471  Collins Street", State:"WEST MELBOUNRE VIC 8007"}
		SuperDetails["OTN291"] := {Name:"legalsuper",Street:"GPO Box 263C", State:"Melbourne  VIC  3001"}
		SuperDetails["OTN296"] := {Name:"The Duncan Superannuation Fund",Street:"PO Box 1427", State:"KATHERINE NT 0851"}
		SuperDetails["OTN312"] := {Name:"Virgin Superannuation Fund",Street:"Locked Bag 8", State:"Haymarket NSW 1236"}
		SuperDetails["OTN314"] := {Name:"Maritime Super - Stevedores",Street:"Level 4, 6 Riverside Quay", State:"Southbank  VIC  3006"}
		SuperDetails["OTN324"] := {Name:"LOCAL SUPER - Division of StatewideSuper)",Street:"PO Box 7035", State:"Hutt Street"}
		SuperDetails["OTN330"] := {Name:"The Executive Superannuation Fund",Street:"10 Shelly Street", State:"Sydney  NSW  2000"}
		SuperDetails["OTN331"] := {Name:"JR Childs PortfolioOne Superannuation Fund (only for AGS 77753756)",Street:"Locked Bag 50", State:"Australia Square NSW 1215"}
		SuperDetails["OTN334"] := {Name:"AON Master Trust",Street:"PO BOX 9819", State:"Sydney NSW 2001"}
		SuperDetails["OTN344"] := {Name:"Credit Suisse Asset Management Super MasterWrap",Street:"PO Box R240", State:"Royal Exchange NSW 1225"}
		SuperDetails["OTN346"] := {Name:"First State Super",Street:"PO Box 1229", State:"Wollongong  NSW  2500"}
		SuperDetails["OTN357"] := {Name:"REI Super Fund",Street:"GPO Box 4303", State:"Melbourne VIC 3001"}
		SuperDetails["OTN365"] := {Name:"Spectrum Super Fund",Street:"GPO BOX 529", State:"HOBART   TAS   7001"}
		SuperDetails["OTN366"] := {Name:"Lifetime Superannuation Fund",Street:"PO BOX 7008", State:"CLOISTERS SQUARE WA 6850"}
		SuperDetails["OTN371"] := {Name:"The Corporate Superannuation Master Trust - Portable Plan",Street:"PO Box 1647", State:"MILTON BC  QLD  4064"}
		SuperDetails["OTN396"] := {Name:"Mentor Superannuation Master Trust",Street:"Locked Bag 1000", State:"Wollongong NSW 2500"}
		SuperDetails["OTN402"] := {Name:"Energy Super formerly ESI Super",Street:"PO Box 1958", State:"Milton  QLD  4064"}
		SuperDetails["OTN421"] := {Name:"Netwealth Superannuation Master Trust Fund",Street:"Netwealth Investments Ltd", State:"Level 7/52 Collins Street"}
		SuperDetails["OTN431"] := {Name:"LG Super",Street:"GPO Box 264                                       Brisbane  QLD  4001", State:""}
		SuperDetails["OTN433"] := {Name:"Equipsuper Pty Ltd",Street:"Level 12, 114 William Street", State:"MELBOURNE VIC 3000"}
		SuperDetails["OTN435"] := {Name:"PortfolioCare eWRAP Super Account",Street:"PortfolioCare", State:"GPO BOX C113"}
		SuperDetails["OTN457"] := {Name:"AXA Retirement Bond",Street:"PO Box 14330", State:"Melbourne  VIC  8001"}
		SuperDetails["OTN482"] := {Name:"NAB Group Superannuation Fund A (previous NAB employees) (aka NAB Retained Benefit Account)",Street:"PO BOX 1321", State:"MELBOURNE VIC 3001"}
		SuperDetails["OTN507"] := {Name:"Garnet Superannuation Fund",Street:"GPO Box 4369", State:"Melbourne  VIC  3001"}
		SuperDetails["OTN512"] := {Name:"AvSuper",Street:"GPO Box 367 Canberra ACT 2601", State:""}
		SuperDetails["OTN520"] := {Name:"State Super Retirment Fund (aka State Super Personal Retirment Plan)",Street:"State Super Financial Services Pty Ltd", State:"GPO BOX 5336"}
		SuperDetails["OTN522"] := {Name:"ANZ OneAnswer Personal Super",Street:"ING Custodians Pty Limited", State:"GPO Box 4028"}
		SuperDetails["OTN531"] := {Name:"AMP SignatureSuper",Street:"C/- AMP Life Limited", State:"Locked Bag 5043"}
		SuperDetails["OTN540"] := {Name:"Tauondi Rhema Super Fund",Street:"PO BOX 40559", State:"Casuarina NT 0810"}
		SuperDetails["OTN544"] := {Name:"DIY Master Plan",Street:"PO BOX 361", State:"Collins Street West"}
		SuperDetails["OTN553"] := {Name:"Navigator Access Super and Pension",Street:"Navigator Australia Limited", State:"GPO BOX 2567W"}
		SuperDetails["OTN575"] := {Name:"ESS Super",Street:"GPO BOX 1974", State:"MELBOURNE VIC 3001"}
		SuperDetails["OTN576"] := {Name:"BHP Billiton Super Fund",Street:"GPO BOX 63", State:"MELBOURNE VIC 3001"}
		SuperDetails["OTN577"] := {Name:"AMG Universal Super",Street:"GPO BOX 330", State:"BRISBANE QLD 4000"}
		SuperDetails["OTN598"] := {Name:"Wealthtrac",Street:"Locked Bag 1000", State:"WOLLONGONG  NSW  2500"}
		SuperDetails["OTN604"] := {Name:"PLUM PERSONAL PLAN (previously Vanguard Personal Superannuation Plan)",Street:"PLUM FINANCIAL SERVICES LIMITED", State:"REPLY PAID 63"}
		SuperDetails["OTN621"] := {Name:"TIC Retirement Plan",Street:"TIC Retirement Plan", State:"PO Box 1282"}
		SuperDetails["OTN628"] := {Name:"Prime Super",Street:"PO Box 2229", State:"Wollongong  NSW  2500"}
		SuperDetails["OTN647"] := {Name:"MLC MasterKey Business Super",Street:"MLC", State:"PO Box 200"}
		SuperDetails["OTN653"] := {Name:"QSuper",Street:"GPO Box 200, Brisband QLD 4001", State:""}
		SuperDetails["OTN659"] := {Name:"AUST(Q)",Street:"PO Box 329", State:"SPRING HILL QLD 4004"}
		SuperDetails["OTN660"] := {Name:"North - Wealth Personal Superannuation + Pension Plan",Street:"North Service Centre", State:"GPO Box 2915 Melbourne, VIC 3001"}
		SuperDetails["OTN664"] := {Name:"AMIST Super (Australian Meat Industry Super Trust)",Street:"1A Homebush Bay Drive", State:"Rhodes  NSW  2138"}
		SuperDetails["OTN667"] := {Name:"Local Government Superannuation Scheme",Street:"PO Box N835", State:"Grosvenor Place NSW 1220"}
		SuperDetails["OTN674"] := {Name:"Club Plus Superannuation",Street:"Locked Bag 5007", State:"Parramatta NSW 2124"}
		SuperDetails["OTN714"] := {Name:"MLC Wrap Super",Street:"GPO BOX 2567", State:"MELBOURNE  VIC  3001"}
		SuperDetails["OTN723"] := {Name:"FirstWrap Super",Street:"Avanteos Superannuation Trust Fund", State:"FirstWrap"}
		SuperDetails["OTN749"] := {Name:"Water Corporation Superannuation Plan",Street:"PO Box 241", State:"West Perth WA 6872"}
		SuperDetails["OTN750"] := {Name:"Super Directions for Business",Street:"PO Box 14669", State:"Melbourne VIC 8001"}
		SuperDetails["OTN752"] := {Name:"Integra Super",Street:"GPO BOX 5306", State:"Sydney NSW 2001"}
		SuperDetails["OTN766"] := {Name:"Super Directions Personal Super Plan",Street:"AXA Australia", State:"Custormer Service"}
		SuperDetails["OTN785"] := {Name:"Emplus Superannuation",Street:"PO Box 3528", State:"TINGALPA DC, QLD 4173"}
		SuperDetails["OTN856"] := {Name:"Medical & Associated Professions Superannuation Fund",Street:"GPO Box 529", State:"Hobart TAS 7001"}
		SuperDetails["OTN865"] := {Name:"Voyage Superannution Master Trust",Street:"Locked Bag 1000", State:"Wollongong DC NSW 2500"}
		SuperDetails["OTN873"] := {Name:"ING Direct Living Superannuation Fund",Street:"Reply Paid 4307", State:"Sydney NSW 2001"}
		SuperDetails["OTN876"] := {Name:"BT Superannuation Investment Fund",Street:"GPO Box 2675 Sydney NSW 2001", State:""}
		SuperDetails["OTN878"] := {Name:"Compass Ewarp",Street:"PO Box 7241", State:"Cloisters Square Perth WA 6839"}
		SuperDetails["OTN891"] := {Name:"Quadrant Superannuation",Street:"GPO Box 863", State:"Hobart TAS 7001"}
		SuperDetails["OTN907"] := {Name:"Qantas Staff Credit Union Retirement Savings Account",Street:"420 Forest Road", State:"Hurstville NSW 2220"}
		SuperDetails["OTN912"] := {Name:"Police Credit SuperFuture RSA",Street:"PO Box 669", State:"CARTON SOUTH VIC 3053"}
		SuperDetails["OTN948"] := {Name:"Mercy Super",Street:"PO Box 8334", State:"Woolloongabba QLD 4102"}

		This.Collate_Data_from_PIPS()
	}


	Collate_Data_from_PIPS()
	{
		; Grab the ID of PIPS so that we can use it to activate the widnow when we need to. 
		WinGet IDVar, ID, ahk_exe tn3270.exe 
		If !IDVar {
			msgbox % "Error: PIPS Not Found.`n`nEXITING PROCESS`n`nPlease open PIPS then try again."
			Exit
		}

		; Copying the IDVar to the Class Var This.ID
		This.ID := IDVar

		; Creating a sub Object to store the PIPS Data in 
		CheckingObj["Data_from_PIPS"] := {}

		This.Activate()
		sendinput, {F4}
		
		if (This.GetWindowState() = "TIMEOUTCHECK") 
		{
			This.Sleep(100)
			sendinput,{enter}
			This.Sleep(100)
			sendinput,{enter}
			This.Sleep(100)
			sendinput,{enter}
			This.Sleep(200)
		}
		
		This.Sleep(1000)
		
		if (This.GetWindowState() = "MAINMENUCHECK") 
		{				
			This.Sleep(100)
			sendinput, 1.2.1
			This.Sleep(100)
			sendinput,{enter}
			This.Sleep(100)
			sendinput % CheckingObj["AGS"]
			This.Sleep(100)
			sendinput, {enter}
			This.Sleep(200)
		}
		
		if (This.GetWindowState() = "SEPARATEDCHECK") 
		{
			This.Sleep(100)
			sendinput, {enter}
			This.Sleep(200)
		}
		
		This.Sleep(1000)
		
		if (This.GetWindowState() = "CasualCheck") 
		{	
			Array := This.MainframeToTextArray()
			This.Sleep(1000)
			
			CheckingObj["Data_from_PIPS"].Person_Last_Name := substr(Array[6],22,23)
			CheckingObj["Data_from_PIPS"].Person_Given_Name := substr(Array[7],30,45)
			CheckingObj["Data_from_PIPS"].Person_Date_Of_Birth := substr(Array[12],30,12)
			CheckingObj["Data_from_PIPS"].Person_Pay_Centre := substr(Array[18],30,3)
			CheckingObj["Data_from_PIPS"].Person_Courtesy_Title := substr(Array[9],30,4)
		}
		
		else if (This.GetWindowState() = "TempCheck") 
		{
			Array := This.MainframeToTextArray()
			This.Sleep(1000)
			CheckingObj["Data_from_PIPS"].Person_Last_Name := substr(Array[6],22,23)
			CheckingObj["Data_from_PIPS"].Person_Given_Name := substr(Array[7],22,45)
			CheckingObj["Data_from_PIPS"].Person_Date_Of_Birth := substr(Array[11],22,12)
			CheckingObj["Data_from_PIPS"].Person_Pay_Centre := substr(Array[12],22,4)
			CheckingObj["Data_from_PIPS"].Person_Courtesy_Title := substr(Array[9],22,11)
		}	
		
		This.Sleep(200)						 		
		sendinput, {F4}
		sendinput, {TAB}1.2.3
		sendinput, {Enter}{F8}
		This.Sleep(1000)
		
		if (This.GetWindowState() = "SEPARATEDCHECK") 
		{
			This.Sleep(100)
			sendinput, {enter}
			This.Sleep(200)
		}
		This.Sleep(1000)
		
		Array := This.MainframeToTextArray()
		
		if (substr(Array[3],37,9) = "Addresses" and substr(Array[16],66,5) != "Other")
		{
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_1 := substr(Array[12],18,21)
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_2 := substr(Array[13],18,21) 
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_3 := substr(Array[14],18,21) 
			CheckingObj["Data_from_PIPS"].Address_Postal_Suburb := substr(Array[15],18,21) 
			CheckingObj["Data_from_PIPS"].Address_Postal_State := substr(Array[15],46,3) 
			CheckingObj["Data_from_PIPS"].Address_Postal_PostCode := substr(Array[16],18,4) 
			CheckingObj["Data_from_PIPS"].Address_Personal_Mobile := substr(Array[10],61,20) 
			CheckingObj["Data_from_PIPS"].Address_Personal_Email := substr(Array[11],18,50)
			CheckingObj["Data_from_PIPS"].Address_Work_Email := substr(Array[22],18,50) 
		}
		This.Sleep(1000)
		
		if (substr(Array[3],37,9) = "Addresses" and substr(Array[16],66,5) = "Other")
		{
			CheckingObj["Data_from_PIPS"].Address_Personal_Mobile := substr(Array[10],18,20) 
			if (CheckingObj["Data_from_PIPS"].Address_Personal_Mobile = "")
				CheckingObj["Data_from_PIPS"].Address_Personal_Mobile := substr(Array[10],61,20) 
			CheckingObj["Data_from_PIPS"].Address_Personal_Email := substr(Array[11],18,50) 
			CheckingObj["Data_from_PIPS"].Address_Work_Email := substr(Array[22],18,50) 
			sendinput, {Enter}
			This.Sleep(1000)
			Array := This.MainframeToTextArray()
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_1 := substr(Array[12],28,24) 
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_2 := substr(Array[13],28,24) 
			CheckingObj["Data_from_PIPS"].Address_Postal_Line_3 := substr(Array[14],28,24)
			CheckingObj["Data_from_PIPS"].Address_Postal_Suburb := substr(Array[15],28,17) 
			CheckingObj["Data_from_PIPS"].Address_Postal_State := substr(Array[15],56,3) 
			CheckingObj["Data_from_PIPS"].Address_Postal_PostCode := substr(Array[16],28,4) 
		}
		
		Array := ""
		This.Sleep(1000)
		sendinput, {F4}
		sendinput, {TAB}1.2.7
		sendinput, {Enter}{F8}
		This.Sleep(1000)
		
		if (This.GetWindowState() = "SEPARATEDCHECK") 
		{
			This.Sleep(400)
			sendinput, {enter}
			This.Sleep(400)
		}
		
		This.Sleep(1000)
		Array := This.MainframeToTextArray()
		This.Sleep(1000)
		
		this.Activate()
		if (substr(Array[2],3,7) = "(1.2.7)")
		{
			Loop 6
			{
				Test := (InStr(substr(Array[10+A_Index],3,4), "A") ? A_Index : Return)
				if (Test = "")
					Break
				else
					Row := Test
			}
			
			sendinput, %Row% {enter}
			this.Sleep(1000)
		}
		
		Array := This.MainframeToTextArray()
		
		if (substr(Array[3],29,52) = "    Superannuation          - Choice   (Enquiry)    ") {
			this.Sleep(100)
			CheckingObj["Data_from_PIPS"].Super_Member_No := StrReplace(SubStr(Array[11], 55 , 20), "_") 
			CheckingObj["Data_from_PIPS"].Super_Fund_ID	:= SubStr(Array[11], 23 , 7) 
			
			CheckingObj["Data_from_PIPS"].Super_Fund_Name := SuperDetails[TRIM(CheckingObj["Data_from_PIPS"].Super_Fund_ID)].Name
			CheckingObj["Data_from_PIPS"].Super_Fund_Street := SuperDetails[TRIM(CheckingObj["Data_from_PIPS"].Super_Fund_ID)].Street
			CheckingObj["Data_from_PIPS"].Super_Fund_State := SuperDetails[TRIM(CheckingObj["Data_from_PIPS"].Super_Fund_ID)].State			
		}
		else {
			CheckingObj["Data_from_PIPS"].Super_Member_No := "Other - N/A"
			CheckingObj["Data_from_PIPS"].Super_Fund_ID	:= "Other - N/A"
		}
		
		ServiceNo := this.ServiceNo
		winactivate, ePOD
		This.sleep(200)
		WinGet, hWnd, ID, ePOD
		oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
		ControlHwnd := Acc_WindowFromObject(oAcc)
		This.sleep(200)
		ControlFocus,, ahk_id %ControlHwnd%
		This.sleep(200)
		ControlGetFocus, ControlName, ahk_id %ControlHwnd%
		This.sleep(200)
		dllcall("keybd_event", int, 0x25, int, 0x14B, int, 0, int, 0)
		This.sleep(200)
		send, {AppsKey}{Down}{Down}{Enter}
		This.sleep(200)
		Send, % CheckingObj["AGS"] 
		Send {ENTER}
		This.sleep(200)

		oAcc := Acc_Get("Object", "4.1.4.1.4.16.4", vChildID, "ahk_id " hWnd)
		CheckingObj["Data_from_PIPS"].Person_Cost_Code := oAcc.accValue(vChildID)

		oAcc := Acc_Get("Object", "4.1.4.1.4.18.4", vChildID, "ahk_id " hWnd)
		CheckingObj["Data_from_PIPS"].PayCentre := oAcc.accValue(vChildID)
	}































































		Activate()  
		{ 
			WinActivate % "ahk_id " This.ID  
		}   
		
		GetWindowState()
		{
			This.Activate() 
			if FindText(1502-150000, 121-150000, 1502+150000, 121+150000, 0, 0, This.CheckListArray["MAINMENUCHECK"])
				Return This.WindowState:="MAINMENUCHECK"
			else if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, This.CheckListArray["TIMEOUTCHECK"]) 
				Return This.WindowState:="TIMEOUTCHECK"
			else if FindText(2492-150000, 715-150000, 2492+150000, 715+150000, 0, 0, This.CheckListArray["SEPARATEDCHECK"])
				Return This.WindowState:="SEPARATEDCHECK"
			else if FindText(1510-150000, 184-150000, 1510+150000, 184+150000, 0, 0, This.CheckListArray["CASUALCHECK"])
				Return This.WindowState:="CASUALCHECK"
			else if FindText(1750-150000, 550-150000, 1750+150000, 550+150000, 0, 0, This.CheckListArray["TEMPCHECK"])
				Return This.WindowState:="TEMPCHECK"
			else if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, This.CheckListArray["COFCHECK"])
				Return This.WindowState:="COFCHECK"
			else if FindText(1494-150000, 87-150000, 1494+150000, 87+150000, 0, 0, This.CheckListArray["SPR"])
				Return This.WindowState:="SPR"
			else if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, This.CheckListArray["NTGPASSCHECK"])
				Return This.WindowState:="NTGPASSCHECK"
			else
				Return This.WindowState:="ERROR"
		}

		Float( n, p:=6 ) 
		{ 
			Return SubStr(n:=Format("{:0." p "f}",n),1,-1-p) . ((n:=RTrim(SubStr(n,1-p),0) ) ? "." . n : "") 
		; By SKAN on D1BM @ goo.gl/Q7zQG9
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

			GetCellValue(Find,offset_X,offset_Y)
		{
			Temp := ComObjActive("Excel.Application")
			ComObjError(false)
			Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
			return Temp.Range(Pointer.Offset(offset_X, offset_Y).address).Value
		}
		
		SetCellValue(Find,Value,offset_X,offset_Y)
		{
			Temp := ComObjActive("Excel.Application")
			ComObjError(false)
			Pointer := Temp.ActiveSheet.Range("A:H").Find(Find)
			Temp.ActiveSheet.Range(Pointer.Offset(offset_X, offset_Y).address).Value := Value
		}
		
		MainframeToTextArray()
		{
			This.Sleep(100)	
			winactivate, Mochasoft
			This.Sleep(100)
			sendinput, {Alt}ES
			This.Sleep(500)
			sendinput, ^c
			This.Sleep(500)
			This.Array := StrSplit(Clipboard, "`n")
			This.Sleep(200)
			Return This.Array
		}
		
		Sleep(Duration)
		{
			if (Thread_Kill_Token = True)
			{
				Thread_Kill_Token := !Thread_Kill_Token
				Exit
			}
			Sleep % Duration
		}
}