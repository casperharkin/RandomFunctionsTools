#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

GAS_Notes_Icon()
Menu Tray, Icon, HBITMAP:*%BMPLogo%
Return

GAS_Notes_Icon()
{
Global
S := "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAABvUExURUdwTACl+wCq9F"
S .= "JuewCq8wCp8wCp8wCr8QCo8gCp9ACq9FFtelRsfVNte1Jte1NuelFuegCp9FJuelJtelJtegCp8wCq9ACq9ACp9FJte1JtewCp9FFuegCq9FNtegCq9FFtelNue1Nuew"
S .= "Cq9LG/xkFUb5gAAAAidFJOUwAJvIxp0cwS/nCP7xh60g0y8mTepuGmJEdVmjb2gcBY+v41z2zRAAAGYElEQVR42u3d23aiShCA4RKMImeRgy5RY/d+/2fcNzMjchAaoa"
S .= "lqqu6zkv8DWuxEAtAx/iVIw5P3K5DPr3cK0+Diw6QT26EQQjwFiXkKIZ6hHU9VHwWhIDlhEE2Rb3uC7HjfEyQelRO/gyD57tq/C/Jz/2I9vHjCgCkvY/ttYcjY4/pTYc"
S .= "ykY/rv5vSL533M8X+aJJCu9vofuQ5chHGj9FoQe+YBlP5KF8DXHZHC/a8wcgbfFUftF4CXJvHEb7PnGD9O0rI9IPrmFeCUREBmouTU1hCMPwHKAIhNUI4+BYKWwx8DuY"
S .= "mbJ8Fz2GFs7v+EPhAcvyVkkFzz+JPsB/Cb58CQM7mxBJYxEJ24HHNDHI5cO1GuhCOuAb9xAQDhqV8Ez/6r+TL6/gnjJOpviYKxt08474hK5es5nWI3Cc+o54QmXQHNay"
S .= "BUXjZi2gC1u5pn/5JefyPg0waov6h5vV9R//037X6IamfAb+9XCLMA1HsYgAEYgAEYgAEYgAEYgAEYgAEYgAEYoPcL/lt4GIABGIABGIABGIABGIABGIABGIABGIA3RB"
S .= "iAARiAARiAARiAARiAARiAARiAARiAN0QYgAEYgAEYgAEYgAEYgAEYgAEYgAEYgDdEGIABGIABGIABGIABGIABGIABGGCFAPbKAezpTxlSGyI2rBvAhnUD2LBuABvWDW"
S .= "DDugFsWDeADesGsGHdADasG8CGdQOo/ac98wAU/9OgcQCq/3HVNADl/zhrGgAwwNxbSLSmOOTZ0XEyyz2vEeBhyddkt83KAIpqvpRSZo9VATyOsjH5Zj0AB0e2jLVZC8"
S .= "BBtk9DwFCArv6mgJkA3f0NASMBPvVLuduYDvC5v3YOGAjQ1/8uYB5Af/+bgHEAQ/qrAqYBDOuvCBgGMLT/JWAWwPD+fwK6N0TQ9P8VMAlArV86uWEAiv1SyodRAOr9Mt"
S .= "sYBDCiX8qDOQCj+mVmDMC4fimvhgCM7Zc3MwBG90vLCIDx/TIzAeCLfnk0AKDSv7NUARz6ANX+/cZa3Rnw1g+gKvBDHaDWryyQEwdo9KsKbGlviLT0qwk4BWmA1n4lAY"
S .= "v0llhHv4rAmTJAZ/9wAYvypuiH/qECx4IwwMf+YQLOmfC2eE//EAFnS/j3Ar39/QJ/+mkCDOjvE/jbTxJgUP9ngX/9FAEG9n8SePUTBBjc3y1Q6acHoNDfJVDtJweg1N"
S .= "8u8NZPDUCxv03gvZ8YgHJ/U6DWTwtgRH9doN5PCmBU/7tAo58SwMh+2O8+9BMCmKefDsBM/WQA5uqnAjBbPxGA+fppAMzYTwJgdP9Pfz8FgFn7CQDM248fYOZ+9ABz92"
S .= "MHmL0fOcD8/bgBNPSjBtDRjxlASz9iAD39eAE09aMF0NWPFUBbP1IAff04ATT2owTQ2Y8R4KGzHyHA2dHZjw+gOGrtRwewz/T2owOwNPdjA7i9Psuhpx8ZwGsBzDT14w"
S .= "J4LQDHQlM/LgDr/e+YdfSjAthWPtKrqx8TwOsOwNLXjwnAGrMAftuPCGBb+TCfvn48AJvKI0Bdff14AG7Vv+ZztfWjAdi/PwPW1dWPBqD+EABXUz8agJ1UFZimHw1A8y"
S .= "nIrpZ+LADXls81uDr6sQBspZrAZP1YAHKpJDBdP/ziAMikisCE/eDVAPxl7gK6Pt/mzt0PpxpAvAjAQyoITNoPYQ0gWQTAlcMFpu2HtAaQ4rgN6haYuB+CGkAZLfxOsE"
S .= "dg6n64CATXwPXzJ90rAtds4n7w6wAnBO+EugQ2N2fq/uYqKAIst0ENgetOTt8Pdh2g1P9KmMkBAtXDP2E/xKJxEei+GSoGPPHFvf7IWfpbrgERahZ4KD8FcMr+xguhEO"
S .= "Kk9ypwVR8CeJ7020deU6DUuhL+KD4IdT/x9285BYQ4JdruiDaO0uE/TP4DtJ0CQogyTWJfh8JZpX9XzPATJEL/VL79bdHDDwAA90UBFB7/V8x0EvrekgDHoYf/Md9leF"
S .= "kQoBj42p/v51yI7OUAtsOef3udeSlOFwPIF1z8FlwIVd4JybzQcT+SLgOw738C/Bn0jL0IwOfboCzfXkHbXLwFADrfCR137mMPese/6wew2g/84bpZZH868TQDNDaEnZ"
S .= "37KGC5iQJPK8DbhvDRup03sPREQagR4N+G8E++LQDLxHb41ASQ/znwe0A2/iVIw5P3OzfALj9cl+z8H3OpaygOnUTnAAAAAElFTkSuQmCC"

; GDI+ Startup
hGdip := DllCall("Kernel32.dll\LoadLibrary", "Str", "Gdiplus.dll") ; Load module
VarSetCapacity(GdiplusStartupInput, (A_PtrSize = 8 ? 24 : 16), 0) ; GdiplusStartupInput structure
NumPut(1, GdiplusStartupInput, 0, "UInt") ; GdiplusVersion
VarSetCapacity(pToken, 0) ;Make var big enough to fit contents
DllCall("Gdiplus.dll\GdiplusStartup", "PtrP", pToken, "Ptr", &GdiplusStartupInput, "Ptr", 0) ; Initialize GDI+

BMPLogo := GdipCreateFromBase(S) ;Turn the raw data into an image. 

; Free GDI+ module from memory
DllCall("Kernel32.dll\FreeLibrary", "Ptr", hGdip)
}

GdipCreateFromBase(B64, IsIcon := 0) 
{
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