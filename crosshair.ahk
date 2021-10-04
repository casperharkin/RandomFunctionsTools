/*
© 2017 Commanding
Free to use/distribute/change, but please give credit to the original!
*/
#SingleInstance, force
Menu, Tray, NoStandard 
Menu, Tray, Add, Exit, Exit
Menu, Tray, Default, Exit

diam = 25 ; Maximum canvas size of X-Y values for crosshair

Max = 255 ; Used to set max color value for slider
a1=BE        ; Red value
a2=00        ; Green value
a3=FF        ; Blue value

crosshair1 = 10-0 10-4 9-5 8-5 7-5 6-7 5-8 5-10 0-9 0-15 5-14 5-16 6-17 7-18 8-19 9-19 10-20 9-25 15-25 14-19 15-19 16-19 17-18 18-17 19-16 19-15 20-14 25-15 25-9 20-10 19-9 19-8 18-7 17-5 16-5 14-5 15-0 10-0 12-9 10-4 9-5 8-5 7-5 6-7 5-8 5-10 9-12 5-14 5-16 6-17 7-18 8-19 9-19 10-20 12-15 14-19 15-19 16-19 17-18 18-17 19-16 19-15 20-14 16-12 20-10 19-9 19-8 18-7 17-5 16-5 14-5 12-9 12-11 13-12 12-13 12-12 12-11 12-9 10-0
crosshair2 = 10-10 7-2 12-2 12-13 13-12 12-11 12-2 18-2 14-10 23-5 23-18 14-14 18-23 7-23 10-14 2-18 2-5 10-10 6-2 5-2 3-3 2-5 2-5 2-18 2-19 3-21 5-23 6-23 18-23 19-23 21-22 23-19 23-18 23-5 23-5 22-3 20-2 19-2 6-2
crosshair3 = 11-16 11-22 9-20 8-19 7-18 6-17 5-16 5-15 4-14 4-10 5-9 5-8 6-7 7-6 8-5 9-4 10-4 11-3 14-3 15-4 16-4 17-5 18-6 19-7 20-8 20-9 21-10 21-14 20-15 20-16 19-17 18-18 17-19 16-20 14-22 14-16 15-17 16-17 17-16 17-15 18-14 18-10 17-9 17-8 16-7 15-7 14-6 11-6 10-7 9-7 8-8 8-9 7-10 7-14 8-15 8-16 9-17 10-17 11-16 11-16 11-12 12-13 12-10 13-11 12-12 12-13 11-12 12-13 11-14 13-14 13-12 14-13 13-14 11-14
crosshair4 = 7-8 12-0 17-8 20-12 24-21 15-21 9-21 0-21 4-12 6-13 3-19 9-19 9-21 15-21 15-19 21-19 18-13 20-12 17-8 15-9 12-4 9-9 7-8
crosshair5 = 12-0 15-0 16-1 17-1 18-2 19-2 20-3 21-4 22-5 22-6 23-7 23-8 24-9 24-15 23-16 23-17 22-18 22-19 21-20 20-21 19-22 18-22 17-23 16-23 15-24 9-24 8-23 7-23 6-22 5-22 4-21 3-20 2-19 2-18 1-17 1-16 0-15 0-9 1-8 1-7 2-6 2-5 3-4 4-3 5-2 6-2 7-1 8-1 9-0 12-0 13-1 13-9 12-9 12-2 9-2 8-3 7-3 6-4 5-4 4-5 4-6 3-7 3-8 2-9 2-12 9-12 9-13 2-13 2-15 3-16 3-17 4-18 4-19 5-20 6-20 7-21 8-21 9-22 12-22 12-15 13-15 13-22 15-22 16-21 17-21 18-20 19-20 20-19 20-18 21-17 21-16 22-15 22-13 15-13 15-12 22-12 22-9 21-8 21-7 20-6 20-5 19-4 18-4 17-3 16-3 15-2 12-2 12-0
crosshair6 = 12-0 15-0 16-1 17-1 18-2 19-2 20-3 21-4 22-5 22-6 23-7 23-8 24-9 24-15 23-16 23-17 22-18 22-19 21-20 20-21 19-22 18-22 17-23 16-23 15-24 9-24 8-23 7-23 6-22 5-22 4-21 3-20 2-19 2-18 1-17 1-16 0-15 0-9 1-8 1-7 2-6 2-5 3-4 4-3 5-2 6-2 7-1 8-1 9-0 12-0 12-2 9-2 8-3 7-3 6-4 4-3 3-4 4-6 3-7 3-8 2-9 2-15 3-16 3-17 4-18 2-19 4-22 6-20 7-21 8-21 9-22 15-22 16-21 17-21 18-20 20-21 21-19 20-18 21-17 21-16 22-15 22-9 21-8 21-7 20-6 21-4 20-3 18-4 17-3 16-3 15-2 12-2 12-0 12-13 13-12 12-11 12-0
crosshair7 = 12-0 15-0 16-1 17-1 18-2 19-2 20-3 21-4 22-5 22-6 23-7 23-8 24-9 24-15 23-16 23-17 22-18 22-19 21-20 20-21 19-22 18-22 17-23 16-23 15-24 9-24 8-23 7-23 6-22 5-22 4-21 3-20 2-19 2-18 1-17 1-16 0-15 0-9 1-8 1-7 2-6 2-5 3-4 4-3 5-2 6-2 7-1 8-1 9-0 12-0 12-2 9-2 8-3 8-6 7-7 7-10 8-10 9-9 9-7 8-6 8-3 7-3 6-4 5-4 4-5 4-6 3-7 3-8 2-9 2-15 3-16 3-17 4-18 4-19 5-20 6-20 7-21 8-21 9-22 12-22 12-16 9-16 8-17 7-17 5-19 4-18 4-17 5-16 6-15 7-14 8-14 9-13 15-13 16-14 17-14 18-15 19-16 20-17 20-18 19-19 18-19 17-17 16-17 15-16 12-16 12-22 15-22 16-21 17-21 18-20 19-20 20-19 20-18 21-17 21-16 22-15 22-9 21-8 21-7 20-6 20-5 19-4 18-4 17-3 16-3 16-7 16-10 17-10 18-9 18-7 17-6 16-7 16-3 15-2 12-2 12-0
crosshair8 = 12-0 15-0 16-1 17-1 18-2 19-2 20-3 21-4 22-5 22-6 23-7 23-8 24-9 24-15 23-16 23-17 22-18 22-19 21-20 20-21 19-22 18-22 17-23 16-23 15-24 9-24 8-23 7-23 6-22 5-22 4-21 3-20 2-19 2-18 1-17 1-16 0-15 0-9 1-8 1-7 2-6 2-5 3-4 4-3 5-2 6-2 7-1 8-1 9-0 12-0 12-2 9-2 8-3 7-3 6-4 5-4 4-5 4-6 3-7 3-8 2-9 2-15 3-16 3-17 4-18 4-19 5-20 6-20 7-21 8-21 8-20 8-16 4-16 4-17 7-20 8-20 8-21 9-22 15-22 16-21 16-20 16-16 18-16 20-16 20-17 16-20 16-21 17-21 18-20 19-20 20-19 20-18 21-17 21-16 22-15 22-9 21-8 21-7 20-6 20-5 19-4 18-4 17-3 16-3 15-3 9-3 12-6 15-3 15-2 12-2 12-0
crosshair9 = 12-0 25-0 25-25 0-25 0-0 9-0 7-2 2-2 2-7 0-9 0-15 2-17 2-23 7-23 9-25 16-25 18-23 23-23 23-17 25-15 25-9 23-7 23-2 17-2 15-0 12-0 12-3 12-11 11-11 11-12 3-12 3-13 11-13 11-14 12-14 12-22 13-22 13-14 14-14 14-13 22-13 22-12 14-12 14-11 13-11 13-3 12-3 12-0
crosshair10 = 11-11 14-11 14-14 11-14 11-11
; These are X-Y pairs, used to draw the window in the desired shape.
activecrosshair := crosshair1 ; Default crosshair

