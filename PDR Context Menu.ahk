#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
ContextMenu()
Return
#RButton::Menu, ContextMenu, Show


ContextMenuHandler:
Initialise:
MenuHandler:
Return

ContextMenu()
{
Menu ContextMenu, Add, Chrome, ContextMenuHandler
Menu ContextMenu, Icon, Chrome, C:\Users\babb\AppData\Local\Google\Chrome\Application\chrome.exe,,32
Menu ContextMenu, Add, Load Client Data, ContextMenuHandler
Menu ContextMenu, Icon, Load Client Data, shell32.dll, 171,32
Menu ContextMenu, Add, Process Workbook, ContextMenuHandler
Menu ContextMenu, Icon, Process Workbook, shell32.dll, 89,32
Menu ContextMenu, Add, Create ePOD Record, ContextMenuHandler
Menu ContextMenu, Icon, Create ePOD Record, C:\Users\babb\Desktop\Temp File\output_onlinepngtools_dld_icon (1).ico,,32
Menu ContextMenu, Add, Adjust Cumlative Totals, ContextMenuHandler
Menu ContextMenu, Icon, Adjust Cumlative Totals,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,,32
Menu ContextMenu, Add, Enter Recovery PTR, ContextMenuHandler
Menu ContextMenu, Icon, Enter Recovery PTR,C:\Program Files (x86)\MochaSoft\Mocha TN3270 for Vista\tn3270.exe,, 32
}