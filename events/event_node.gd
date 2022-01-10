extends Node

export (Globals.EVENT) var event


func trigger():
	Globals.events[Globals.EVENT] = true