invisible = 0
menutoggle = 1 ; Initialize menu to OFF
previewactive1 = 1 ; Default cursor is selected in F10 Menu
previewactive2 = 0 ; Following selections are 'inactive'
previewactive3 = 0
previewactive4 = 0
previewactive5 = 0
previewactive6 = 0
previewactive7 = 0
previewactive8 = 0
previewactive9 = 0
previewactive10 = 0
start: ; Gosubs here after icon selection
Gui, crosshair:New, +LastFound +AlwaysOnTop -Caption ; Instantiate GUI window with name 'crosshair', set as Active window, set to be always-on-top, and remove the window borders.
Gui, crosshair:+Owner ; Makes the GUI owned by the script's main window, forcing non-display of a taskbar button
Gui margin,0,0 ; Sets the window margin to 0,0 to disable padding
Gui crosshair:Add,Progress,x-2 y-2 w35 h35 c%a1%%a2%%a3% -border vCrosshair,100 ; Creates a silder with the hex color value of a1+a2+a3(RGB), and removes the slider's default border
SysGet, mon, Monitor ; Get main working monitor's maximum dimensions
Gui crosshair:show, % "x" monRight//2-(diam//2) " y" monBottom//2-(diam//2) NA ; Set crosshair to center in the main monitor
WinSet, Region, %activecrosshair%, A ; Set active crosshair
WinGetPos, Xpos, Ypos, A ; Grab window's Xpos and Ypos to allow everything to adjust dynamically with window position.
menuXpos := Xpos+50 ; Offset F10 Menu from center of main GUI window
menuYpos := Ypos+50 ; Offset F10 Menu from center of main GUI window
Gui, +E0x80020 ; Extended style, makes the window ignore the mouse cursor
return

