extends Node

export (Globals.EVENT) var event


func trigger():
	Globals.set_event(event, true)
