#SingleInstance Force                       ; Only open a single instance of application
#Persistent                                 ; Keep open until excplicitly closed
#NoEnv                                      ; Don't load environment variables (compatability)
#Warn                                       ; Show Debug Warning Messages
SetWorkingDir %A_ScriptDir%                 ; Set Working Directory to Script's current directory
FileEncoding, UTF-8                         ; Set File Encoding to Unicode UTF-8
SetBatchLines, -1                           ; Constant Runtime --> Disable Application/CPU Sleep Cycles
SendMode, Input                             ; Use SendInput mode
DetectHiddenWindows, On                     ; Allow detection of hidden windows
SetWinDelay, -1                             ; Immediately update GUI/Window Commands
SetControlDelay, -1                         ; Immediately modify controls

; ##--------------------------------##
; #|        Global Variables        |#
; ##--------------------------------##
; Width and Height Definitions
parentW := 800                              ; Parent Width
topbarW := parentW                          ; TopBar Width
sidebarW := Round((parentW / 6), 0)         ; SideBar Width
formW := parentW - sidebarW                 ; Form Width
parentH := 600                              ; Parent Height
topbarH := 100                              ; Topbar Height
sidebarH := parentH - topbarH               ; SideBar Height
formH := parentH - topbarH                  ; Form Height

; X&Y Positioning
topbarX := 0                                ; TopBar X Position
sidebarX := 0                               ; SideBar X Position
formX := sidebarW                           ; Form X Position
topbarY := 0                                ; TopBar Y Position
sidebarY := topbarH                         ; SideBar Y Position
formY := topbarH                            ; Form Y Position

; Hex Colors
parentBG := "FFFFFF"                        ; Parent's Background
topbarBG := "FF8E77"                        ; TopBar's Background
sidebarBG := "6DFF79"                       ; SideBar's Background
formBG := "93D7FF"                          ; Form's Background

; Default Values
defGamePath := "C:\Users\" A_UserName "\AppData\Local\osu!"    ; Default osu! Installation path
defSplooshName := "SPLOOSH ( + )"           ; Default SPLOOSH Directory


; ##------------------------##
; #|        Functions       |#
; ##------------------------##

; ##------------------------##
; #|        Parent GUI      |#
; ##------------------------##
; Parent Window
GuiParent() {
    Global                                  ; Set Global Scope inside Function
    Gui, Parent: +HWNDhParent               ; Define Parent GUI, Assign Window Handle to %hParent%
    Gui, Parent: +MinSize500x500            ; Define Parent GUI's Minimum Size (500px by 500px)
    ;Gui, Parent: +MaxSize800x600            ; Define Parent GUI's Max Size (800px by 600px)
    Gui, Parent: +LastFound                 ; Place Parent GUI in last-ound coordinates
    Gui, Parent: +Resize                    ; Allow Parent GUI to be resizable
    Gui, Parent: Margin, 0, 0               ; Disable Parent GUI's Margin
    Gui, Parent: Color, %parentBG%          ; Set Parent GUI's Background Color
}

; ##------------------------##
; #|        TopBar GUI      |#
; ##------------------------##
GuiTopBar() {
    Global                                  ; Set Global Scope inside Function
    Gui, TopBar: +ParentParent              ; Define GUI as a child of Parent
    Gui, TopBar: +HWNDhTopBar               ; Assign Window Handle to %hTopBar%
    Gui, TopBar: -Caption                   ; Disable Titlebar
    Gui, TopBar: -Border                    ; Disable Border
    Gui, TopBar: -DpiScale                  ; Disable Windows Scaling
    Gui, TopBar: Margin, 0, 0               ; Disable Margin
    Gui, TopBar: Color, %topbarBG%          ; Set Background Color

    ; Define Local Variables
    Local wText := 120                      ; Width of Text
    Local wButton := 120                    ; Width of Button
    Local wEdit := 360                      ; Width of Edit
    Local hText := 23                       ; Width of Text
    Local hButton := 23                     ; Height of Button
    Local rEdit := 1                        ; 

    ; Define Arrays containing X Positioning for Elements
    Local arrXPos1 := [0, 1, 10, 20]
    For index, value in arrXPos1 {
        If (value = 0) {
            continue
        } Else {
            arrXPos1.InsertAt(index, ((wText + 10) + (value * 20)))
        }
        arrXPos1.RemoveAt(index + 1)
    }
    Local arrXPos2 := arrXPos1

    ; Define Arrays containing Y Positiong for Elements
    Local arrYPos1 := [0, 0, 0, 0]
    Local arrYPos2 := [50, 50, 50]

    ; Add Labels to TopBar GUI
    Gui, TopBar: Add, Text, % "x" arrXPos1[1] " y" arrYPos1[1] " w" wText " h" hText " +0x200 +BackgroundTrans", CATEGORY:
    Gui, TopBar: Add, Text, % "x" arrXPos2[1] " y" arrYPos2[1] " w" wText " h" hText " +0x200 +BackgroundTrans", osu! PATH:

    ; Add Controls to TopBar GUI
    Gui, TopBar: Add, Button, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wButton " h" hButton " +gGetPlayerForm +AltSubmit", &PLAYER
    Gui, TopBar: Add, Button, % "x" arrXPos1[3] " y" arrYPos1[3] " w" wButton " h" hButton " +gGetUIColorForm +AltSubmit", &UIColor
    Gui, TopBar: Add, Button, % "x" arrXPos1[4] " y" arrYPos1[4] " w" wButton " h" hButton " +gGetElementForm +AltSubmit", &ELEMENT
    Gui, TopBar: Add, Button, % "x" arrXPos2[2] " y" arrYPos2[2] " w" wButton " h" hButton " +gBrowseGameDirectory +AltSubmit", Browse...
    Gui, TopBar: Add, Edit, % "x" arrXPos2[3] " y" arrYPos2[3] " w" wEdit " r" rEdit " +vGameDirectory", %defGamePath%
}