F11::
if invisible = 0
{
    invisible = 1
    Gui, crosshair:Hide
    Gui, colorslider:Destroy
}
Else
{
    invisible = 0
    Gui, crosshair:Show
}
return

F10::
if menutoggle = 0
{
    menutoggle = 1
    Gui, colorslider:Destroy
}
Else
{
    menutoggle = 0 ; Just in case

    crosshairXpos1 := Xpos+100, crosshairXpos6 := Xpos+100
    crosshairXpos2 := Xpos+140, crosshairXpos7 := Xpos+140
    crosshairXpos3 := Xpos+180, crosshairXpos8 := Xpos+180
    crosshairXpos4 := Xpos+220, crosshairXpos9 := Xpos+220
    crosshairXpos5 := Xpos+260, crosshairXpos10 := Xpos+260
    crosshairYpos1 := Ypos+60, crosshairYpos2 := Ypos+60, crosshairYpos3 := Ypos+60, crosshairYpos4 := Ypos+60, crosshairYpos5 := Ypos+60
    crosshairYpos6 := Ypos+100, crosshairYpos7 := Ypos+100, crosshairYpos8 := Ypos+100, crosshairYpos9 := Ypos+100, crosshairYpos10 := Ypos+100

    Gui, colorslider:New, +AlwaysOnTop +E0x08000000 -Caption +border
    Gui -dpiscale
    Gui margin,5,5
    Gui, colorslider:Show,x%menuXpos% y%menuYpos% w245 h85, Color Slider
    Gui, colorslider:Add, Slider, w35 h75 vaa gsave AltSubmit -border Page10 Range1-300 TickInterval50 Vertical, 

    loop, 10
    {
        boxXpos%A_Index% := crosshairXpos%A_Index%-5
        boxYpos%A_Index% := crosshairYpos%A_Index%-5
        if previewactive%A_Index% = 1
        {
            SelectionColor%A_Index% = Silver
            PreviewColor%A_Index% = Fuchsia
        }
        else
        {
            SelectionColor%A_Index% = Gray
            PreviewColor%A_Index% = Blue
        }

            selectionColorLoopX := % boxXpos%A_Index%
            selectionColorLoopY := % boxYpos%A_Index%
            crosshairColorLoopX := % crosshairXpos%A_Index%
            crosshairColorLoopY := % crosshairYpos%A_Index%
            shadowboxColor := % selectioncolor%A_Index%
            crosshairColor := % previewcolor%A_Index%
            crosshairNumber := % crosshair%A_Index%
            selectionNumber = Selection%A_Index% ;

            Gui, shadowbox%A_Index%:New, +AlwaysOnTop +E0x08000000 -Caption
            Gui -dpiscale
            Gui margin,0,0
            Gui shadowbox%A_Index%:Add,Listview, w35 h35 Background%shadowboxColor% v%A_Index% gSelection -Hdr -E0x200 -border AltSubmit
            Gui, shadowbox%A_Index%:+Ownercolorslider
            Gui, shadowbox%A_Index%:Show,x%selectionColorLoopX% y%selectionColorLoopY% w35 h35

            Gui, crosshairpreview%A_Index%:New, +AlwaysOnTop +E0x08000000 -Caption
            Gui crosshairpreview%A_Index%:Add,Progress, x-3 y-3 w35 h35 c%crosshairColor% vPreview%A_Index% -border,100
            Gui, crosshairpreview%A_Index%:+Ownercolorslider
            Gui, crosshairpreview%A_Index%:Show,x%crosshairColorLoopX% y%crosshairColorLoopY% w35 h35
            WinSet, Region, %crosshairNumber%, A
            Gui, +E0x80020
            Gosub save
        }
    return
    }


