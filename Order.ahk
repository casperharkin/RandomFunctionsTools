#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Menus := OrderedArray()
;
;Menus.Push({"File":"New,Open...,Save,Save As...,,Page Setup...,Print...,,Exit"})
;Menus.Push({"Edit": "Undo,,Cut,Copy,Paste,Delete"})
;Menus.Push({"View": "Font,Word Wrap"})
;Menus.Push({"Settings": "Titlecase,Uppercase,Lowercase"})
;Menus.Push({"Help": "About,Help"})
;
;for each, item in Menus
;	MsgBox % item 
;
;Exit

Menus := new CaseSenseList
Menus.Push({"File":"New,Open...,Save,Save As...,,Page Setup...,Print...,,Exit"})
Menus.Push({"Edit": "Undo,,Cut,Copy,Paste,Delete"})
Menus.Push({"View": "Font,Word Wrap"})
Menus.Push({"Settings": "Titlecase,Uppercase,Lowercase"})
Menus.Push({"Help": "About,Help"})

loop % Menus.count() {
	Menus[A_Index]
		for each, item in Menus[A_Index]
			MsgBox % each
}

Exit

class CaseSenseList
{
   __New() {
      ObjRawSet(this, "_list_", [])
   }
   
   __Delete() {
      this.SetCapacity("_list_", 0)
      ObjRawSet(this, "_list_", "")
   }
   
   __Set(key, value) {
      for k, v in this._list_ {
         if !(v[1] == key)
            continue
         v[2] := value
         keyExist := true
      } until keyExist
      if !keyExist
         this._list_.Push([key, value])
      Return value
   }
   
   __Get(key) {
      if (key == "_list_")
         Return
      for k, v in this._list_ {
         if (v[1] == key)
            Return v[2]
      }
   }
   
   _NewEnum() {
      Return new this._CustomEnum_(this._list_)
   }
   
   class _CustomEnum_
   {
      __New(list) {
         this.i := 0
         this.list := list
      }
      
      Next(ByRef k, ByRef v) {
         this.i++
         k := this.list[this.i, 1]
         v := this.list[this.i, 2]
         Return this.i > this.list.Length() ? false : true
      }
   }
   
   Delete(key) {
      for k, v in this._list_
         continue
      until v[1] == key && keyExist := true
      Return keyExist ? this._list_.RemoveAt(k)[2] : ""
   }
   
   HasKey(key) {
      for k, v in this._list_
         if (v[1] == key)
            Return true
      Return false
   }
}