; ##---------------------------##
; #|        Siderbar GUI       |#
; ##---------------------------##
GuiSideBar() {
    Global                                  ; Set Global Scope inside Function
    Gui, SideBar: +ParentParent             ; Define GUI as a child of Parent
    Gui, SideBar: +HWNDhSideBar             ; Assign Window Handle to %hSideBar%
    Gui, SideBar: -Caption                  ; Disable Titlebar
    Gui, SideBar: -Border                   ; Disable Border
    Gui, SideBar: -DpiScale                 ; Disable Windows Scaling
    Gui, SideBar: Margin, 0, 0              ; Disable Margin
    Gui, SideBar: Color, %sidebarBG%        ; Set SideBar GUI's Background Color

    ; Define Local Variables
    Local xPos := 0                         ; Define y coordinate for automatically-placed items
    Local wText := 120                      ; Width of Text
    Local wButton := 120                    ; Width of Button
    Local hText := 23                       ; Height of Text
    Local hButton := 23                     ; Height of Button

    ; Define Arrays containing X Positioning for Elements
    Local arrXPos1 := [0, 0, 0, 0]

    ; Define Arrays containing Y Positiong for Elements
    Local arrYPos1 := [0, 1, 2, 3]
    For index, value in arrYPos1 {
        arrYPos1.InsertAt(index, (value * 25))
        arrYPos1.RemoveAt(index + 1)
    }

    ; Add Labels to SideBar GUI
    Gui, SideBar: Add, Text, % "x" arrXPos1[1] " y" arrYPos1[1] " w" wText " h" hText " +0x200 +BackgroundTrans", RESET...
    
    ; Add Controls to SideBar GUI
    Gui, SideBar: Add, Button, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wButton " h" hButton " +gResetAll +AltSubmit", ALL
    Gui, SideBar: Add, Button, % "x" arrXPos1[3] " y" arrYPos1[3] " w" wButton " h" hButton " +gResetGameplay +AltSubmit", GAMEPLAY
    Gui, SideBar: Add, Button, % "x" arrXPos1[4] " y" arrYPos1[4] " w" wButton " h" hButton " +gResetUIColor +AltSubmit", UI COLOR
}

; ##----------------------------##
; #|        Element Form        |#
; ##----------------------------##
GuiElement() {
    Global                                  ; Set Global Scope inside Function
    Gui, ElementForm: +ParentParent         ; Define GUI as a child of Parent
    Gui, ElementForm: +HWNDhElementForm     ; Assign Window Handle to %hElementForm%
    Gui, ElementForm: -Caption              ; Disable Titlebar
    Gui, ElementForm: -Border               ; Disable Border
    Gui, ElementForm: -DpiScale             ; Disable Windows Scaling
    Gui, ElementForm: Margin, 0, 0          ; Disable Margin
    Gui, ElementForm: Color, %formBG%       ; Set Background Color

    ; Define Local Variables
    Local wDDL := 120                       ; Width of DropDownList
    Local wText := 120                      ; Width of Text
    Local wCheck := 120                     ; Width of CheckBox
    Local wButton := 120                    ; Width of Button
    Local hDDL := 23                        ; Height of DropDownList
    Local hText := 23                       ; Height of Text
    Local hCheck := 23                      ; Height of CheckBox
    Local hButton := 23                     ; Height of Button

    ; Define Arrays containing X Positioning for elements
    Local arrXPos1 := [0, 0, 0, 0]
    Local arrXPos2 := []
    For index, value in arrXPos1 {
        arrXPos2.Push(value + wText + 10)
    }

    ; Define Arrays containing Y Positioning for Elements
    Local arrYPos1 := [0, 1, 2, 5]
    For index, value in arrYPos1 {
        arrYPos1.InsertAt(index, (value * 25))
        arrYPos1.RemoveAt(index + 1)
    }

    ; Add Labels to ElementForm GUI
    Gui, ElementForm: Add, Text, % "x" arrXPos1[1] " y" arrYPos1[1] " w" wText " h" hText " +0x200 +BackgroundTrans", ELEMENT:
    Gui, ElementForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vCursorColorText +0x200 +BackgroundTrans", COLOR:
    Gui, ElementForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vHitburstTypeText +0x200 +BackgroundTrans +Hidden1", TYPE:
    Gui, ElementForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vReverseArrowTypeText +0x200 +BackgroundTrans +Hidden1", TYPE:
    Gui, ElementForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vSliderballTypeText +0x200 +BackgroundTrans +Hidden1", TYPE:

    ; Add Controls to ElementForm GUI
    Gui, ElementForm: Add, DropDownList, % "x" arrXPos2[1] " y" arrYPos1[1] " w" wDDL " +gGetElementTypeForm +vElementType +AltSubmit +Sort", Cursor||Hitburst|Reverse Arrow|Sliderball
    Gui, ElementForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vCursorColor +Sort", Cyan|Eclipise|Green|Hot Pink|Orange|Pink|Purple|Red|Turquoise|Yellow||
    Gui, ElementForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vHitburstType +Sort +Hidden1", Numbers|Smaller Bars||
    Gui, ElementForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vReverseArrowType +Sort +Hidden1", Arrow||Half
    Gui, ElementForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vSliderballType +Sort +Hidden1", Double||Single
    Gui, ElementForm: Add, CheckBox, % "x" arrXPos2[3] " y" arrYPos1[3] " w" wCheck " h" hCheck " +vCursorTrail", Cursor Trail
    Gui, ElementForm: Add, Button, % "x" arrXPos2[4] " y" arrYPos1[4] " w" wButton " h" hButton " +gSubmitElementForm", APPLY
}

; ##----------------------------##
; #|        UI Color Form       |#
; ##----------------------------##
GuiUIColor() {
    Global                                  ; Set Global Scope inside Function
    Gui, UIColorForm: +ParentParent         ; Define GUI as a child of Parent
    Gui, UIColorForm: +HWNDhUIColorForm     ; Assign Window Handle to %hUIColorForm%
    Gui, UIColorForm: -Caption              ; Disable Titlebar
    Gui, UIColorForm: -Border               ; Disable Border
    Gui, UIColorForm: -DpiScale             ; Disable Windows Scaling
    Gui, UIColorForm: Margin, 0, 0          ; Disable Margin
    Gui, UIColorForm: Color, %formBG%       ; Set Background Color

    ; Define Local Variables
    Local wText := 120                      ; Width of Text
    Local wDDL := 120                       ; Width of DropDownList
    Local wCheck := 120                     ; Width of CheckBox
    Local wButton := 120                    ; Width of Button
    Local hText := 23                       ; Hieght of Text
    Local hDDL := 23                        ; Height of DropDownList
    Local hCheck := 23                      ; Height of CheckBox
    Local hButton := 23                     ; Height of Button

    ; Define Arrays containing X Positioning for elements
    Local arrXPos1 := [0, 0, 0]
    Local arrXPos2 := []
    For index, value in arrXPos1 {
        arrXPos2.Push(value + wText + 10)
    }

    ; Define Arrays containing Y Positioning for Elements
    Local arrYPos1 := [0, 1, 5]
    For index, value in arrYPos1 {
        arrYPos1.InsertAt(index, (value * 25))
        arrYPos1.RemoveAt(index + 1)
    }

    ; Add Labels to UIColorForm GUI
    Gui, UIColorForm: Add, Text, % "x" arrXPos1[1] " y" arrYPos1[1] " w" wText " h" hText " +0x200 +BackgroundTrans", UI COLOR:
    Gui, UIColorForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +0x200 +BackgroundTrans", CIRCLE OPTION:

    ; Add Controls to UIColorForm GUI
    Gui, UIColorForm: Add, DropDownList, % "x" arrXPos2[1] " y" arrYPos1[1] " w" wText " +vUIColorColor +Sort", Cyan||Dark Gray|Evergreen|Hot Pink|Light Gray|Orange|Red|Yellow
    Gui, UIColorForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vUIColorInstafade", Instafade Circles
    Gui, UIColorForm: Add, Button, % "x" arrXPos2[3] " y" arrYPos1[3] " w" wButton " h" hButton " +gSubmitUIColorForm", APPLY
}

