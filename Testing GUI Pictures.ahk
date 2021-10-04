#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

	
	hBM := DllCall( "LoadImage", UInt,0, Str,"C:\Users\babb\Desktop\output-onlinepngtools.png", UInt,0, Int,600,Int,, UInt,0x2010 )
	Gui, Add, Picture, w100 h100 0xE hwndhPic,
	Gui, Show

	OnMessage(0x200, "WM_MOUSEMOVE")

Loo
Exit


		WM_MOUSEMOVE(wParam, lParam, Msg, Hwnd) {
			Global
			DllCall("TrackMouseEvent", "UInt", &TME)
			MouseGetPos,,,, MouseCtrl, 2
			ToolTip % MouseCtrl " vs " hA_N
			GuiControl, % (MouseCtrl = hA_N) ? "Show" : "Hide", % hA_H
				
		}

GDI_SetImageX( hBM, hPic ) { ; By SKAN Created 10-Nov-2011
 ; SetImage without flicker :       www.autohotkey.com/forum/viewtopic.php?p=488784#488784
 hdcSrc  := DllCall( "CreateCompatibleDC", UInt,0 )
 hdcDst  := DllCall( "GetDC", UInt,hCtrl )
 VarSetCapacity( bm,24,0 ) ; BITMAP Structure
 DllCall( "GetObject", UInt,hbm, UInt,24, UInt,&bm )
 w := Numget( bm,4 ), h := Numget( bm,8 )
 hbmOld  := DllCall( "SelectObject", UInt,hdcSrc, UInt,hBM )
 hbmNew  := DllCall( "CreateBitmap", Int,w, Int,h, UInt,NumGet( bm,16,"UShort" )
                    , UInt,NumGet( bm,18,"UShort" ), Int,0 )
 hbmOld2 := DllCall( "SelectObject", UInt,hdcDst, UInt,hbmNew )
 DllCall( "BitBlt", UInt,hdcDst, Int,0, Int,0, Int,w, Int,h
                  , UInt,hdcSrc, Int,0, Int,0, UInt,0x00CC0020 )
 DllCall( "SelectObject", UInt,hdcSrc, UInt,hbmOld )
 DllCall( "DeleteDC",  UInt,hdcSrc ),   DllCall( "ReleaseDC", UInt,hCtrl, UInt,hdcDst )
 DllCall( "SendMessage", UInt,hCtrl, UInt,0x0B, UInt,0, UInt,0 )        ; WM_SETREDRAW OFF
 oBM := DllCall( "SendMessage", UInt,hCtrl, UInt,0x172, UInt,0, UInt,hBM ) ; STM_SETIMAGE
 DllCall( "SendMessage", UInt,hCtrl, UInt,0x0B, UInt,1, UInt,0 )        ; WM_SETREDRAW ON
 DllCall( "DeleteObject", UInt,oBM )
}