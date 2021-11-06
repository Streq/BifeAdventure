extends TileMap


enum { EMPTY = -1, DOOR}

func check_triggers(pawn, grid, cell_start, cell_target):
	var cell_target_type = get_cellv(cell_target)
	if cell_target_type != EMPTY:
		var trigger = get_cell_pawn(cell_target)
		trigger.trigger(pawn, grid, cell_start, cell_target)


func _ready():
	for child in get_children():
		var tile = world_to_map(child.position)
		set_cellv(tile, child.type)
		child.grid_position = tile

func get_cell_pawn(coordinates):
	for node in get_children():
		if node.grid_position == coordinates:
			return(node)


