
SessionChange()
Exit
SessionChange(notify := true) {
    static WTS_CURRENT_SERVER := 0, NOTIFY_FOR_ALL_SESSIONS := 1

    if (notify)  ; http://msdn.com/library/bb530723(vs.85,en-us)
    {
        if !(DllCall("wtsapi32.dll\WTSRegisterSessionNotificationEx", "Ptr", WTS_CURRENT_SERVER, "Ptr", A_ScriptHwnd, "UInt", NOTIFY_FOR_ALL_SESSIONS))
            return false
        OnMessage(0x02B1, "WM_WTSSESSION_CHANGE")
    }
    else         ; http://msdn.com/library/bb530724(vs.85,en-us)
    {
        OnMessage(0x02B1, "")
        if !(DllCall("wtsapi32.dll\WTSUnRegisterSessionNotificationEx", "Ptr", WTS_CURRENT_SERVER, "Ptr", A_ScriptHwnd))
            return false
    }
    return true
}

WM_WTSSESSION_CHANGE(wParam, lParam) { ; http://msdn.com/library/aa383828(vs.85,en-us)
    static WTS_SESSION_UNLOCK := 0x8

    if (wParam = WTS_SESSION_UNLOCK) {
	    FormatTime, out, HHMM
		MsgBox % out
    }
}
