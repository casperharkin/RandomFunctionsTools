#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

HistoryImage =
(Join
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
AAAABJRU5ErkJggg==
)

MenuImage =
(Join
iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAACKSURBV
GhD7dfBCcAgEETRTbrStqzDtrQT20hAvCeCMlnyH0jw+Alz8GitXebYOb5uEaBGgBoBagSoEaBGgBoBagSouQ+YelKWUqzWOm7rhRAsxjhu70wF5Jz72SWl1M+
Mf/2BL2LEKzHiJ4x4A0a8EiN+wog34D2gRoAaAWoEqBGgRoAaAWrOA8xuN3VmUdm+RPkAAAAASUVORK5CYII=
)

Gui, add, picture,, % "HBITMAP:" h := GDI_Startup(HistoryImage)
Gui, add, picture,, % "HBITMAP:" h := GDI_Startup(MenuImage)
Gui, Show,,
Exit ; End of Auto-Execute Section.

GDI_Startup(Base64) {
	hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll") ; Load module
	VarSetCapacity(GdiplusStartupInput, (A_PtrSize = 8 ? 24 : 16), 0) ; GdiplusStartupInput structure
	NumPut(1, GdiplusStartupInput, 0, "UInt") ; GdiplusVersion
	VarSetCapacity(pToken, 0) ;Make var big enough to fit contents
	DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &GdiplusStartupInput, "Ptr", 0) ; Initialize GDI+
	BMP := GdipCreateFromBase(Base64) ;Turn the raw data into an image. 
	DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip) ; Free GDI+ module from memory
	Return BMP 
}

GdipCreateFromBase(B64, IsIcon := 0) {
	VarSetCapacity(B64Len, 0)
	DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", 0, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
	VarSetCapacity(B64Dec, B64Len, 0) ; pbBinary size
	DllCall("Crypt32.dll\CryptStringToBinary", "Ptr", &B64, "UInt", StrLen(B64), "UInt", 0x01, "Ptr", &B64Dec, "UIntP", B64Len, "Ptr", 0, "Ptr", 0)
	pStream := DllCall("Shlwapi.dll\SHCreateMemStream", "Ptr", &B64Dec, "UInt", B64Len, "UPtr")
	VarSetCapacity(pBitmap, 0)
	DllCall("Gdiplus.dll\GdipCreateBitmapFromStreamICM", "Ptr", pStream, "PtrP", pBitmap)
	VarSetCapacity(hBitmap, 0)
	DllCall("Gdiplus.dll\GdipCreateHBITMAPFromBitmap", "UInt", pBitmap, "UInt*", hBitmap, "Int", 0XFFFFFFFF)
	If (IsIcon) 
		DllCall("Gdiplus.dll\GdipCreateHICONFromBitmap", "Ptr", pBitmap, "PtrP", hIcon, "UInt", 0)
	ObjRelease(pStream)
	return (IsIcon ? hIcon : hBitmap)
}
