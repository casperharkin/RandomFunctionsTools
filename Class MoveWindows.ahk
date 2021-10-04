#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Gui, Add, Text, w400 +Center cBold, Volume: 
Gui, Add, Slider, w400 gVolume vvVolume,  50
Gui, Show

Exit

q::MoveWindows.Shuffle(Toggle := !Toggle)


Volume() {
GuiControlGet, vVolume
Tooltip % "Send {Volume_Up " vVolume "}"
}







Class MoveWindows {


	Shuffle(Toggle) {
		SetWinDelay, 200

		hWindows := {} 
		MonitorDims := {}

		WinGet, List, List
		
		Loop % List
			s .= List%A_Index% "`n"
		
		Loop, parse, s, `n
		{
		  	WinGettitle, Title, % " AHK_ID " A_LoopField
			if (Title != "") {
				WinGet, style, style, ahk_id %id%
					if !(style & 0xC00000) { ; If Window has no title bar
						WinGetClass, class, % " AHK_ID " A_LoopField
						If !InStr(class, "Windows.UI.Core.CoreWindow")
							if !InStr(class, "ApplicationFrameWindow")
								if !InStr(Title, "PDR Toolbar")
									if !InStr(class, "Progman") {
										WinGet, vMinMax, MinMax, % " AHK_ID " A_LoopField
										hWindows[Title] := {"hwnd":A_LoopField, "MinMax": vMinMax}
									}
					}
			}
		}

		
		SysGet, vMonitorCount, MonitorCount
		Loop % vMonitorCount {
			SysGet, vMonitor, Monitor, % A_Index
			MonitorDims["Monitor " A_Index] := {"MonitorLeft": vMonitorLeft, "MonitorTop":vMonitorTop,"MonitorRight":vMonitorRight,"MonitorBottom":vMonitorBottom}
		}

		For Each, Item in hWindows
			WinRestore,  % " ahk_id " hWindows[Each]["hwnd"]

		If (Toggle = 1) {
			For Each, Item in hWindows
				WinMove, % " ahk_id " hWindows[Each]["hwnd"], , % MonitorDims["Monitor 2"]["MonitorLeft"]
		}

		If (Toggle = 0) {
			For Each, Item in hWindows
				WinMove, % " ahk_id " hWindows[Each]["hwnd"], , % MonitorDims["Monitor 1"]["MonitorLeft"]
		}
		
		For Each, Item in hWindows
			If (hWindows[Each]["MinMax"] = 1) {
				WinMaximize, % " ahk_id " hWindows[Each]["hwnd"]
		}

	}

}