Selection: 
selectionCrosshairXpos := % crosshairXpos%A_GuiControl%
selectionCrosshairYpos := % crosshairYpos%A_GuiControl%
crosshairActiveNum := % crosshair%A_GuiControl%
if A_GuiEvent = Normal
{
    loop, 10
    {
        if A_Index = %A_GuiControl%
        {
            previewactive%A_GuiControl% = 1
            Gui, crosshairpreview%A_GuiControl%:New, +AlwaysOnTop +E0x08000000 -Caption
            Gui crosshairpreview%A_GuiControl%:Add,Progress,x-2 y-2 w35 h35 cFuchsia vPreview%A_GuiControl% -border,100
            Gui, crosshairpreview%A_GuiControl%:+Ownercolorslider
            Gui, crosshairpreview%A_GuiControl%:Show,x%selectionCrosshairXpos% y%selectionCrosshairYpos% w35 h35
            WinSet, Region, %crosshairActiveNum%, A
            Gui, +E0x80020
            activecrosshair := crosshairActiveNum
            Gui, crosshair:Destroy
            GuiControl shadowbox%A_GuiControl%:+BackgroundSilver, %A_GuiControl%
            GuiControl crosshairpreview%A_GuiControl%:+cFuchsia, Preview%A_GuiControl%
            gosub, Start
        }
        else
        {
            previewactive%A_Index% = 0
            GuiControl shadowbox%A_Index%:+BackgroundGray, %A_Index%
            GuiControl crosshairpreview%A_Index%:+cBlue, Preview%A_Index%
        }
    }
}
return


save:
Gui, crosshair:Submit, Nohide
n := Round(max/50,0)
if aa between 1 and 50
{
    a1 := Color(max)
    ab := aa*n
    a2 := Color(ab)
    a3 := Color(0)
}
if aa between 51 and 100
{
    a2 := Color(max)
    ab := (max-aa)*n
    a1 := Color(ab)
    a3 := Color(0)
}
if aa between 101 and 150
{
    a2 := Color(max)
    ab := (aa-100)*n
    a3 := Color(ab)
    a1 := Color(0)
}
if aa between 151 and 200
{
    a3 := Color(max)
    ab := (max-(aa-150))*n
    a2 := Color(ab)
    a1 := Color(0)
}
if aa between 201 and 250
{
    a3 := Color(max)
    ab := (aa-200)*n
    a1 := Color(ab)
    a2 := Color(0)
}
if aa between 251 and 300
{
    a1 := Color(max)
    ab := (max-(aa-250))*n
    a3 := Color(ab)
    a2 := Color(0)
}
loop, 1
{
    GuiControl crosshair:+c%a1%%a2%%a3%, Crosshair
}
return

Color(N) {
   SetFormat, Integer, Hex 
   N += 0 
   SetFormat, Integer, D 
   StringTrimLeft, N, N, 2 
   If(StrLen(N) < 2) 
      N = 0%N%
   Return N 
}

Exit: 
    ExitApp 
Return