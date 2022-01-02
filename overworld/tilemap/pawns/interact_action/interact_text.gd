extends "interact_action.gd"

export (PoolStringArray) var interact_text := PoolStringArray(["mucho texto"])

func interact(interacted, interactor, direction, grid):
	interacted.turn(-direction)
	interacted.bump()
	Signals.emit_signal("display_text", interact_text)
	var textbox = get_tree().get_nodes_in_group("textbox")[0]
	yield(textbox, "text_display_finished")
	print_debug("hola")

