
		ToolTip % "-Start-"
		Sleep("10s")
		ToolTip
		Exit
		
		
		
		Sleep(Time){
		RegexMatch(Time, "\d+\K.{1,2}", unit)
		Time := StrReplace(Time, unit)
		r := % (unit = "ms" or unit = "") ? (Time) : (unit = "s") ? (Time*1000) : (unit = "m") ? ((Time*60)*1000) :
		Sleep % r
		}