; ##------------------------##
; #|        Player Form     |#
; ##------------------------##
GuiPlayer() {
    Global                                  ; Set Global Scope inside Function
    Gui, PlayerForm: +ParentParent          ; Define GUI as a child of Parent
    Gui, PlayerForm: +HWNDhPlayerForm       ; Assign Window Handle to %hPlayerForm%
    Gui, PlayerForm: -Caption               ; Disable Titlebar
    Gui, PlayerForm: -Border                ; Disable Border
    Gui, PlayerForm: -DpiScale              ; Disable Windows Scaling
    Gui, PlayerForm: Margin, 0, 0           ; Disable Margin
    Gui, PlayerForm: Color, %formBG%        ; Set Background Color

    ; Define Local Variables
    Local wText := 120                      ; Width of Text
    Local wDDL := 120                       ; Width of DropDownList
    Local wCheck := 120                     ; Width of CheckBox
    Local wButton := 120                    ; Width of Button
    Local hText := 23                       ; Height of Text
    Local hDDL := 23                        ; Height of DropDownList
    Local hCheck := 23                      ; Height of CheckBox
    Local hButton := 23                     ; Height of Button

    ; Define Arrays containing X Positioning for elements
    Local arrXPos1 := [0, 0, 0]
    Local arrXPos2 := []
    For index, value in arrXPos1 {
        arrXPos2.Push(value + wText + 10)
    }

    ; Define Arrays containing Y Positioning for Elements
    Local arrYPos1 := [0, 1, 5]
    For index, value in arrYPos1 {
        arrYPos1.InsertAt(index, (value * 25))
        arrYPos1.RemoveAt(index + 1)
    }

    ; Add Labels to PlayerForm GUI
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[1] " y" arrYPos1[1] " w" wText " h" hText " +0x200 +BackgroundTrans", PLAYER:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vAbyssalComboText +0x200 +BackgroundTrans +Hidden1", COMBO COLOR:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vAxariousSliderText +0x200 +BackgroundTrans +Hidden1", SLIDERS:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vAzerVersionText +0x200 +BackgroundTrans +Hidden1", VERSION:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vAzr8SliderText +0x200 +BackgroundTrans +Hidden1", SLIDER:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vBeastrollMCVersionText +0x200 +BackgroundTrans +Hidden1", VERSION:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vBikkoSliderText +0x200 +BackgroundTrans +Hidden1", SLIDER:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vComfortNautzText +0x200 +BackgroundTrans +Hidden1", ALTERNATE:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vCookieziVersionText +0x200 +BackgroundTrans +Hidden1", VERSION:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vDusticeHitCircleText +0x200 +BackgroundTrans +Hidden1", HITCIRCLES:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vIdkeSliderText +0x200 +BackgroundTrans +Hidden1", SLIDER:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vMathiHitcircleText +0x200 +BackgroundTrans +Hidden1", HITCIRCLES:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vRafisVersionText +0x200 +BackgroundTrans +Hidden1", VERSION:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vRohulkApproachCircleText +0x200 +BackgroundTrans +Hidden1", APPROACH CIRCLES:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vRustbell300Text +0x200 +BackgroundTrans +Hidden1", 300s:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vTalalaNumberText +0x200 +BackgroundTrans +Hidden1", NUMBERS:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vVaxeiSliderText +0x200 +BackgroundTrans +Hidden1", SLIDER:
    Gui, PlayerForm: Add, Text, % "x" arrXPos1[2] " y" arrYPos1[2] " w" wText " h" hText " +vXilverCustomText +0x200 +BackgroundTrans +Hidden1", CUSTOM:

    ; Add Controls to PlayerForm GUI
    Gui, PlayerForm: Add, DropDownList, % "x" arrXPos2[1] " y" arrYPos1[1] " w" wDDL " +gGetPlayerOptionForm +vPlayerName +AltSubmit +Sort", 404AimNotFound||Abyssal|Angelsim|Axarious|Azer|azr8 + GayzMcGee|Badeu|BeastrollMC|Bikko|Bubbleman|Comfort|Cookiezi|Doomsday|Dustice|Emilia|FlyingTuna|Freddie Benson|FunOrange|-GN|Hvick225|Idke|Informous|Karthy|Mathi|Monko2K|Rafis|Rohulk|rrtyui|Rustbell|RyuK|Seysant|Sotarks|Sweden|Talala|Toy|Traquil-ity|Varvalian|Vaxei|WubWoofWolf|Xilver x Recia
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vAbyssalCombo +Hidden1", Blue & Red
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vAxariousSlider +Hidden1", Slider Ends
    Gui, PlayerForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vAzerVersion +Sort +Hidden1", 2017||2018
    Gui, PlayerForm: Add, CheckBox, % "x"arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vAzr8Slider +Hidden1", SPLOOSH Slider
    Gui, PlayerForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vBeastrollMCVersion +Sort +Hidden1", 1.3||3|4|5|6
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vBikkoSlider +Hidden1", Slider Ends
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vComfortNautz +Hidden1", Nautz
    Gui, PlayerForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " +vCookieziVersion +Sort +Hidden1", Burakku Shipu||nathan on osu|Panimi|Seoul|Shigetora
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vDusticeHitCircle +Hidden1", Outer Circle
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vIdkeSlider +Hidden1", Slider Ends
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vMathiHitcircle +Hidden1", Shadered Hitcircle
    Gui, PlayerForm: Add, DropDownList, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wDDL " h" hDDL " +vRafisVersion +Sort +Hidden1", Blue||White
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vRohulkApproachCircle +Hidden1", Gamma Approach Circle
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vRustbell300 +Hidden1", Include 300s
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vTalalaNumber +Hidden1", Cyan Numbers
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vVaxeiSlider +Hidden1", Red Slider Border
    Gui, PlayerForm: Add, CheckBox, % "x" arrXPos2[2] " y" arrYPos1[2] " w" wCheck " h" hCheck " +vXilverCustom +Hidden1", Xilver x SPLOOSH
    Gui, PlayerForm: Add, Button, % "x" arrXPos2[3] " y" arrYPos1[3] " w" wButton " h" hButton " +gSubmitPlayerForm", APPLY
}

