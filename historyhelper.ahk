#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, MainGUI:Add, ComboBox, r11 x168 y296 w135 h21 vSearchEncounterNumber gAutoComplete, %RecentlySearched%
Gui, MainGUI:Add, Button, gSearchEncounter_Button Default x310 y295 w63 h22, Encounter
Gui, MainGUI:Show, w452 h326

;-------------------------------------------------------------------------------------
;Label
;-------------------------------------------------------------------------------------
AutoComplete:
Gui, MainGUI:Submit, NoHide
;msgbox, %SearchEncounterNumber%
if (SearchEncounterNumber = "Clear Search History")
    {
        ClearSearchHistory(UserCore_ini)
        goto, MainGUI
    }
else
    AutoComplete(A_GuiControl)
Return 

SearchEncounter_Button:
Gui, MainGUI:Submit

if SearchEncounterNumber is not number
    {
        msgbox,,Invalid Encounter, You can only search for account numbers!
        goto, MainGUI
    }

;msgbox, %SearchEncounterNumber%
if (SearchEncounterNumber = "")
    {
        ;msgbox,4096, Missing Account Number, Account Number Can NOT be Blank!
        Gui, 2:-border
        Gui, 2:+AlwaysOnTop
        Gui, 2:Font, s12 Bold Underline cRed
        Gui, 2:Add, Text, x0 y0 w292 h44 Center +0x200, Account Number Can NOT be Blank!
        Gui, 2:Font

        Gui, 2:Show, w292 h44, Window
        SetTimer TimeOut, 1000
        Return
        ;Gui, show

        TimeOut:
        Gui, 2:Cancel
        Gui, 2:Destroy
        Gui, Show
        SetTimer TimeOut, Off
        Return
    }
if (SearchEncounterNumber != "")
    {
        Gui, Submit
        Gui, Destroy

        ;Add encoutner to the recents dropdown varible
        UpdateRecentSearch(UserCore_ini,SearchEncounterNumber)

        StringReplace, SearchEncounterNumberNoSpaces, SearchEncounterNumber, %A_Space%,, All
        SearchEncounterNumber = %SearchEncounterNumberNoSpaces%
        goto, SearchEncounter_Button_run
    }
return

;-------------------------------------------------------------------------------------
;Functions
;-------------------------------------------------------------------------------------
AutoComplete(ctrl) { 
   static lf = "`n" 
   If GetKeyState("Delete") or GetKeyState("Backspace") 
      Return 
   SetControlDelay, -1 
   SetWinDelay, -1 
   GuiControlGet, h, Hwnd, %ctrl% 
   ControlGet, haystack, List, , , ahk_id %h% 
   GuiControlGet, needle, , %ctrl% 
   StringMid, text, haystack, pos := InStr(lf . haystack, lf . needle) 
      , InStr(haystack . lf, lf, false, pos) - pos 
   If text !=
   {
      if pos != 0
      { 
         ControlSetText, , %text%, ahk_id %h% 
         ControlSend, , % "{Right " . StrLen(needle) . "}+^{End}", ahk_id %h% 
      } 
   }
} 

LoadRecentSearch(UserCore_ini)
    {
        IniRead, RecentlySearched, %UserCore_ini%, RecentlySearched, RecentlySearched

        Loop, % vRecent := (oRecent := StrSplit(RecentlySearched, "|")).Length()
        vRecent%A_Index% := oRecent[A_Index]    

        ;MsgBox, % vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9 

        If (vRecent1 = "")
            NewRecents := ""
        Else
            NewRecents := vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9 "|" vRecent10 "|" "Clear Search History"
        ;msgbox, %NewRecents%

        RecentlySearched := NewRecents
        return RecentlySearched
    }

UpdateRecentSearch(UserCore_ini,SearchEncounterNumber)
    {
        IniRead, RecentlySearched, %UserCore_ini%, RecentlySearched, RecentlySearched
        FormatTime, TimeString,, M/d/yy hh:mm t
        ;Checks to see if you are searching an account that is in your recents
        if InStr(RecentlySearched, SearchEncounterNumber)
            {
                ;if account is in your recents moves it to the first spot in the dropdown
                ReplacedStr := StrReplace(RecentlySearched, "|" . SearchEncounterNumber . "|", "|")
                ;msgbox, %ReplacedStr%

                Loop, % vRecent := (oRecent := StrSplit(ReplacedStr, "|")).Length()
                vRecent%A_Index% := oRecent[A_Index]    
                ;MsgBox, % vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9 

                if (vRecent1 = SearchEncounterNumber)
                    Return
                else
                    NewRecents := SearchEncounterNumber "|" vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9
                ;msgbox, %NewRecents%

                iniwrite,%NewRecents%,%UserCore_ini%, RecentlySearched, RecentlySearched
            }
        else
            {
                ;if it is not in your recents removes the 10th oldest account searched and adds the new one to the first position in the dropdown
                Loop, % vRecent := (oRecent := StrSplit(RecentlySearched, "|")).Length()
                vRecent%A_Index% := oRecent[A_Index]    
                ;MsgBox, % vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9 

                NewRecents := SearchEncounterNumber "|" vRecent1 "|" vRecent2 "|" vRecent3 "|" vRecent4 "|" vRecent5 "|" vRecent6 "|" vRecent7 "|" vRecent8 "|" vRecent9
                ;msgbox, %NewRecents%

                iniwrite,%NewRecents%,%UserCore_ini%, RecentlySearched, RecentlySearched
            }
    }

ClearSearchHistory(UserCore_ini)
    {
        MsgBox, 4100,, Are you sure you'd like to clear all search history
        IfMsgBox Yes
            {
                IniWrite, % "",%UserCore_ini%, RecentlySearched, RecentlySearched
            }
        else
            return
    }