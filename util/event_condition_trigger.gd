extends Node

signal trigger

export (Globals.EVENT) var event
export var happened : bool = true

func trigger():
	if happened and Globals.get_event(event) or !happened and !Globals.get_event(event):
		emit_signal("trigger")
