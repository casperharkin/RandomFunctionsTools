#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Menu ContextMenu, Add, No Client Loaded, ContextMenuHandler, :NewMenuTitle
;Menu ContextMenu, Icon, Chrome, C:\Users\babb\AppData\Local\Google\Chrome\Application\chrome.exe,,32
Menu ContextMenu, Add,
Menu ContextMenu, Add, Load Client Data, ContextMenuHandler
;Menu ContextMenu, Icon, Load Client Data, shell32.dll, 171,32
Menu ContextMenu, Add, Prepare Paid Due Diff, ContextMenuHandler
;Menu ContextMenu, Icon, Prepare Paid Due Diff, shell32.dll, 171,32	
Menu ContextMenu, Add, Process Workbook, ContextMenuHandler
;Menu ContextMenu, Icon, Process Workbook, shell32.dll, 89,32
Menu ContextMenu, Add, Create ePOD Record, ContextMenuHandler
;Menu ContextMenu, Icon, Create ePOD Record, C:\Users\babb\Desktop\Temp File\output_onlinepngtools_dld_icon (1).ico,,32
Menu ContextMenu, Add, Adjust Cumlative Totals, ContextMenuHandler
;Menu ContextMenu, Icon, Adjust Cumlative Totals,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,,32
Menu ContextMenu, Add, Enter Recovery PTR, ContextMenuHandler
;Menu ContextMenu, Icon, Enter Recovery PTR,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,, 32

#RButton::Menu, ContextMenu, Show ;Set Windows Key + Right Click as hotkey for Cotnext Menu
Return
ContextMenuHandler:

Return

q::
NewMenuTitle = Workbook.AGS | Workbook.Surname,  Workbook.Given_names
Menu, ContextMenu, Rename, 1&,%NewMenuTitle%
Menu, ContextMenu, add, 1&, % ":" . NewMenuTitle
Menu NewMenuTitle, Add, Clear Client Data, ContextMenuHandler
Return