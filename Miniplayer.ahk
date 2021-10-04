
FileSelectFile, SelectedFile, 3, , Open a file

Gui, New
Gui, +LastFound +Resize +alwaysontop -caption +Toolwindow +hwndhGUI
Gui, Add, ActiveX, x0 y0 w500 h300 vWMP, WMPLayer.OCX
Gui, Show, x900 y612 W181 H89  ,Player GUI

WMP.Url := SelectedFile
WMP.uiMode := "none"

SetTimer, Position, 1000
return

#q::
if (WMP.uiMode != "none")
	WMP.uiMode := "none"
Else
	WMP.uiMode := "mini"

return

GuiClose:
   ExitApp

GuiSize:
   GuiControl, Move, WMP, w%A_GuiWidth% h%A_GuiHeight%
   return

  Position:
Gui, Show, NA, % WMP.CurrentMedia.name " - " Format(WMP.Controls.currentPosition) " / " Format(WMP.CurrentMedia.duration)
return


Format(m1) {
   static units := "sec,min,hr"
   Loop Parse, units, csv
      RegExMatch(m1/60, "(.*)(\.\d*)", m), %A_LoopField% := Pad(Round(m2*60))
   return (hr? hr ":":"") min ":" sec
}

Pad(p) {
   return (p<10? "0":"") p
}