extends TileMap

enum { EMPTY = -1, OBSTACLE, ACTOR, OBJECT}

func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
		
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print_debug("Cell %s contains %s" % [cell_target, pawn_name])

func request_interact(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		OBJECT:
			get_cell_pawn(cell_target).interact()
		ACTOR:
			var act = get_cell_pawn(cell_target)
			var pawn_name = act.name
			print_debug("Cell %s contains %s" % [cell_target, pawn_name])
			act.interact(pawn, direction)

func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target) + cell_size / 2

func pause():
	for child in get_children():
		child.set_process(false)
func unpause():
	for child in get_children():
		child.set_process(true)
