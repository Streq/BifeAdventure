extends Node

signal happened
signal not_happened

export (Globals.EVENT) var event

func trigger():
	if Globals.get_event(event):
		emit_signal("happened")
	else:
		emit_signal("not_happened")
