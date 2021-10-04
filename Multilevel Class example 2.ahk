#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



myvehicule := new vehicule()
mycar := new car()
mycar.newEngine("V8")
msgbox % "The color of my car is " mycar.getColor()

Exit

class engine {
	name := ""
	
	__New() {
		this.name := "vehicule engine"
	}
	
	setEngine(newE) {
		this.name := newE
	}
}

class vehicule {
	engine := new engine()
	
	__New() {
		msgbox % "The engine of this vehicule is a " this.engine.name
	}
}

class car extends vehicule {
	color := "red"
	
	__New() {
		msgbox % "The engine of this car is a " this.engine.name
	}
	
	newEngine(newE) {
		this.engine.setEngine(newE)
		msgbox % "The new engine of this car is a " this.engine.name
	}
	
	getColor() {
		return this.color
	}
}
