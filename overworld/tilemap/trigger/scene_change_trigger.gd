extends "trigger.gd"


export(Globals.ROOM) var to = Globals.ROOM.my_hometown


func trigger(pawn, grid, cell_start, cell_target):
	yield(pawn, "finish_step")
	Globals.spawn_tile = grid.world_to_map($spawn_pos.global_position)
	get_tree().change_scene_to(Overworld.map[to])
