#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
ListLines Off

OnExit, OnExit_CleanUP

Gui, Font, s15 bold
Gui, Add, Pic, Border w300 h300 0x201 cGray vImageFile gSelectFile, Click, or drag image file to here...
Gui, Add, Text, xm cRed, Pixel
Gui, Font
Gui, Add, Text, hp 0x200 x+20, Width:
Gui, Add, Edit, hp 0x200 x+5 w50 Center Number gCheckInput vCeil_Width cBlue, 
Gui, Add, Text, hp 0x200 x+20, Height:
Gui, Add, Edit, hp 0x200 x+5 w50 Center Number gCheckInput vCeil_Height cBlue, 
Gui, Add, Button, x90 y+30 w150 h30 Default gBtnConvert, Convert
Gui, Show,, PixelData Creator

If 1 !=
{
    ImageFile = %1%
    Goto, UpdateImagePath
}
Return

; =================================
;        SelectFile
; =================================
SelectFile:
    FileSelectFile, SelectedFile, 1
    If !SelectedFile
        Return

    ImageFile := SelectedFile

UpdateImagePath:
    If !TxtFontChanged {
        Gui, Font, s10 cBlue
        GuiControl, Font, ImageFile
        TxtFontChanged := True
    }

    GuiControl,, ImageFile, % ImageFile
    GuiControl, Focus, Ceil_Width
Return

; =================================
;        CheckInput
; =================================
CheckInput:
    If (A_GuiControl = "Ceil_Width") {
        GuiControlGet, Ceil_Width
        GuiControl,, Ceil_Height, % Ceil_Width
    }
Return

; =================================
;        BtnConvert
; =================================
BtnConvert:
    Gui, Submit, NoHide
    If (!Ceil_Width || !Ceil_Height || !ImageFile)
        Return

    obj := Get_PixelData(PixelData, ImageFile, Ceil_Width, Ceil_Height)
    Gosub, Create_AHK_File
Return

; =================================
;        Create_AHK_File
; =================================
Create_AHK_File:
col := obj.col, row := obj.row, w := obj.w, h := obj.h
SplitPath, ImageFile, ImgFileName

; ----------------------------------------------------------------------------------------- code start
code =
(
#NoEnv
#SingleInstance, Force
SetBatchLines -1

PixelData=
( LTrim Join|
    %PixelData%
`)
hBM := CreateDIB( PixelData, %col%, %row% )

Gui, Margin, 0, 0
Gui, Add, Picture, w%w% h%h% 0x4E hwndcHwnd ; SS_REALSIZECONTROL = 0x40 | SS_BITMAP = 0xE
DllCall( "SendMessage", UInt,cHwnd, UInt,0x172, UInt,0, UInt,hBM ) ; STM_SETIMAGE = 0x172
Gui, Show
 
Return

GuiClose:
ExitApp

CreateDIB( PixelData, W, H, ResizeW=0, ResizeH=0, Gradient=1  ) { ;     SKAN, 01-Apr-2014
  WB := Ceil( ( W * 3 )/ 2 ) * 2,  VarSetCapacity( BMBITS, WB * H + 1, 0 ),  P := &BMBITS
  Loop, Parse, PixelData, |
   P := Numput( "0x" A_LoopField, P+0 ) - ( W & 1 && !Mod( A_Index * 3, W * 3 ) ? 0 : 1 )
  hBM := DllCall( "CreateBitmap", Int,W, Int,H, UInt,1, UInt,24, UInt,0 )    
  hBM := DllCall( "CopyImage", UInt,hBM, Int,0, Int,0, Int,0, UInt,0x2008 ) 
  DllCall( "SetBitmapBits", UInt,hBM, UInt,WB * H, UInt,&BMBITS )
  hBM := ! Gradient ? DllCall( "CopyImage", UInt,hBM, UInt,0, Int,0, Int,0, Int,8 ) : hBM 
Return DllCall( "CopyImage", UInt,hBM, Int,0, Int,ResizeW, Int,ResizeH, Int,0x200C, UInt )
} ; http://ahkscript.org/boards/viewtopic.php?t=3203   
)
; ----------------------------------------------------------------------------------------- code end

FileOpen(ImageFile ".ahk", "w").Write(code)
Run, % ImageFile ".ahk"
Return

; =================================
;        GuiDropFiles
; =================================
GuiDropFiles:
    ImageFile := A_GuiEvent
    Goto, UpdateImagePath
Return

; =================================
;        Exit
; =================================
GuiClose:
ExitApp

OnExit_CleanUP:
    Get_PixelData()
ExitApp

; =================================================== Functions ===================================================
Get_PixelData(ByRef PixelData = "", ImgFile = "", Ceil_Width = "", Ceil_Height = "") {
    static pToken := Gdip_Startup()
    static pBitmap

    If !IsByRef(PixelData) {
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        Return
    }

    pBitmap := Gdip_CreateBitmapFromFile(ImgFile)
    Gdip_GetDimensions(pBitmap, w, h)

    x := Ceil_Width//2
    y := Ceil_Height//2
    row := h // Ceil_Height
    col := w // Ceil_Width
    PixelData := ""
    Loop, % row
    {
        Loop, % col
        {
            ARGB := Gdip_GetPixel(pBitmap, x, y)
            Gdip_FromARGB(ARGB, A, R, G, B)
            PixelData .= dec2hex(R) dec2hex(G) dec2hex(B) "|"
            x += Ceil_Width
        }

        x := Ceil_Width//2, y += Ceil_Height
        PixelData .= "`n" A_Tab
    }

    PixelData := RegExReplace(PixelData, "m`a)\|$")
    PixelData := Trim(PixelData, "`n")

    Return {w: w, h: h, row: row, col: col}
}

dec2hex(n)
{
    OldFormat := A_FormatInteger ; save the current format as a string
    SetFormat, Integer, Hex
    n += 0
    SetFormat, Integer, %OldFormat%
    Return SubStr("0" SubStr(n, 3), -1)
}

