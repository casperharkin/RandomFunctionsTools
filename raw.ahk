#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

		Gui Percentage_Finder: New
		Gui, Color, Black, 282a2e
		Gui, +AlwaysOnTop +ToolWindow +Border
		Gui Font, s11 Cwhite, Consolas

		Gui Add,Text, x10 y10 w200 h16 +0x200,% "What is         % of" ;Long text box
		Gui Add,Edit, x70 y08 w65 h20 gLabel0 vPer1 Right                   ;1st_Input
		Gui Add,Edit, x180 y08 w55 h20 gLabel0 vPer2 Right                  ;2nd_Input
		Gui Add,Text, x240 y10 w70 h16 +0x200 vPerA                         ;Answer
		;-----------------------------------------------------------------------------------
		Gui Add,Edit, x10 y38 w65 h20 gLabel1 vPer3 Right                   ;1st Input
		Gui Add,Text, x80 y40 w200 h16 +0x200,% "is what % of "         ;Long text box
		Gui Add,Edit, x180 y38 w55 h20 gLabel1 vPer4 Right                  ;2nd Input
		Gui Add,Text, x240 y40 w70 h16 +0x200 vPerB                             ;Answer
		;-----------------------------------------------------------------------------------
		Gui Add,Edit, x10 y68 w65 h20 gLabel2 vPer5 Right                   ;1st Input
		Gui Add,Text, x80 y72 w200 h16 +0x200,% "is        % of what"   ;Long text box
		Gui Add,Edit, x100 y68 w55 h20 gLabel2 vPer6 Right                  ;2nd Input
		Gui Add,Text, x240 y72 w70 h16 +0x200 vPerC                         ;Answer
		;-----------------------------------------------------------------------------------
		Gui Add,Text, x10 y100 w300 h16 +0x200,% "-------- Find % of Gain/Loss --------"    ;Long text box
		;-----------------------------------------------------------------------------------
		Gui Add,Text, x10 y128 w200 h16 +0x200,% "From:          TO:"   ;Long text box
		Gui Add,Edit, x55 y125 w70 h20 gLabel3 vPer7 Right                  ;2nd Input
		Gui Add,Edit, x160 y125 w75 h20 gLabel3 vPer8 Right             ;2nd Input
		Gui Add,Text, x240 y128 w70 h16 +0x200 vPerD                        ;Answer
		;-----------------------------------------------------------------------------------
		Gui Show,w320 h160,Percentage_Finder                                                            ;Show centred > in body



; Reference https://percentcalc.com/
Return

; Labels
Label0:                               ;Run whenever 1st or 2nd Input change
  Gui Submit,NoHide                                          ;Keep showing
  If (Per1<>"" && Per2<>"")             ;If 1st and 2nd Input have content
    GuiControl Percentage_Finder:,PerA,% Round(((Per1*Per2)/100),2)       ;Do the thing
  Else                                                          ;Otherwise
    GuiControl Percentage_Finder:,PerA                                ;Put a mask on it
Return

Label1:
  Gui Submit,NoHide                                          ;Keep showing
  If (Per3<>"" && Per4<>"")             ;If 1st and 2nd Input have content
    GuiControl Percentage_Finder:,PerB,% Round(((Per3*100)/Per4),2)`%      ;Do the thing
  Else                                                          ;Otherwise
    GuiControl Percentage_Finder:,PerB                                ;Put a mask on it
Return

Label2:
  Gui Submit,NoHide                                          ;Keep showing
  If (Per5<>"" && Per6<>"")             ;If 1st and 2nd Input have content
    GuiControl Percentage_Finder:,PerC,% Round(((per5*100) / Per6))      ;Do the thing
  Else                                                          ;Otherwise
    GuiControl Percentage_Finder:,PerC                                ;Put a mask on it
Return

Label3:
  Gui Submit,NoHide                                          ;Keep showing
  If (Per7<>"" && Per8<>"")             ;If 1st and 2nd Input have content
    GuiControl Percentage_Finder:,PerD,% Round(((per8-per7) / per7) * 100 ,2)`%      ;Do the thing
  Else                                                          ;Otherwise
    GuiControl Percentage_Finder:,PerD                                ;Put a mask on it
Return


Percentage_FinderGuiEscape:
Percentage_FinderGuiClose:
  ExitApp
