#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance force
Global Workbook, CheckListArray, Stage
Workbook := {}
Workbook.ServiceNo := ServiceNo := "02419008"






Load_Client: 

;Create Instance
ActiveClientData := New MainfraimToText(ServiceNo)

ActiveClientData.Navigate()
ActiveClientData.GatherPersonDetails()
ActiveClientData.GatherAddresses()
ActiveClientData.GatherSuperannuation()
ActiveClientData.GatherCostCode()

return


;Declare Class
Class MainfraimToText
{
	__New(ServiceNo)
	{
		CheckListArray :=   {"TIMEOUTCHECK":"|<>*48$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzsDw7kDUDz00TllztnznzTzLzjjjnyztwzszjz9zrrrzzDxzTwDrzizvvvzzbwzbybvzrTxxxzznyTnzNxznbyyyzzvzDxzgyzvvzzTzztzbyzrDTxwzzjzz1znzTvrjwyTzrzzwTtzjxtryzjzvzzzbwzryyPz03zxzzznyTvzTBzDxzyzzzxzDtzjmzjyzzTzzyzbwzrwTbzDzjzzyTvyTvyDnzrzrzvzDwyTxzbvzvzvzwSDzCTs7nkDUT07zUTzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
						    ,"MAINMENUCHECK":"|<>*45$41.zzzzzzzzzzzzzztzw7znznznbzbzDzDbzbyTyzjzDsztzDzDnznyTyTbzbyzwSDzDxzwwzyTvzttzwzrznnztzjzbbznzTzDDzbwzySTzDtzwwTzTnztwzyTDzXtzyQzzDlzy3zyTnzzzztzbzzzznzbzzzzDzjzzzyTzzzzzzz"							
					        ,"SEPARATEDCHECK":"|<>*106$78.zzzzzzzbzzzzzzzzzzzzbzzzzzzDzzzzzDzzzyTzDkD1zzDUy1yTyDwzrzyDwTnzDyTyzbzyTwTnzDwTyTDzyTwDnzbwzzDDzwzxDnzbwzziTzwzxbnzXszzYzztzxbnznszzkzztzxnnznszztzznzxtnzntzztzznzxtnzntzztzzbzxwnznszztzzbzxwnznszztzzDzxyHznszztzzDzxz3znwzztzzDzxz3zXwzztzyTzxzXzbwTy0DyTzkDXzbyTzzzwzzzzzzDyDzzzwzzzzzzDzDzzzzzzzzzyTzjzzzzzzzzzyTzzzzzzzzzzzzzU"
							,"CASUALCHECK":"|<>*106$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs7w2TzzzzzzzzzzzzzDXkzzzzzzzzzzzzzySTlzzzzzzzzzzzzzwxznzzzzzzzzzzzzztnzby1zy0DVsDy1zznbzzlszswTnyTlszzbTzzztzbwzbwzztzzCzzzzvzDtzDtzzvzyRzzzzrzDzyTnzzrzwvzzzzjz0Twzbzzjztrzzy0TzyTtzDy0TznbzzlwzzyTnyTlwzzbDzzDxzzyTbwzDxzzDDySTvzTwzDtyTvzyTTtwzbyTnzTXwzbzwzD7swDwTDyS7swDztz0zw33v0zy13w33k0Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
							,"TEMPCHECK":"|<>*47$101.zzzzzzwzzzzzzzzzzzzzzzztzzzzzzzzzzbzzzzzbzzzzDzzzzzDkT1zzDUy1yTzzzzwztzjzwztzjyTzzzztzvyTztzlzTwzzzzzXzntzzrzVyzwzzzzzDznrzzDzHxztzzzzyTzrDzyTynvzlzzzzszzYzztzxbrznzzzznzzXzznzvbjzbzzzzbzzbzzDzrjTzDzzzzDzzTzyTzjCzyTzzzyTzyzztzzTBzwzzzzwzzxzznzyyPztzzzztzzvzzDzxyLznzzzzlzzrzyTzvyDzbzzXznzzjzxzzrwTyDzy3zbzzTznzzjwzwzzw7z7zU3zjzw3tztzzwTzDzzzyTzzzzzbzzzzyTzzzwzzzzzzDzzzzyTzzzzzzzzzwzzzzzyzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzz"
							,"COFCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUHzUTs01zzzzzzzzwS7wSTwznzzzzzzzznyDnyTtzbzzzzzzzzjyT7yTnzDzzzzzzzyTwyTwzbyTzzzzzzzwzzwzwzDzzzzzzzzzvzznztyQzzzzzzzzzbzzbznwtzzzU0DzzzDzzDzbs3zzz00TzzyTzyTzDnbzzzzzzzzyzzwzyTbDzzzzzzzzwzzxzwzDzzzzzzzzztzztznyTzzzzzzzzztzntzbwzzzzzzzzzzvzDnyTtzzzzzzzzzztszltznzzzzzzzzzzs7zs7y0Dzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
							,"NTGPASSCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUy1s03zUHzzzzzzzzszbnnrwy7zzzzzzzzlzDbbjnzDzzzzzzzzVyTDDTjyTzzzzzzzzHwySSyTzzzzzzzzzyntwwxwzzzzzzzzzzxbnztzvzzzzzzzzzzvbbznzbzzzzU0DzzzrbDzbzDzzzz00TzzzjCTzDyTUDzzzzzzzzTAzyTyzwzzzzzzzzyyNzwzwztzzzzzzzzxyHztztznzzzzzzzzvy7znznzbzzzzzzzzrwDzbznzDzzzzzzzzjwTzDzlyTzzzzzzzw3szU3zs3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
							,"SPR":"|<>*108$71.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkC1w1zk0TUy1bzrzdztyTszbjzDyHznyTlzDTyTwrzbyzVySyQzvbzDwzHwwstzbDyTvynttlnzDTwzbxbnndbyyTtwTvbbaHDtwzk3zrbDAqznxzbbzjCTPhzU1zDbzTAyr/yTvyTbyyNxC7xznwzbxyHsQDnzbtzjvy7lwTbzjnzDrwDXszTzDbzTjwT7ls7kA1yA3szzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}
		Stage := 1
		WinGet IDVar,ID, ahk_exe tn3270.exe  
		This.ServiceNo := ServiceNo
		This.ID:=IDVar  
		WinActivate % "ahk_id "This.ID  
		sendinput,{F4}
	}

	Activate()  
	{ 
		WinActivate % "ahk_id "This.ID  
		Return This.ID
	}   

	GetWindowState()
	{
		This.Activate() 
		if FindText(1502-150000, 121-150000, 1502+150000, 121+150000, 0, 0, CheckListArray["MAINMENUCHECK"])
			Return This.WindowState:="MAINMENUCHECK"
		else if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, CheckListArray["TIMEOUTCHECK"]) 
			Return This.WindowState:="TIMEOUTCHECK"
		else if FindText(2492-150000, 715-150000, 2492+150000, 715+150000, 0, 0, CheckListArray["SEPARATEDCHECK"])
			Return This.WindowState:="SEPARATEDCHECK"
		else if FindText(1510-150000, 184-150000, 1510+150000, 184+150000, 0, 0, CheckListArray["CASUALCHECK"])
			Return This.WindowState:="CASUALCHECK"
		else if FindText(1750-150000, 550-150000, 1750+150000, 550+150000, 0, 0, CheckListArray["TEMPCHECK"])
		 	Return This.WindowState:="TEMPCHECK"
		else if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, CheckListArray["COFCHECK"])
			Return This.WindowState:="COFCHECK"
		else if FindText(1494-150000, 87-150000, 1494+150000, 87+150000, 0, 0, CheckListArray["SPR"])
			Return This.WindowState:="SPR"
		else if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, CheckListArray["NTGPASSCHECK"])
			Return This.WindowState:="NTGPASSCHECK"
		else
			Return This.WindowState:="ERROR"
	}
		
	Navigate()
	{
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
		if (This.GetWindowState() = "MAINMENUCHECK") 
			{
				This.Sleep(100)
				sendinput, 1.2.1
				This.Sleep(100)
				sendinput,{enter}
				This.Sleep(100)
				sendinput % this.ServiceNo 
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
	}

	GatherPersonDetails()
	{
		if (This.GetWindowState() = "CasualCheck") 
		{	
			Array := This.MainframeToTextArray()
			Sleep 2000
			Workbook.Surname := substr(Array[6],22,23)
			Workbook.Given_names := substr(Array[7],30,45)
			Workbook.Date_of_birth := substr(Array[12],30,11)
			Workbook.Pay_centre := substr(Array[18],30,3)
			Workbook.Courtesy_Title := substr(Array[9],30,4)
		}
		else if (This.GetWindowState() = "TempCheck") 
		{
			Array := This.MainframeToTextArray()
			Sleep 2000
			Workbook.Surname := substr(Array[6],22,23)
			Workbook.Given_names := substr(Array[7],22,45)
			Workbook.Date_of_birth := substr(Array[10],22,11)
			Workbook.Pay_centre := substr(Array[12],22,4)
			Workbook.Courtesy_Title := substr(Array[9],22,11)
		}	
		
		while (Workbook.Surname = "") or (Workbook.Date_of_birth = "")
			This.GatherPersonDetails()

		Stage := 2
		sendinput, {F4}
		sendinput, {TAB}1.2.3
		sendinput, {Enter}{F8}
	}

	GatherAddresses()
	{
		This.Navigate()
		Array := This.MainframeToTextArray()
		if (substr(Array[3],37,9) = "Addresses" and substr(Array[16],66,5) != "Other")
		{
			Workbook.Street_1 := substr(Array[12],18,21)
			Workbook.Street_2 := substr(Array[13],18,21) 
			Workbook.Street_3 := substr(Array[14],18,21) 
			Workbook.City := substr(Array[15],18,21) 
			Workbook.State := substr(Array[15],46,3) 
			Workbook.PostCode := substr(Array[16],18,4) 
			Workbook.Phone := substr(Array[10],18,20) 
			Workbook.Email := substr(Array[11],18,50)
			Workbook.WorkEmail := substr(Array[22],18,50) 
		}

		if (substr(Array[3],37,9) = "Addresses" and substr(Array[16],66,5) = "Other")
		{
			Workbook.Phone := substr(Array[10],18,20) 
			if (Workbook.Phone = "")
				Workbook.Phone := substr(Array[10],61,20) 
			Workbook.Email := substr(Array[11],18,50) 
			Workbook.WorkEmail := substr(Array[22],18,50) 
			sendinput, {Enter}

			Array := This.MainframeToTextArray()
			Workbook.Street_1 := substr(Array[12],28,24) 
			Workbook.Street_2 := substr(Array[13],28,24) 
			Workbook.Street_3 := substr(Array[14],28,24) 
			Workbook.City := substr(Array[15],28,17) 
			Workbook.State := substr(Array[15],56,3) 
			Workbook.PostCode := substr(Array[16],28,4) 
		}
		Stage := 3
		sendinput, {F4}
		sendinput, {TAB}1.2.7
		sendinput, {Enter}{F8}
	}
	
	GatherSuperannuation()
	{
		This.Navigate()
		Array := This.MainframeToTextArray()
		if (substr(Array[2],3,7) = "(1.2.7)")
				Loop 6
					Test := (InStr(substr(Array[10+A_Index],3,4), "A") ? A_Index : Return)
						if (Test != "")
							sendinput, %Test% {enter}
		Array := This.MainframeToTextArray()
		Clipboard := substr(Array[3],29,52)
		if (substr(Array[3],29,52) = "    Superannuation          - Choice   (Enquiry)    ")
			{
				Workbook.SuperRef := StrReplace(SubStr(Array[11], 55 , 20), "_") 
				Workbook.SuperFund	:= SubStr(Array[11], 23 , 7) 
			}
		else
			{
				Workbook.SuperRef := "Other - N/A"
				Workbook.SuperFund	:= "Other - N/A"
			}
		Stage := "Done"
	}

	GatherCostCode()
	{
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
		Send, %ServiceNo%{ENTER}
		This.sleep(200)
		oAcc := Acc_Get("Object", "4.1.4.1.4.16.4", vChildID, "ahk_id " hWnd)
		Workbook.CostCode := oAcc.accValue(vChildID)
	}

	MainframeToTextArray()
	{
		This.Sleep(100)
		winactivate, Mochasoft
		This.Sleep(100)
		sendinput, {Alt}ES
		This.Sleep(500)
		sendinput, ^c
		This.Sleep(100)
		This.Sleep(300)
		This.Array := StrSplit(Clipboard, "`n")
		This.Sleep(200)
		Return This.Array
	}

}

	Sleep(Duration)
	{
		Sleep % Duration
	}
