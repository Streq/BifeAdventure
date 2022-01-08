extends "trigger.gd"


export(Globals.ROOM) var to = Globals.ROOM.my_hometown
export(bool) var relative_spawn_pos = true
export(bool) var is_world_coords = true
export(bool) var wait_step = true

func trigger(pawn = null, grid = null, cell_start = null, cell_target = null):
	if wait_step:
		yield(pawn, "finish_step")
	var pos = $spawn_pos.global_position if relative_spawn_pos else $spawn_pos.position
	if is_world_coords:
		Globals.spawn_tile = pos / Globals.TILE_SIZE
	else:
		Globals.spawn_tile = pos
	get_tree().change_scene_to(Overworld.get_room(to))
