#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Global Workbook, CheckListArray

CheckListArray :=   {"TIMEOUTCHECK":"|<>*48$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsDzsDw7kDUDz00TllztnznzTzLzjjjnyztwzszjz9zrrrzzDxzTwDrzizvvvzzbwzbybvzrTxxxzznyTnzNxznbyyyzzvzDxzgyzvvzzTzztzbyzrDTxwzzjzz1znzTvrjwyTzrzzwTtzjxtryzjzvzzzbwzryyPz03zxzzznyTvzTBzDxzyzzzxzDtzjmzjyzzTzzyzbwzrwTbzDzjzzyTvyTvyDnzrzrzvzDwyTxzbvzvzvzwSDzCTs7nkDUT07zUTzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"
					,"MAINMENUCHECK":"|<>*45$41.zzzzzzzzzzzzzztzw7znznznbzbzDzDbzbyTyzjzDsztzDzDnznyTyTbzbyzwSDzDxzwwzyTvzttzwzrznnztzjzbbznzTzDDzbwzySTzDtzwwTzTnztwzyTDzXtzyQzzDlzy3zyTnzzzztzbzzzznzbzzzzDzjzzzyTzzzzzzz"							
					,"SEPARATEDCHECK":"|<>*106$78.zzzzzzzbzzzzzzzzzzzzbzzzzzzDzzzzzDzzzyTzDkD1zzDUy1yTyDwzrzyDwTnzDyTyzbzyTwTnzDwTyTDzyTwDnzbwzzDDzwzxDnzbwzziTzwzxbnzXszzYzztzxbnznszzkzztzxnnznszztzznzxtnzntzztzznzxtnzntzztzzbzxwnznszztzzbzxwnznszztzzDzxyHznszztzzDzxz3znwzztzzDzxz3zXwzztzyTzxzXzbwTy0DyTzkDXzbyTzzzwzzzzzzDyDzzzwzzzzzzDzDzzzzzzzzzyTzjzzzzzzzzzyTzzzzzzzzzzzzzU"
					,"CASUALCHECK":"|<>*106$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs7w2TzzzzzzzzzzzzzDXkzzzzzzzzzzzzzySTlzzzzzzzzzzzzzwxznzzzzzzzzzzzzztnzby1zy0DVsDy1zznbzzlszswTnyTlszzbTzzztzbwzbwzztzzCzzzzvzDtzDtzzvzyRzzzzrzDzyTnzzrzwvzzzzjz0Twzbzzjztrzzy0TzyTtzDy0TznbzzlwzzyTnyTlwzzbDzzDxzzyTbwzDxzzDDySTvzTwzDtyTvzyTTtwzbyTnzTXwzbzwzD7swDwTDyS7swDztz0zw33v0zy13w33k0Tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
					,"TEMPCHECK":"|<>*47$101.zzzzzzwzzzzzzzzzzzzzzzztzzzzzzzzzzbzzzzzbzzzzDzzzzzDkT1zzDUy1yTzzzzwztzjzwztzjyTzzzztzvyTztzlzTwzzzzzXzntzzrzVyzwzzzzzDznrzzDzHxztzzzzyTzrDzyTynvzlzzzzszzYzztzxbrznzzzznzzXzznzvbjzbzzzzbzzbzzDzrjTzDzzzzDzzTzyTzjCzyTzzzyTzyzztzzTBzwzzzzwzzxzznzyyPztzzzztzzvzzDzxyLznzzzzlzzrzyTzvyDzbzzXznzzjzxzzrwTyDzy3zbzzTznzzjwzwzzw7z7zU3zjzw3tztzzwTzDzzzyTzzzzzbzzzzyTzzzwzzzzzzDzzzzyTzzzzzzzzzwzzzzzyzzzzzzzzzztzzzzzzzzzzzzzzzzzzzzzz"
					,"COFCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUHzUTs01zzzzzzzzwS7wSTwznzzzzzzzznyDnyTtzbzzzzzzzzjyT7yTnzDzzzzzzzyTwyTwzbyTzzzzzzzwzzwzwzDzzzzzzzzzvzznztyQzzzzzzzzzbzzbznwtzzzU0DzzzDzzDzbs3zzz00TzzyTzyTzDnbzzzzzzzzyzzwzyTbDzzzzzzzzwzzxzwzDzzzzzzzzztzztznyTzzzzzzzzztzntzbwzzzzzzzzzzvzDnyTtzzzzzzzzzztszltznzzzzzzzzzzs7zs7y0Dzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
					,"NTGPASSCHECK":"|<>*107$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUy1s03zUHzzzzzzzzszbnnrwy7zzzzzzzzlzDbbjnzDzzzzzzzzVyTDDTjyTzzzzzzzzHwySSyTzzzzzzzzzyntwwxwzzzzzzzzzzxbnztzvzzzzzzzzzzvbbznzbzzzzU0DzzzrbDzbzDzzzz00TzzzjCTzDyTUDzzzzzzzzTAzyTyzwzzzzzzzzyyNzwzwztzzzzzzzzxyHztztznzzzzzzzzvy7znznzbzzzzzzzzrwDzbznzDzzzzzzzzjwTzDzlyTzzzzzzzw3szU3zs3zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
					,"SPR":"|<>*108$71.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkC1w1zk0TUy1bzrzdztyTszbjzDyHznyTlzDTyTwrzbyzVySyQzvbzDwzHwwstzbDyTvynttlnzDTwzbxbnndbyyTtwTvbbaHDtwzk3zrbDAqznxzbbzjCTPhzU1zDbzTAyr/yTvyTbyyNxC7xznwzbxyHsQDnzbtzjvy7lwTbzjnzDrwDXszTzDbzTjwT7ls7kA1yA3szzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"}

