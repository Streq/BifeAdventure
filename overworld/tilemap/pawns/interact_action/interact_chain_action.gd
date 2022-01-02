extends "interact_action.gd"

func interact(interacted, interactor, direction, grid):
	var size = get_children().size()
	for i in range(size):
		var result = get_node(str(i)).interact(interacted, interactor, direction, grid)
		if result is GDScriptFunctionState: # Still working.
			result = yield(result, "completed")