; ##----------------------------##
; #|        Functions: GUI      |#
; ##----------------------------##
; Instantiate GUIs
GuiConstructor() {
    Global                                  ; Set Global Scope inside Function
    GuiParent()                             ; Instantiate Parent GUI
    GuiTopBar()                             ; Instantiate TopBar GUI
    GuiSideBar()                            ; Instantiate SideBar GUI
    GuiElement()                            ; Instantiate ELementForm GUI
    GuiUIColor()                            ; Instantiate UIColorForm GUI
    GuiPlayer()                             ; Instantiate PlayerForm GUI
}

; Initialize GUI
GuiInitialize() {
    Global                                  ; Set Global Scope inside Function

    ; Add GUIs to Parent
    Gui, TopBar: Show, % "x" topbarX " y" topbarY " w" topbarW " h" topbarH
    Gui, SideBar: Show, % "x" sidebarX " y" sidebarY " w" sidebarW " h" sidebarH
    Gui, ElementForm: Show, % "x" formX " y" formY " w" formW " h" formH
    Gui, UIColorForm: Show, % "x" formX " y" formY " w" formW " h" formH " Hide"
    Gui, PlayerForm: Show, % "x" formX " y" formY " w" formW " h" formH " Hide"
}

; Toggle Form Shown -- Args; $1: Partial Form Name to Update; $2: Visible (T/F | 1/0 -- Default: 0)
ToggleForm(name, vis := 0) {
    If (name = "ALL") {
        Gui, ElementForm: Show, Hide
        Gui, UIColorForm: Show, Hide
        Gui, PlayerForm: Show, Hide
        return
    }
    If (vis = 1) {
        Gui, %name%Form: Show
        return
    }
    Gui, %name%Form: Show, Hide
}

; Toggle Element Form -- Args $1: Name of Element, $2: Visibility (Def: 0)
ToggleElementMenu(name, vis := 0) {
    Local visCmd := "Hide"                  ; Visibility Command to use

    ; Update visCmd to "SHOW" if visibility enabled
    If (vis = 1) {
        visCmd := "Show"
    }

    ; Update Visibility of ELementForm Options
    If (name = "Cursor") {
        GuiControl, %visCmd%, CursorColorText
        GuiControl, %visCmd%, CursorColor
        GuiControl, %visCmd%, CursorTrail
    } Else If (name = "Hitburst") {
        GuiControl, %visCmd%, HitburstTypeText
        GuiControl, %visCmd%, HitburstType
    } Else If (name = "ReverseArrow") {
        GuiControl, %visCmd%, ReverseArrowTypeText
        GuiControl, %visCmd%, ReverseArrowType
    } Else If (name = "Sliderball") {
        GuiControl, %visCmd%, SliderballTypeText
        GuiControl, %visCmd%, SliderballType
    } Else If (name = "ALL") {
        GuiControl, Hide, CursorColorText
        GuiControl, Hide, CursorColor
        GuiControl, Hide, CursorTrail
        GuiControl, Hide, HitburstTypeText
        GuiControl, Hide, HitburstType
        GuiControl, Hide, ReverseArrowTypeText
        GuiControl, Hide, ReverseArrowType
        GuiControl, Hide, SliderballTypeText
        GuiControl, Hide, SliderballType
    }
}

; Toggle Player Form -- Args $1: Name of Player, $2: Visibility (Def: 0)
TogglePlayerMenu(name, vis := 0) {
    Local visCmd := "Hide"                  ; Visibility Command to use

    ; Update visCmd to "SHOW" if visibility enabled
    If (vis = 1) {
        visCmd := "Show"
    }

    ; Update Visibility of PlayerForm Options
    If (name = "Abyssal") {
        GuiControl, %visCmd%, AbyssalComboText
        GuiControl, %visCmd%, AbyssalCombo
    } Else If (name = "Axarious") {
        GuiControl, %visCmd%, AxariousSliderText
        GuiControl, %visCmd%, AxariousSlider
    } Else If (name = "Azer") {
        GuiControl, %visCmd%, AzerVersionText
        GuiControl, %visCmd%, AzerVersion
    } Else If (name = "Azr8") {
        GuiControl, %visCmd%, Azr8SliderText
        GuiControl, %visCmd%, Azr8Slider
    } Else If (name = "BeastrollMC") {
        GuiControl, %visCmd%, BeastrollMCVersionText
        GuiControl, %visCmd%, BeastrollMCVersion
    } Else If (name = "Bikko") {
        GuiControl, %visCmd%, BikkoSliderText
        GuiControl, %visCmd%, BikkoSlider
    } Else If (name = "Comfort") {
        GuiControl, %visCmd%, ComfortNautzText
        GuiControl, %visCmd%, ComfortNautz
    } Else If (name = "Cookiezi") {
        GuiControl, %visCmd%, CookieziVersionText
        GuiControl, %visCmd%, CookieziVersion
    } Else If (name = "Dustice") {
        GuiControl, %visCmd%, DusticeHitCircleText
        GuiControl, %visCmd%, DusticeHitCircle
    } Else If (name = "Idke") {
        GuiControl, %visCmd%, IdkeSliderText
        GuiControl, %visCmd%, IdkeSlider
    } Else If (name = "Mathi") {
        GuiControl, %visCmd%, MathiHitcircleText
        GuiControl, %visCmd%, MathiHitcircle
    } Else If (name = "Rafis") {
        GuiControl, %visCmd%, RafisVersionText
        GuiControl, %visCmd%, RafisVersion
    } Else If (name = "Rohulk") {
        GuiControl, %visCmd%, RohulkApproachCircleText
        GuiControl, %visCmd%, RohulkApproachCircle
    } Else If (name = "Rustbell") {
        GuiControl, %visCmd%, Rustbell300Text
        GuiControl, %visCmd%, Rustbell300
    } Else If (name = "Talala") {
        GuiControl, %visCmd%, TalalaNumberText
        GuiControl, %visCmd%, TalalaNumber
    } Else If (name = "Vaxei") {
        GuiControl, %visCmd%, VaxeiSliderText
        GuiControl, %visCmd%, VaxeiSlider
    } Else If (name = "Xilver") {
        GuiControl, %visCmd%, XilverCustomText
        GuiControl, %visCmd%, XilverCustom
    } Else If (name = "ALL") {
        GuiControl, Hide, AbyssalComboText
        GuiControl, Hide, AbyssalCombo
        GuiControl, Hide, AxariousSliderText
        GuiControl, Hide, AxariousSlider
        GuiControl, Hide, AzerVersionText
        GuiControl, Hide, AzerVersion
        GuiControl, Hide, Azr8SliderText
        GuiControl, Hide, Azr8Slider
        GuiControl, Hide, BeastrollMCVersionText
        GuiControl, Hide, BeastrollMCVersion
        GuiControl, Hide, BikkoSliderText
        GuiControl, Hide, BikkoSlider
        GuiControl, Hide, ComfortNautzText
        GuiControl, Hide, ComfortNautz
        GuiControl, Hide, CookieziVersionText
        GuiControl, Hide, CookieziVersion
        GuiControl, Hide, DusticeHitCircleText
        GuiControl, Hide, DusticeHitCircle
        GuiControl, Hide, IdkeSliderText
        GuiControl, Hide, IdkeSlider
        GuiControl, Hide, MathiHitcircleText
        GuiControl, Hide, MathiHitcircle
        GuiControl, Hide, RafisVersionText
        GuiControl, Hide, RafisVersion
        GuiControl, Hide, RohulkApproachCircleText
        GuiControl, Hide, RohulkApproachCircle
        GuiControl, Hide, Rustbell300Text
        GuiControl, Hide, Rustbell300
        GuiControl, Hide, TalalaNumberText
        GuiControl, Hide, TalalaNumber
        GuiControl, Hide, VaxeiSliderText
        GuiControl, Hide, VaxeiSlider
        GuiControl, Hide, XilverCustomText
        GuiControl, Hide, XilverCustom
    }
}

