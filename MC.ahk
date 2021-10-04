#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


Exit ; End of AES

^a::SendCommand("tpaccept")
^s::SendCommand("spawn")
^v::SendCommand("warp creates")
^t::SendCommand("tpa rossy")
^c::SendCommand("craft")
^h::SendCommand("home home")
^r::SendCommand("warp resource")
^b::SendCommand("back")

SendCommand(msg) {
	SendInput /
	Sleep % RandomNoGenny()
	SendInput %msg%{Enter}
}

RandomNoGenny(Min := 300, Max := 600) {
Random, vRandom, % Min, % Max
Return vRandom
}

