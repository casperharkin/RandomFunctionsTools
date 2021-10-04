#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


gui, color, EBEBEB 
Gui Add, Text, x68 y32 w92 h42, Standard
Gui Add, Text, x20 y2 w54 h16, Calculator
Gui Add, Button, x8 y26 w48 h48, Menu
Gui Add, Button, x281 y29 w48 h48, History
 

Gui, Font, S14
Gui Add, Button, x92 y261 w75 h49, C
Gui Add, Button, x13 y175 w48 h29, MC
Gui Add, Button, x13 y261 w75 h49, % "CE"
Gui Add, Button, x171 y473 w75 h48, .

Gui, Font, S30
Gui Add, Edit, x0 y90 w310 h75 +readonly -E0x200 +Right,0
Gui, Font, S14
Gui Add, Button, x250 y261 w74 h49, /
Gui Add, Button, x92 y314 w75 h49, 8
Gui Add, Button, x92 y367 w75 h49, 5
Gui Add, Button, x117 y175 w49 h29, M+
Gui Add, Button, x65 y175 w48 h29, MR
Gui Add, Button, x170 y175 w48 h29, M-
Gui Add, Button, x250 y367 w74 h49, -

Gui Add, Button, x250 y208 w74 h49, 1/x
Gui Add, Button, x170 y208 w75 h49, x2
Gui Add, Button, x92 y208 w75 h49, √

Gui Add, Button, x171 y261 w75 h49, <=
Gui Add, Button, x249 y314 w75 h49, X
Gui Add, Button, x250 y420 w75 h49, +
Gui Add, Button, x250 y472 w75 h49, =
Gui Add, Button, x13 y472 w75 h49, +/-
Gui Add, Button, x14 y208 w75 h49, % "%"
Gui Add, Button, x220 y175 w48 h29, MS
Gui Add, Button, x271 y175 w48 h29, M.

Gui, Font, S15 Bold

Gui Add, Button, x92 y314 w75 h49, 8
Gui Add, Button, x171 y367 w75 h49, 6
Gui Add, Button, x13 y314 w75 h49, 7
Gui Add, Button, x12 y367 w75 h49, 4
Gui Add, Button, x13 y420 w75 h49, 1
Gui Add, Button, x171 y314 w75 h49, 9
Gui Add, Button, x171 y420 w75 h49, 3
Gui Add, Button, x92 y420 w75 h49, 2
Gui Add, Button, x92 y473 w75 h48, 0
Gui, Font

Gui Show, w339 h538, Calculator