; ##------------------------------------##
; #|        G-Labels/G-Functions        |#
; ##------------------------------------##
; Get Form: Player
GetPlayerForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    ;MsgBox,,Player, Player Form Selected    ; Temporary G-Function Result
    ToggleForm("ALL")                       ; Disable all forms
    ToggleForm("Player", 1)                 ; Enable PlayerForm
}

; Get Form: UI Color
GetUIColorForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    ;MsgBox,,UI Color, UIColor Form Selected ; Temporary G-Function Result
    ToggleForm("ALL")                       ; Disable all forms
    ToggleForm("UIColor", 1)                ; Enable UIColorForm
}

; Get Form: Element
GetElementForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    ;MsgBox,,Element, Element Form Selected  ; Temporary G-Function Result
    ToggleForm("ALL")                       ; Disable all forms
    ToggleForm("Element", 1)                ; Enable ElementForm
}

; Reset All Elements
ResetAll(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    If (ResetSkin("Gameplay") = 0 && ResetSkin("UIColor") = 0) {
        ; Notify User
        TrayTip, SPLOOSH Selector, All Elements Reset, 5, 0
    }
}

; Reset Gameplay Elements
ResetGameplay(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    If (ResetSkin("Gameplay") = 0) {
        ; Notify User
        TrayTip, SPLOOSH Selector, Gameplay Elements Reset, 5, 0
    }
}

; Reset UI Color Elements
ResetUIColor(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Set Global Scope inside Function
    Gui, Submit, NoHide                     ; Allow Temporary Form Submission, but do not close win
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    If (ResetSkin("UIColor") = 0) {
        ; Notify User
        TrayTip, SPLOOSH Selector, UI Color Elements Reset, 5, 0
    }
}

; Get Element Type Options
GetElementTypeForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global
    Gui, Submit, NoHide
    ToggleElementMenu("ALL")                ; Hide All Element Menu Options
    If (ElementType = 1) {
        ToggleElementMenu("Cursor", 1)      ; Show Cursor Options
    } Else If (ElementType = 2) {
        ToggleElementMenu("Hitburst", 1)    ; Show Hitburst Options
    } Else If (ElementType = 3) {
        ToggleElementMenu("ReverseArrow", 1)    ; Show ReverseArrow Options
    } Else If (ElementType = 4) {
        ToggleELementMenu("Sliderball", 1)  ; Show Sliderball Options
    }
}

; Get Player Options
GetPlayerOptionForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global
    Gui, Submit, NoHide
    TogglePlayerMenu("ALL")                 ; Hide All Player Menu Options
    If (PlayerName = 2) {
        TogglePlayerMenu("Abyssal", 1)      ; Show Abyssal Options
    } Else If (PlayerName = 4) {
        TogglePlayerMenu("Axarious", 1)     ; Show Axarious Options
    } Else If (PlayerName = 5) {
        TogglePlayerMenu("Azer", 1)         ; Show Azer Options
    } Else If (PlayerName = 6) {
        TogglePlayerMenu("Azr8", 1)        ; Show azr8 Options
    } Else If (PlayerName = 8) {
        TogglePlayerMenu("BeastrollMC", 1)  ; Show BeastrollMC Options
    } Else If (PlayerName = 9) {
        TogglePlayerMenu("Bikko", 1)        ; Show Bikko Options
    } Else If (PlayerName = 11) {
        TogglePlayerMenu("Comfort", 1)      ; Show Comfort Options
    } Else If (PlayerName = 12) {
        TogglePlayerMenu("Cookiezi", 1)     ; Show Cookiezi Options
    } Else If (PlayerName = 14) {
        TogglePlayerMenu("Dustice", 1)      ; Show Dustice Options
    } Else If (PlayerName = 21) {
        TogglePlayerMenu("Idke", 1)         ; Show Idke Options
    } Else If (PlayerName = 24) {
        TogglePlayerMenu("Mathi", 1)        ; Show Mathi Options
    } Else If (PlayerName = 26) {
        TogglePlayerMenu("Rafis", 1)        ; Show Rafis Options
    } Else If (PlayerName = 27) {
        TogglePlayerMenu("Rohulk", 1)       ; Show Rohulk Options
    } Else If (PlayerName = 29) {
        TogglePlayerMenu("Rustbell", 1)     ; Show Rustbell Options
    } Else If (PlayerName = 34) {
        TogglePlayerMenu("Talala", 1)       ; Show Talala Options
    } Else If (PlayerName = 38) {
        TogglePlayerMenu("Vaxei", 1)        ; Show Vaxei Options
    } Else If (PlayerName = 40) {
        TogglePlayerMenu("Xilver", 1)       ; Show Xilver Options
    }
}

; Submit Element Form
SubmitElementForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Assumbe Function-Scope is Global
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    Gui, ElementForm: Submit, NoHide        ; Submit ElementForm
    If (UpdateSkinElement() = 0) {
        ; Notify User
        local etype := ElementType
        If (etype = 1) {
            etype := "Cursor"
        } Else If (etype = 2) {
            etype := "Hitburst"
        } Else If (etype = 3) {
            etype := "Reverse Arrow"
        } Else If (etype = 4) {
            etype := "Sliderball"
        } Else {
            etype := "ERROR"
        }
        TrayTip, SPLOOSH Selector, %etype% Updated, 5, 0
    }
}

; Submit UI Color Form
SubmitUIColorForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Assumbe Function-Scope is Global
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    Gui, UIColorForm: Submit, NoHide        ; Submit UIColorForm
    If (UpdateSkinUIColor() = 0) {
        ; Notify User
        TrayTip, SPLOOSH Selector, UI Color Updated, 5, 0
    }
}

