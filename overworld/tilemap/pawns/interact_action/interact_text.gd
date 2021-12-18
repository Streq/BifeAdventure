extends "interact_action.gd"

export (PoolStringArray) var interact_text := PoolStringArray(["mucho texto"])

func interact(interacted, interactor, direction):
	interacted.turn(-direction)
	interacted.bump()
	Signals.emit_signal("display_text", interact_text)
	
