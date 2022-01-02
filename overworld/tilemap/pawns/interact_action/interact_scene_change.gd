extends "interact_action.gd"


func interact(interacted, interactor, direction, grid):
	print_debug("hola2")
	var pos = grid.world_to_map(interactor.position)
	$scene_change.trigger(interactor, grid, pos, pos, false)