; Submit Player Form
SubmitPlayerForm(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Global                                  ; Assumbe Function-Scope is Global
    Gui, TopBar: Submit, NoHide             ; Submit TopBar Form
    Gui, PlayerForm: Submit, NoHide         ; Submit PlayerForm
    If (UpdateSkinPlayer() = 0) {
        ; Notify User
        TrayTip, SPLOOSH Selector, Player Updated, 5, 0
    }
}

; Browse Directory
BrowseGameDirectory(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; Output Var: GameDirectory
    Global                                  ; Assume Function-Scope is Global
    Gui, TopBar: Submit, NoHide             ; Submit Current Form, but do not hide window
    
    ; Define Local Variables
    Local pathDir := ""                     ; Directory to return

    ; Provide a file browser to select the game path
    Try {
        FileSelectFolder, pathDir, %defGamePath%, 0, Select Game Path
    } Catch e {
        MsgBox,,, An Exception was thrown!`nSpecifically: %e%
        return
    }

    ; If No Files Selected
    If (pathDir = "") {
        return
    }

    ; Update Control
    GuiControl, TopBar:, GameDirectory, %pathDir%
}

; ##--------------------------------##
; #|        Backend Functions       |#
; ##--------------------------------##
; Update Skin: Elements
UpdateSkinElement() {
    Global                                  ; Assume Function-Scope is Global

    ; Define Local Variables
    Local src := GameDirectory "\Skins"     ; Source directory is vGameDirectory
    Local dst := GameDirectory "\Skins"     ; Destination directory is vGameDirectory
    Local skin := defSplooshName            ; Skin Name is default SPLOOSH name
    Local opt1 := ""                        ; Option 1

    ; If %skin% is not the actual name of skin:
    If (FileExist(src "\" skin) = "") {
        ; Loop over directories in Skins directory
        Loop, Files, %src%\*, D 
        {
            ; If current directory matches '/SPLOOSH/i', update %skin% and break loop
            If (InStr(A_LoopFileName, "SPLOOSH") <> 0) {
                skin := A_LoopFileName
                break
            }
        }

        ; If %skin% is still not found, notify and break
        If (FileExist(src "\" skin) = "") {
            MsgBox,,, Cannot Locate Skin Directory: %src%\%skin%
            return 1
        }
    }

    ; Update Source and Destination Paths
    src := src "\" skin "\ASSET PACKS\ELEMENT PACKS"
    dst := dst "\" skin

    ; Update Skin based on ElementForm Options
    If (ElementType = 1 || ElementType = "Cursor") {
        ; Update Variables
        src := src "\CURSORS"
        StringUpper, opt1, CursorColor

        ; If opt1 is YELLOW, add " (ORIGINAL)", which is part of the directory name
        If (opt1 = "YELLOW") {
            opt1 := opt1 " (ORIGINAL)"
        }
    } Else If (ElementType = 2 || ElementType = "Hitburst") {
        ; Update Variables
        src := src "\HITBURSTS"
        StringUpper, opt1, HitburstType
    } Else If (ElementType = 3 || ElementType = "Reverse Arrow") {
        ; Update Variables
        src := src "\REVERSEARROWS"
        StringUpper, opt1, ReverseArrowType
    } Else If (ElementType = 4 || ElementType = "Sliderball") {
        ; Update Variables
        src := src "\SLIDERBALLS"
        StringUpper, opt1, SliderballType
    } Else {
        MsgBox,,SPLOOSH Selector: Error, Element Type Invalid: %ElementType%`n`nValid Options:`nCursor (1)`nHitburst (2)`nReverse Arrow (3)`nSliderball (4)
        return 1
    }

    ; Copy Files from Element Option Directory to Skin Path
    FileCopy, %src%\%opt1%\*.png, %dst%, 1

    ; If Element Type is Cursor (1) && CursorTrail is *DISABLED*, replace cursor trail with empty PNG
    If ((ElementType = 1 || ElementType = "Cursor") && CursorTrail = 0) {
        FileCopy, %src%\!NO CURSOR TRAIL\*.png, %dst%, 1
    }

    ; Return Success
    return 0
}

; Update Skin: UI Color
UpdateSkinUIColor() {
    Global                                  ; Assume Function-Scope is Global

    ; Define Local Variables
    Local src := GameDirectory "\Skins"     ; Source directory is vGameDirectory
    Local dst := GameDirectory "\Skins"     ; Destination directory is vGameDirectory
    Local skin := defSplooshName            ; Skin Name is default SPLOOSH name
    Local opt1 := ""                        ; Option 1

    ; If %skin% is not the actual name of skin:
    If (FileExist(src "\" skin) = "") {
        ; Loop over directories in Skins directory
        Loop, Files, %src%\*, D 
        {
            ; If current directory matches '/SPLOOSH/i', update %skin% and break loop
            If (InStr(A_LoopFileName, "SPLOOSH") <> 0) {
                skin := A_LoopFileName
                break
            }
        }

        ; If %skin% is still not found, notify and break
        If (FileExist(src "\" skin) = "") {
            MsgBox,,, Cannot Locate Skin Directory: %src%\%skin%
            return 1
        }
    }

    ; Update Source and Destination Paths
    src := src "\" skin "\ASSET PACKS\UI COLORS"
    dst := dst "\" skin

    ; Set %opt1% to the uppercase of UIColorColor
    StringUpper, opt1, UIColorColor

    ; Update Skin based on ElementForm Options
    ; If Option is an empty string, 
    If (opt1 = "") {
        MsgBox,,SPLOOSH Selector: Error, Invalid UI Color Selected: %UIColorColor%
        return 1
    }

    ; Copy Files from UI Color Option Directory to Skin Path
    FileCopy, %src%\%opt1%\*.png, %dst%, 1

    ; If Instafade Circles enabled, copy Instafade Skin.ini to Skin Path
    If (UIColorInstafade = 1) {
        FileCopy, %src%\%opt1%\SKIN.INI FOR INSTAFADE HITCIRCLE\*.ini, %dst%, 1
    }

    return 0
}

; Update Skin: Player
UpdateSkinPlayer() {
    Global                                  ; Assume Function-Scope is Global

    ; Define Local Variables
    Local src := GameDirectory "\Skins"     ; Source directory is vGameDirectory
    Local dst := GameDirectory "\Skins"     ; Destination directory is vGameDirectory
    Local skin := defSplooshName            ; Skin Name is default SPLOOSH name
    Local opt1 := ""                        ; Option 1
    Local player := ""                      ; Player Name

    ; If %skin% is not the actual name of skin:
    If (FileExist(src "\" skin) = "") {
        ; Loop over directories in Skins directory
        Loop, Files, %src%\*, D 
        {
            ; If current directory matches '/SPLOOSH/i', update %skin% and break loop
            If (InStr(A_LoopFileName, "SPLOOSH") <> 0) {
                skin := A_LoopFileName
                break
            }
        }

        ; If %skin% is still not found, notify and break
        If (FileExist(src "\" skin) = "") {
            MsgBox,,, Cannot Locate Skin Directory: %src%\%skin%
            return 1
        }
    }

    ; Update Source and Destination Paths
    src := src "\" skin "\ASSET PACKS\PLAYER PACKS"
    dst := dst "\" skin
    
    ; Update Skin based on PlayerForm Options
    If (PlayerName = 1 || PlayerName = "404AimNotFound") {
        player := "404AimNotFound"
        src := src "\404ANF"
    } Else If (PlayerName = 2 || PlayerName = "Abyssal") {
        player := "Abyssal"
        src := src "\ABYSSAL"
        If (AbyssalCombo = 1) {
            opt1 := "BLUE+RED COMBO VER"
        }
    } Else If (PlayerName = 3 || PlayerName = "Angelsim") {
        player := "Angelsim"
        src := src "\ANGELSIM"
    } Else If (PlayerName = 4 || PlayerName = "Axarious") {
        player := "Axarious"
        src := src "\AXARIOUS"
        If (AxariousSlider = 1) {
            opt1 := "+SLIDERENDS"
        }
    } Else If (PlayerName = 5 || PlayerName = "Azer") {
        player := "Azer"
        src := src "\AZER X2"
        If (AzerVersion = 1 || AzerVersion = 2017) {
            opt1 := "2017"
        } ELse If (AzerVersion = 2 || AzerVersion = 2018) {
            opt1 := "2018"
        } Else {
            MsgBox,, SPLOOSH Selector: Error, Invalid Azer Version: %AzerVersion%
            return 1
        }
    } Else If (PlayerName = 6 || PlayerName = "azr8 + GayzMcGee") {
        player := "azr8 + GayzMcGee"
        src := src "\AZR8 + MCGEE"
        If (Azr8Slider = 1) {
            opt1 := "SPLOOSH SLIDER"
        }
    } Else If (PlayerName = 7 || PlayerName = "Badeu") {
        player := "Badeu"
        src := src "\BADEU"
    } Else If (PlayerName = 8 || PlayerName = "BeastrollMC") {
        player := "BeastrollMC"
        src := src "\BEASTROLLMC X5"
        If (BeastrollMCVersion = 1 || BeastrollMCVersion = "1.3") {
            opt1 := "V1.3"
        } Else If (BeastrollMCVersion = 2 || BeastrollMCVersion = "3") {
            opt1 := "V3"
        } Else If (BeastrollMCVersion = 3 || BeastrollMCVersion = "4") {
            opt1 := "V4"
        } Else If (BeastrollMCVersion = 4 || BeastrollMCVersion = "5") {
            opt1 := "V5"
        } Else If (BeastrollMCVersion = 5 || BeastrollMCVersion = "6") {
            opt1 := "V6"
        } Else {
            MsgBox,, SPLOOSH Selector: Error, Invalid BeastrollMC Version: %BeastrollMCVersion%
            return 1
        }
    } Else If (PlayerName = 9 || PlayerName = "Bikko") {
        player := "Bikko"
        src := src "\BIKKO"
        If (BikkoSlider = 1) {
            opt1 := "+SLIDERENDS"
        }
    } Else If (PlayerName = 10 || PlayerName = "Bubbleman") {
        player := "Bubbleman"
        src := src "\BUBBLEMAN"
    } Else If (PlayerName = 11 || PlayerName = "Comfort") {
        player := "Comfort"
        src := src "\COMFORT"
        If (ComfortNautz = 1) {
            opt1 := "NAUTZ VERSION"
        }
    } Else If (PlayerName = 12 || PlayerName = "Cookiezi") {
        player := "Cookiezi"
        src := src "\COOKIEZI X5"
        ;Burakku Shipu||nathan on osu|Panimi|Seoul|Shigetora
        If (CookieziVersion = 1 || CookieziVersion = "Burakku Shipu") {
        player := "NAME"
            opt1 := "BURAKKU SHIPU"
        } Else If (CookieziVersion = 2 || CookieziVersion = "nathan on osu") {
            opt1 := "NATHAN ON OSU"
        } Else If (CookieziVersion = 3 || CookieziVersion = "Panimi") {
            opt1 := "PANIMI"
        } Else If (CookieziVersion = 4 || CookieziVersion = "Seoul") {
            opt1 := "SEOUL"
        } Else If (CookieziVersion = 5 || CookieziVersion = "Shigetora") {
            opt1 := "SHIGETORA"
        } Else {
            MsgBox,, SPLOOSH Selector: Error, Invalid Cookiezi Verison: %CookieziVersion%
            return 1
        }
    } Else If (PlayerName = 13 || PlayerName = "Doomsday") {
        player := "Doomsday"
        src := src "\DOOMSDAY"
    } Else If (PlayerName = 14 || PlayerName = "Dustice") {
        player := "Dustice"
        src := src "\DUSTICE"
        If (DusticeHitCircle = 1) {
            opt1 := "NO OUTER CIRCLE"
        }
    } Else If (PlayerName = 15 || PlayerName = "Emilia") {
        player := "Emilia"
        src := src "\EMILIA"
    } Else If (PlayerName = 16 || PlayerName = "FlyingTuna") {
        player := "FlyingTuna"
        src := src "\FLYINGTUNA"
    } Else If (PlayerName = 17 || PlayerName = "Freddie Benson") {
        player := "Freddie"
        src := src "\FREDDIE BENSON"
    } Else If (PlayerName = 18 || PlayerName = "FunOrange") {
        player := "FunOrange"
        src := src "\FUNORANGE"
    } Else If (PlayerName = 19 || PlayerName = "-GN") {
        player := "-"
        src := src "\GN"
    } Else If (PlayerName = 20 || PlayerName = "Hvick225") {
        player := "Hvick225"
        src := src "\HVICK225"
    } Else If (PlayerName = 21 || PlayerName = "Idke") {
        player := "Idke"
        src := src "\IDKE"
        If (IdkeSlider = 1) {
            opt1 := "+SLIDERENDS"
        }
    } Else If (PlayerName = 22 || PlayerName = "Informous") {
        player := "Informous"
        src := src "\INFORMOUS"
    } Else If (PlayerName = 23 || PlayerName = "Karthy") {
        player := "Karthy"
        src := src "\KARTHY"
    } Else If (PlayerName = 24 || PlayerName = "Mathi") {
        player := "Mathi"
        src := src "\MATHI"
        If (MathiHitcircle = 1) {
            opt1 := "SHADERED HITCIRCLE"
        }
    } Else If (PlayerName = 25 || PlayerName = "Monko2K") {
        player := "Monko2K"
        src := src "\MONKO2K"
    } Else If (PlayerName = 26 || PlayerName = "Rafis") {
        player := "Rafis"
        src := src "\RAFIS X2"
        If (RafisVersion = 1 || RafisVersion = "Blue") {
        player := "NAME"
            opt1 := "BLUE"
        } Else If (RafisVersion = 2 || RafisVersion = "White") {
            opt1 := "WHITE"
        }
    } Else If (PlayerName = 27 || PlayerName = "Rohulk") {
        player := "Rohulk"
        src := src "\ROHULK"
        If (RohulkApproachCircle = 1) {
            opt1 := "GAMMA ACIRCLE"
        }
    } Else If (PlayerName = 28 || PlayerName = "rrtyui") {
        player := "rrtyui"
        src := src "\RRTYUI"
    } Else If (PlayerName = 29 || PlayerName = "Rustbell") {
        player := "Rustbell"
        src := src "\RUSTBELL"
        If (Rustbell300 = 1) {
            opt1 := "HIT300 EXPLOSIONS"
        }
    } Else If (PlayerName = 30 || PlayerName = "RyuK") {
        player := "RyuK"
        src := src "\RYUK"
    } Else If (PlayerName = 31 || PlayerName = "Seysant") {
        player := "Seysant"
        src := src "\SEYSANT"
    } Else If (PlayerName = 32 || PlayerName = "Sotarks") {
        player := "Sotarks"
        src := src "\SOTARKS"
    } ELse If (PlayerName = 33 || PlayerName = "Sweden") {
        player := "Sweden"
        src := src "\SWEDEN"
    } Else If (PlayerName = 34 || PlayerName = "Talala") {
        player := "Talala"
        src := src "\TALALA"
        If (TalalaNumber = 1) {
            opt1 := "CYAN NUMBERS"
        }
    } Else If (PlayerName = 35 || PlayerName = "Toy") {
        player := "Toy"
        src := src "\TOY"
    } Else If (PlayerName = 36 || PlayerName = "Tranquil-ity") {
        player := "Tranquil-ity"
        src := src "\TRANQUIL-ITY"
    } Else If (PlayerName = 37 || PlayerName = "Varvalian") {
        player := "Varvalian"
        src := src "\VARVALIAN"
    } Else If (PlayerName = 38 || PlayerName = "Vaxei") {
        player := "Vaxei"
        src := src "\VAXEI"
        If (VaxeiSlider = 1) {
            opt1 := "RED SLIDERBORDER"
        }
    } Else If (PlayerName = 39 || PlayerName = "WubWoofWolf") {
        player := "WubWoofWolf"
        src := src "\WWW"
    } Else If (PlayerName = 40 || PlayerName = "Xilver x Recia") {
        player := "Xilver x Recia"
        src := src "\XILVER X RECIA"
        If (XilverCustom = 1) {
            opt1 := "XILVER X SPLOOSH"
        }
    } Else {
        MsgBox,, SPLOOSH Selector: Error, Invalid Player Selection: %PlayerName%
        return 1
    }

    ; Reset Skin Elements to prevent unintentional mixing
    ResetSkin("Gameplay")
    ResetSkin("UIColor")
    ; Determine how to copy files to skin path
    If (player = "Azer" || player = "BeastrollMC" || player = "Cookiezi" || player = "Rafis") {
        ; Copy Player's Skin Version to Destination
        FileCopy, %src%\%opt1%\*.*, %dst%, 1

        ; If player is Cookiezi and Version is Shigetora, remove CursorMiddle from Destination
        If (player = "Cookiezi" && opt1 = "SHIGETORA") {
            FileDelete, %dst%\cursormiddle@2x.png
        }
    } Else {
        ; Copy Files in Source to Skin Path
        FileCopy, %src%\*.*, %dst%, 1

        ; If Option Set, Update Destination
        If (opt1 <> "") {
            FileCopy, %src%\%opt1%\*.*, %dst%, 1
        }
    }
    return 0
}

; Reset Skin -- Args: $1: Section to Reset
ResetSkin(name := "") {
    Global                                  ; Assume Function-Scope is Global
    
    ; Return immediately if no argument passed
    If (name = "") {
        return 1
    }

    ; Define Local Variables
    Local src := GameDirectory "\Skins"                 ; Source directory is vGameDirectory
    Local dst := GameDirectory "\Skins"                 ; Destination directory is vGameDirectory
    Local skin := defSplooshName                        ; Skin Name is default SPLOOSH name
    Local cPath := "!RESET (ORIGINAL UI COLOR)"         ; Directory name containing original UI Color elements
    Local gPath := "!RESET (ORIGINAL GAMEPLAY ASSETS)"  ; Directory name containing original Gameplay elements

    ; If %skin% is not the actual name of skin:
    If (FileExist(src "\" skin) = "") {
        ; Loop over directories in Skins directory
        Loop, Files, %src%\*, D 
        {
            ; If current directory matches '/SPLOOSH/i', update %skin% and break loop
            If (InStr(A_LoopFileName, "SPLOOSH") <> 0) {
                skin := A_LoopFileName
                break
            }
        }

        ; If %skin% is still not found, notify and break
        If (FileExist(src "\" skin) = "") {
            MsgBox,,, Cannot Locate Skin Directory: %src%\%skin%
            return 1
        }
    }

    ; Update Source and Destination Paths
    src := src "\" skin "\ASSET PACKS"
    dst := dst "\" skin

    ; Reset Based on passed section name
    If (name = "Gameplay") {
        FileCopy, %src%\%gPath%\*.*, %dst%, 1
    } Else If (name = "UIColor") {
        FileCopy, %src%\%cPath%\*.*, %dst%, 1
    } Else {
        MsgBox,,SPLOOSH Selector: Error, Invalid Reset Option: %name%
        return 1
    }

    return 0
}

; ##----------------------------##
; #|        Event Listeners     |#
; ##----------------------------##
; Parent GUI Escaped
ParentGuiEscape(GuiHwnd) {
    ExitApp
}

; Parent GUI Closed
ParentGuiClose(GuiHwnd) {
    ExitApp
}

; Left Mouse-Button UP
OnWM_LBUTTONUP(wParam, lParam, msg, hwnd) {

}

; ##----------------##
; #|        Run     |#
; ##----------------##
; GUI Initialization
GuiConstructor()                            ; Instantiate GUIs
GuiInitialize()                             ; Initialize GUIs
Gui, Parent: Show, % "w" parentW " h" parentH, SPLOOSH Simple

; ##--------------------------------##
; #|        OnMessage Handlers      |#
; ##--------------------------------##
; On Message 0x202
OnMessage(0x202, "OnWM_LBUTTONUP")
Return