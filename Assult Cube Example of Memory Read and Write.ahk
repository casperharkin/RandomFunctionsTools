#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

; Game download https://assault.cubers.net/download.html

ProcessBase := ProcessBaseFromWindow("AssaultCube")
PlayerObjectPointer := NumberFromWindowProcess("AssaultCube", ProcessBase + 0x10F4F4, "ptr")
HealthAddress := PlayerObjectPointer + 0xF8

F3::
    Health := NumberFromWindowProcess("AssaultCube", HealthAddress, "uint")
    MsgBox, %Health%
    Return

F4:: NumberToWindowProcess(200, "AssaultCube", HealthAddress, "uint")


; ======================= Functions ============================================

NumberFromWindowProcess(Window, Address, NumType)
{
    Try {
        hProcess := HandleFromPid(PidFromWindow(Window))
        Number := NumberFromProcess(hProcess, Address, NumType)
    } Catch e {
        If (hProcess) {
            CloseHandle(hProcess)
        }
        MsgBox,, % e.What, % e.Message
        Exit
    }
    CloseHandle(hProcess)
    Return Number
}

NumberToWindowProcess(Number, Window, Address, NumType)
{
    Try {
        hProcess := HandleFromPid(PidFromWindow(Window))
        NumberToProcess(Number, hProcess, Address, NumType)
    } Catch e {
        If (hProcess) {
            CloseHandle(hProcess)
        }
        MsgBox,, % e.What, % e.Message
        Exit
    }
    CloseHandle(hProcess)
}

NumberFromExeProcess(Exe, Address, NumType)
{
    Try {
        hProcess := HandleFromPid(PidFromExe(Exe))
        Number := NumberFromProcess(hProcess, Address, NumType)
    } Catch e {
        If (hProcess) {
            CloseHandle(hProcess)
        }
        MsgBox,, % e.What, % e.Message
        Exit
    }
    CloseHandle(hProcess)
    Return Number
}

NumberToExeProcess(Number, Exe, Address, NumType)
{
    Try {
        hProcess := HandleFromPid(PidFromExe(Exe))
        NumberToProcess(Number, hProcess, Address, NumType)
    } Catch e {
        If (hProcess) {
            CloseHandle(hProcess)
        }
        MsgBox,, % e.What, % e.Message
        Exit
    }
    CloseHandle(hProcess)
}

PidFromWindow(Window)
{
    If !WinExist(Window) {
        Throw Exception("Window not found: " . Window)
    }
    WinGet, PID, PID
    Return PID
}

PidFromExe(Exe)
{
    Process, Exist, %Exe%
    If (!ErrorLevel) {
        Throw Exception("Process not found: " . Exe)
    }
    Return ErrorLevel
}

HandleFromPid(Pid)
{
    static PROCESS_VM_OPERATION := 0x8, PROCESS_VM_READ := 0x10, PROCESS_VM_WRITE := 0x20
    hProcess := DllCall("OpenProcess", "uint", PROCESS_VM_READ
                                        | PROCESS_VM_WRITE
                                        | PROCESS_VM_OPERATION
                                , "int", False, "uint", Pid, "ptr")
    If (!hProcess) {
        Throw Exception("OpenProcess failed: " . A_LastError)
    }
    Return hProcess
}

NumberFromProcess(hProcess, Address, NumType)
{
    VarSetCapacity(buf, 8, 0)
    If (NumType = "ptr") {
        NumType := ProcessBitness(hProcess) = 32 ? "uint" : "uint64"
    }
    If !DllCall("ReadProcessMemory", "ptr", hProcess, "ptr", Address
                                   , "ptr", &buf, "ptr", 8, "ptr", 0) {
        Throw Exception("ReadProcessMemory failed: " . A_LastError)
    }
    Return NumGet(buf, 0, NumType)
}

NumberToProcess(Number, hProcess, Address, NumType)
{
    VarSetCapacity(buf, 8, 0)
    If (NumType = "ptr") {
        NumType := ProcessBitness(hProcess) = 32 ? "uint" : "uint64"
    }
    BytesToWrite := NumPut(Number, buf, 0, NumType) - &buf
    If !DllCall("WriteProcessMemory", "ptr", hProcess, "ptr", Address
                                    , "ptr", &buf, "ptr", BytesToWrite, "ptr", 0) {
        Throw Exception("WriteProcessMemory failed: " . A_LastError)
    }
}

ProcessBitness(hProcess)
{
    If (!A_Is64bitOS) {
        Return 32
    }
    IsWow64 := False
    DllCall("IsWow64Process", "ptr", hProcess, "uint *", IsWow64)
    Return IsWow64 ? 32 : 64
}

ProcessBaseFromWindow(Window)
{
    static GWL_HINSTANCE := -6
    Try {
        hWnd := WinExist(Window)
        If (!hWnd) {
            Throw Exception("Window not found: " . Window)
        }
        FuncName := A_PtrSize = 4 ? "GetWindowLong" : "GetWindowLongPtr"
        Base := DllCall(FuncName, "ptr", hWnd, "int", GWL_HINSTANCE, "ptr")
        If (!Base) {
            Throw Exception(FuncName . " failed: " . A_LastError)
        }
    } Catch e {
        MsgBox,, % e.What, % e.Message
        Exit
    }
    Return Base
}

CloseHandle(hProcess)
{
    DllCall("CloseHandle", "ptr", hProcess)
}