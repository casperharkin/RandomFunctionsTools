#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Global Hwnd

gui +resize +hwndHwnd
Gui Add, Button, x15 y15 +hwndh1, 1


Gui Add, Button, +hwndh2, 2
Gui Add, Button, +hwndh3,3
Gui Add, Button, +hwndh4, 4
 
Gui Add, Button, ys +hwndh5, 5
Gui Add, Button, +hwndh6, 6
Gui Add, Button, +hwndh7, 7
Gui Add, Button, +hwndh8, 8

Gui Add, Button, ys +hwndh9, 9
Gui Add, Button, +hwndh10, 10
Gui Add, Button, +hwndh11, 11
Gui Add, Button, +hwndh12, 12

Gui Show, , Window
OnMessage(0x05, "WM_SIZE")			; 0x05 = WM_SIZE
Exit

WM_SIZE() {
Global

AutoXYWH("*w0.1h0.1",h1)
AutoXYWH("*y0.1w0.1h0.1",h2)
AutoXYWH("*y0.2w0.1h0.1",h3)
AutoXYWH("*y0.3w0.1h0.1",h4)

AutoXYWH("*x0.5w0.1h0.1",h5)
AutoXYWH("*x0.5y0.2w0.1h0.1",h6)
AutoXYWH("*x0.5y0.4w0.1h0.1",h7)
AutoXYWH("*x0.5y0.6w0.1h0.1",h8)

AutoXYWH("*x1w0.1h0.1",h9)
AutoXYWH("*x1y0.2w0.1h0.1",h10)
AutoXYWH("*x1y0.4w0.1h0.1",h11)
AutoXYWH("*x1y0.6w0.1h0.1",h12)

}


	AutoXYWH(DimSize, cList*){       ; http://ahkscript.org/boards/viewtopic.php?t=1079
		static cInfo := {}
		
		If (DimSize = "reset")
			Return cInfo := {}
		
			VarSetCapacity(rc, 16)
			DllCall("GetClientRect", "uint", Hwnd, "uint", &rc)
			GuiWidth := NumGet(rc, 8, "int")
			GuiHeight := NumGet(rc, 12, "int")
		
			For i, ctrl in cList {
			  ctrlID := A_Gui ":" ctrl
			  If ( cInfo[ctrlID].x = "" ){
			      GuiControlGet, i, %A_Gui%:Pos, %ctrl%
			      MMD := InStr(DimSize, "*") ? "MoveDraw" : "Move"
			      fx := fy := fw := fh := 0
			      For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]")))
			          If !RegExMatch(DimSize, "i)" dim "\s*\K[\d.-]+", f%dim%)
			            f%dim% := 1
			      cInfo[ctrlID] := { x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:GuiWidth, gh:GuiHeight, a:a , m:MMD}
			  }Else If ( cInfo[ctrlID].a.1) {
			      dgx := dgw := GuiWidth  - cInfo[ctrlID].gw  , dgy := dgh := GuiHeight - cInfo[ctrlID].gh
			      For i, dim in cInfo[ctrlID]["a"]
			          Options .= dim (dg%dim% * cInfo[ctrlID]["f" dim] + cInfo[ctrlID][dim]) A_Space
			      GuiControl, % A_Gui ":" cInfo[ctrlID].m , % ctrl, % Options
				} 
			} 
	}
