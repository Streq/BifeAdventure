extends "interact_action.gd"
signal interacted(interacted, interactor, direction, grid)

func interact(interacted, interactor, direction, grid):
	emit_signal("interacted", interacted, interactor, direction, grid)
