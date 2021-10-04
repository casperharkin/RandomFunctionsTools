
address := 

loop 1000{
value:=ReadMemory(0x41000C,"Calculator ‎- Calculator")
MsgBox Memory address 0x41000C = %value%
}
ElapsedTime := A_TickCount - StartTime
msgbox, Memory address 0x41000C = %value%`nTake %ElapsedTime% ms to loop 1000 times








ReadMemory(MADDRESS,PROGRAM)
{
winget, pid, PID, %PROGRAM%

VarSetCapacity(MVALUE,4,0)
ProcessHandle := DllCall("OpenProcess", "Int", 24, "Char", 0, "UInt", pid, "UInt")
DllCall("ReadProcessMemory","UInt",ProcessHandle,"UInt",MADDRESS,"Str",MVALUE,"UInt",4,"UInt *",0)

Loop 4
result += *(&MVALUE + A_Index-1) << 8*(A_Index-1)

return, result  
}