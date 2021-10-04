#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

wb := WBGet()

Elements := {}
Elements := wb.document.getElementsByTagName("DIV")
Loop %  Elements.length {
	Bounding :=  findPos(Elements[A_Index-1])

	if (Elements[A_Index-1].getAttribute("class") = "cat")
	    msgbox % Elements[A_Index-1].getAttribute("class") "`n`nleft: " Bounding.left " top: " Bounding.top " right: " Bounding.right " bottom: " Bounding.bottom
}

return

findPos(el) {
    if (el.getBoundingClientRect)
        return el.getBoundingClientRect()
    else {
        x = 0, y = 0
        loop
        {
            x += el.offsetLeft - el.scrollLeft
            y += el.offsetTop - el.scrollTop
        } until (el = el.offsetParent)
        
        return "left:" x ", " "top:" y
    }      
}
return

WBGet(WinTitle="ahk_class IEFrame", Svr#=1) { ; based on ComObjQuery docs
   static   msg := DllCall("RegisterWindowMessage", "str", "WM_HTML_GETOBJECT")
   ,   IID := "{0002DF05-0000-0000-C000-000000000046}" ; IID_IWebBrowserApp
;   ,   IID := "{332C4427-26CB-11D0-B483-00C04FD90119}" ; IID_IHTMLWindow2
   SendMessage msg, 0, 0, Internet Explorer_Server%Svr#%, %WinTitle%
   if (ErrorLevel != "FAIL") {
      lResult:=ErrorLevel, VarSetCapacity(GUID,16,0)
      if DllCall("ole32\CLSIDFromString", "wstr","{332C4425-26CB-11D0-B483-00C04FD90119}", "ptr",&GUID) >= 0 {
         DllCall("oleacc\ObjectFromLresult", "ptr",lResult, "ptr",&GUID, "ptr",0, "ptr*",pdoc)
         return ComObj(9,ComObjQuery(pdoc,IID,IID),1), ObjRelease(pdoc)
      }
   }
}
