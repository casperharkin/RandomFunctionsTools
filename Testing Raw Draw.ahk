#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#SingleInstance,Force

; Build the GUI Here
Gui,1:+AlwaysOnTop +LastFound -DPIScale
Gui,1:Color,2B2728
Gui,1:Font,cWhite s12 Bold,Segoe UI
Gui,1:Add,Text,  w200 h200 gSwitch_State +center, `n`nClick Me`n`n`nto make me Sad
Gui,1:Add,Text, x210 y15 w200 h200 , Text  		;Switch 1 Trigger

Gui,1:Show,autosize,BitMap Maker Demo 2

;Start Global GDI Object
global GDI_Obj := {} 

GDI_Obj.Width 		:= 200
GDI_Obj.Hight 		:= 200
GDI_Obj.SourceWidth := 200
GDI_Obj.SourceHight := 200

GDI_Obj.Token 	:= Gdip_Startup()
GDI_Obj.HWND 	:= WinExist()
GDI_Obj.hdc1 	:= GetDC(GDI_Obj.HWND)
GDI_Obj.hdc2 	:= CreateCompatibleDC()
GDI_Obj.hbm 	:= CreateDIBSection(GDI_Obj.Width,GDI_Obj.Hight)
GDI_Obj.obm 	:= SelectObject(GDI_Obj.hdc2,GDI_Obj.hbm)
GDI_Obj.G 		:= Gdip_GraphicsFromHDC(GDI_Obj.hdc2)

Gdip_DrawImage( GDI_Obj.G, Blank(), 15, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight)

Gdip_DrawImage( GDI_Obj.G, HAPPY(), 15, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight)
BitBlt(GDI_Obj.hdc1 , 210, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight, GDI_Obj.hdc2 ,15, 15) 
return

GuiClose:
GuiContextMenu:
*ESC::
	ExitApp

Switch_State()
{

static State

Gdip_DrawImage( GDI_Obj.G, Blank(), 15, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight)
BitBlt(GDI_Obj.hdc1 , 210, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight, GDI_Obj.hdc2 ,15, 15) 


	if(!State:=!State)
		{
			Gdip_DrawImage( GDI_Obj.G, HAPPY(), 15, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight)
			BitBlt(GDI_Obj.hdc1 , 210, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight, GDI_Obj.hdc2 ,15, 15) 
		}
else	
		{
			Gdip_DrawImage( GDI_Obj.G, SAD(), 15, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight)
			BitBlt(GDI_Obj.hdc1 , 210, 15, GDI_Obj.SourceWidth, GDI_Obj.SourceHight, GDI_Obj.hdc2 ,15, 15) 
		}
}

HAPPY(){
	;Bitmap Created Using: HB Bitmap Maker
	pBitmap:=Gdip_CreateBitmap( 201 , 200 ) 
	 G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 4 )
	Brush := Gdip_BrushCreateSolid( "0xFF227447" )
	Gdip_FillEllipse( G , Brush , 29 , 43 , 50 , 50 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF227447" )
	Gdip_FillEllipse( G , Brush , 120 , 43 , 50 , 50 )
	Gdip_DeleteBrush( Brush )
	Pen := Gdip_CreatePen( "0xFFFF0000" , 3 )
	Gdip_DrawArc( G , Pen , -70 , 100 , 220 , 35 , 0 , 90 )
	Gdip_DeletePen( Pen )
	Gdip_DeleteGraphics( G )
	return pBitmap
}

SAD(){
	;Bitmap Created Using: HB Bitmap Maker
	pBitmap:=Gdip_CreateBitmap( 201 , 200 ) 
	 G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 4 )
	Brush := Gdip_BrushCreateSolid( "0xFF227447" )
	Gdip_FillEllipse( G , Brush , 29 , 43 , 50 , 50 )
	Gdip_DeleteBrush( Brush )
	Brush := Gdip_BrushCreateSolid( "0xFF227447" )
	Gdip_FillEllipse( G , Brush , 120 , 43 , 50 , 50 )
	Gdip_DeleteBrush( Brush )
	Pen := Gdip_CreatePen( "0xFFFF0000" , 3 )
	Gdip_DrawArc( G , Pen , 22 , 120 , 160 , 50 , 180 , 180 )
	Gdip_DeletePen( Pen )
	Gdip_DeleteGraphics( G )
	return pBitmap
}

Blank()
{
	pBitmap:=Gdip_CreateBitmap( 200 , 200 ) 
	 G := Gdip_GraphicsFromImage( pBitmap )
	Gdip_SetSmoothingMode( G , 4 )
	Brush := Gdip_BrushCreateSolid( "0xFF333333" )
	Gdip_FillRectangle( G , Brush , -1 , -1 , 205 , 201 )
	Gdip_DeleteBrush( Brush )
	Gdip_DeleteGraphics( G )
	return pBitmap
}

Switch()
{

MsgBox Switch
}