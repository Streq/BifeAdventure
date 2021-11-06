extends "trigger.gd"

func trigger(pawn, grid, cell_start, cell_target):
	print_debug("hola")
	yield(pawn, "finish_step")
	pawn.position = grid.update_pawn_position(pawn, cell_target, grid.world_to_map($to.global_position))
