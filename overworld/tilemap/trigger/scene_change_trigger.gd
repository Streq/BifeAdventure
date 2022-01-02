extends "trigger.gd"


export(Globals.ROOM) var to = Globals.ROOM.my_hometown
export(bool) var relative_spawn_pos = true
export(bool) var is_world_coords = true

func trigger(pawn, grid, cell_start, cell_target, wait_step = true):
	if wait_step:
		yield(pawn, "finish_step")
	var pos = $spawn_pos.global_position if relative_spawn_pos else $spawn_pos.position
	if is_world_coords:
		Globals.spawn_tile = grid.world_to_map(pos)
	else:
		Globals.spawn_tile = pos
	get_tree().change_scene_to(Overworld.map[to])