Active_AGS := "85984001"
LoadClientData(Active_AGS)
return

LoadClientData(ServiceNo)
{
	Workbook := {}
	winactivate, Mochasoft
	Sleep(500)
	sendinput, {F4}
	Sleep(100)
	
	 if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, CheckListArray["TimeOutCheck"])
	 {
			Sleep(100)
			sendinput,{enter}
			Sleep(100)
			sendinput,{enter}
			Sleep(100)
			sendinput,{enter}
	 }
	
	if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, CheckListArray["MainMenuCheck"])
		{
			   	winactivate, Mochasoft
				Sleep(100)
				sendinput, 1.2.1
				Sleep(100)
				sendinput,{enter}
				Sleep(100)
				sendinput, %ServiceNo%
				Sleep(100)
				sendinput, {enter}
				Sleep(300)
		
	 if FindText(2492-150000, 715-150000, 2492+150000, 715+150000, 0, 0, CheckListArray["SEPARATEDCHECK"])
		 {
			Sleep(100)
			sendinput, {enter}
			Sleep(100)
		 }
		
	 if FindText(1510-150000, 184-150000, 1510+150000, 184+150000, 0, 0, CheckListArray["CASUALCHECK"])
		{
				Array := MainframeToTextArray()
				Workbook.Surname := substr(Array[6],22,23)
				Workbook.Given_names := substr(Array[7],30,45)
				Workbook.Date_of_birth := substr(Array[12],30,11)
				Workbook.Pay_centre := substr(Array[18],30,3)
				Workbook.Courtesy_Title := substr(Array[9],30,4)
		}
	
	if FindText(1750-150000, 550-150000, 1750+150000, 550+150000, 0, 0, CheckListArray["TEMPCHECK"])
	 	{			
				Array := MainframeToTextArray()
				Workbook.Surname := substr(Array[6],22,23)
				Workbook.Given_names := substr(Array[7],22,45)
				Workbook.Date_of_birth := substr(Array[10],22,11)
				Workbook.Pay_centre := substr(Array[12],22,4)
				Workbook.Courtesy_Title := substr(Array[9],22,11)
		 }
	
winactivate, Mochasoft
sendinput, {F4}

	 if FindText(1538-150000, 154-150000, 1538+150000, 154+150000, 0, 0, CheckListArray["TIMEOUTCHECK"])
		 {
				Sleep(100)
				sendinput,{enter}
				Sleep(100)
				sendinput,{enter}
				Sleep(100)
				sendinput,{enter}
		 }
	
	if FindText(1502-150000, 121-150000, 1502+150000, 121+150000, 0, 0, CheckListArray["MAINMENUCHECK"]) 
		 {
			
			winactivate, Mochasoft
			Sleep(100)
			sendinput, Sup
			Sleep(100)
			sendinput,{enter}
			Sleep(100)
			sendinput, %ServiceNo%
			Sleep(100)
			sendinput, {enter}
			Sleep(300)
		 }

	 if FindText(2492-150000, 715-150000, 2492+150000, 715+150000, 0, 0, CheckListArray["SEPARATEDCHECK"])
		 {
			Sleep(100)
			sendinput, {enter}
			Sleep(100)
		 }

	 if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, CheckListArray["COFCHECK"])
		 {
			Array := MainframeToTextArray()
	
			if (substr(Array[2],3,7) = "(5.6.1)")
				{
					Sleep(100)
					sendinput, ____________1{Enter}
					Sleep(900)
	
				if FindText(1494-150000, 87-150000, 1494+150000, 87+150000, 0, 0, CheckListArray["SPR"])
					sendinput,{Enter}
	
					Sleep(300)
					Array := MainframeToTextArray()
					Workbook.SuperRef := StrReplace(SubStr(Array[11], 55 , 20), "_")
					Workbook.SuperFund	:= SubStr(Array[11], 23 , 7)
				}
	
		  }

	 if FindText(2493-150000, 153-150000, 2493+150000, 153+150000, 0, 0, CheckListArray["NTGPASSCHECK"])
		 {
				Workbook.SuperRef := "NTGPASS - N/A"
				Workbook.SuperFund	:= "NTGPASS - N/A"
		 }
}

winactivate, ePOD
WinGet, hWnd, ID, ePOD
oAcc := Acc_Get("Object", "4.4.4", 0, "ahk_id " hWnd) 
ControlHwnd := Acc_WindowFromObject(oAcc)
ControlFocus,, ahk_id %ControlHwnd%
ControlGetFocus, ControlName, ahk_id %ControlHwnd%
dllcall("keybd_event", int, 0x25, int, 0x14B, int, 0, int, 0)
send, {AppsKey}{Down}{Down}{Enter}
sleep(200)
Send, %ServiceNo%{ENTER}
sleep(200)
oAcc := Acc_Get("Object", "4.1.4.1.4.16.4", vChildID, "ahk_id " hWnd)
Workbook.CostCode := oAcc.accValue(vChildID)

MsgBox % "Done."
}

MainframeToTextArray()
{
	Sleep(100)
	winactivate, Mochasoft
	Sleep(100)
	sendinput, {Alt}ES
	Sleep(500)
	sendinput, ^c
	Sleep(100)
	Sleep(500)
	Array := StrSplit(Clipboard, "`n")
	Sleep(300)
	Return Array
}

Sleep(Duration)
{
	Sleep % Duration
}
