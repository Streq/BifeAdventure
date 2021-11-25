extends "trigger.gd"

export(String, FILE, "*.tscn") var to

func trigger(pawn, grid, cell_start, cell_target):
	yield(pawn, "finish_step")
	Globals.spawn_tile = grid.world_to_map($spawn_pos.global_position)
	get_tree().change_scene(to)
