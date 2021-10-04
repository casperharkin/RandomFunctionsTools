#NoEnv

If (!pToken := Gdip_Startup()){
  MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system!
  ExitApp
}



;First we build our normal GUI
GUI, add, text, x20 y450, This is GDI+ example code
Gui, add, button, w100 h20 gBTN1_CLICK, [.click]
Gui, show, w400 h500, Example GDI+

HWND := WinExist("A")                                       ; Get the HWND of our Window




; ++++++  GDI Stuff starts here +++++++++


hdc_WINDOW      := GetDC(HWND)                              ; MASTER DC on our Window
; We could draw on this DC directly, but its better and more comfortable to create a 
; 2nd DC, (as a frame) to  draw on. 
; So, If we want to show our Frame in the GUI, we have to copy (BitBlt) our Frame DC
; over the Window DC. This is done in the DRAW_SCENE Sub.


; This is our frame
hbm_main := CreateDIBSection(400, 400)              ; 400 x 400 is the size of our GDI image
hdc_main := CreateCompatibleDC()
obm      := SelectObject(hdc_main, hbm_main)
G        := Gdip_GraphicsFromHDC(hdc_main)          ; Getting a Pointer to our bitmap

  


;some brushes

   pBTURCI              := Gdip_BrushCreateSolid(0xaa008080)
   pBGREEN              := Gdip_BrushCreateSolid(0xff00FF00)
   pBTURCI              := Gdip_BrushCreateSolid(0xff008080)
   pBWHITE              := Gdip_BrushCreateSolid(0xffFFFFFF)
   
   
   ; Now we draw on our Frame:
   
   Gdip_FillRectangle(G,pBWHITE,0,0,400,400)    ;white background
   Gdip_FillRectangle(G,pBTURCI,0,0,400,400)    ;some blue
   Gdip_FillRectangle(G,pBGREEN,100,100,200,200)    ;green small rectangle

; Ok, the frame is now ready, but the user can't see anything:
; because we have to BitBlt() this frame to our Window DC -
; actually, this is often done with a settimer:
   
SetTimer,DRAW_SCENE, 20
   
return      
   
   
BTN1_CLICK:
   Gdip_FillRectangle(G,pBWHITE,10,10,200,150)    ;green small rectangle
return


;draws the scene
DRAW_SCENE:
   BitBlt(hdc_WINDOW,0, 0, 400,400, hdc_main,0,0) ;position of the GDI Image in the GUI
return