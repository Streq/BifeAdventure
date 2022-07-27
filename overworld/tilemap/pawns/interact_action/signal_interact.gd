extends "interact_action.gd"

func interact(interacted, interactor, direction, grid):
	emit_signal("interacted", interacted, interactor, direction, grid)
