


MsgBox % GetNextPay()


Exit

; This function will get the next pay period for recovery 
; by using todays date and making sure that if the payday is
; less than 14 days in the future, the pay after is selected. 
GetNextPay(){

	Paydates =
	(
	01=08/07/2021
	02=22/07/2021
	03=05/08/2021
	04=19/08/2021
	05=02/09/2021
	06=16/09/2021
	07=30/09/2021
	08=14/10/2021
	09=28/10/2021
	10=11/11/2021
	11=25/11/2021
	12=09/12/2021
	13=23/12/2021
	14=06/01/2022
	15=20/01/2022
	16=03/02/2022
	17=17/02/2022
	18=03/03/2022
	19=17/03/2022
	20=31/03/2022
	21=14/04/2022
	22=28/04/2022
	23=12/05/2022
	24=26/05/2022
	25=09/06/2022
	26=23/06/2022
	)
	
	PayCal := {}
	Array := StrSplit(Paydates, "`n")
	for Each, Item in Array
		PayCal["Pay " . StrSplit(Item, "=").1] := StrSplit(Item, "=").2

	FormatTime, Time,, dd/MM/yyyy
	Day := StrSplit(Time, "/").1
	Month := StrSplit(Time, "/").2
	Year  := StrSplit(Time, "/").3
	
	for each, item in PayCal 
		if (Month = StrSplit(item, "/").2) and (Year = StrSplit(item, "/").3) 
			If (Day < StrSplit(item, "/").1) and (StrSplit(item, "/").1-Day > 14)
					Return "Pay: " each "`nDate: " item
}
