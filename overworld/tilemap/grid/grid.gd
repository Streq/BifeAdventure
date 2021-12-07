extends TileMap

enum { EMPTY = -1, OBSTACLE, ACTOR, OBJECT}

var pause = false

var triggers

func _ready():
	for child in get_children():
		var tile = world_to_map(child.position)
		set_cellv(tile, child.type)
		child.grid_position = tile
	if Globals.spawn_tile != null:
		var players = get_tree().get_nodes_in_group("player")
		if players:
			var player = players[0]
			set_pawn_tile(player, Globals.spawn_tile)
		
func get_cell_pawn(coordinates):
	for node in get_children():
		if node.grid_position == coordinates:
			return(node)

func request_move(pawn, direction):
	if pause:
		direction = Vector2.ZERO
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		EMPTY:
			triggers.check_triggers(pawn, self, cell_start, cell_target)
			return update_pawn_position(pawn, cell_start, cell_target)
		OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		ACTOR:
#			var pawn_name = get_cell_pawn(cell_target).name
#			print_debug("Cell %s contains %s" % [cell_target, pawn_name])
			pass


func request_remove(pawn, tile_to_replace: int = EMPTY):
	var tile = world_to_map(pawn.position)
	pawn.queue_free()
	set_cellv(tile, tile_to_replace)
	
func request_clear_tile(pawn, tile_to_replace: int = EMPTY):
	var tile = world_to_map(pawn.position)
	set_cellv(tile, tile_to_replace)

func set_pawn_tile(pawn, tile):
	pawn.position = update_pawn_position(pawn, pawn.grid_position, tile)

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
	pawn.grid_position = cell_target
	return map_to_world(cell_target) + cell_size / 2



func pause():
	pause = true
	for child in get_children():
		child.set_process(false)
	pass
func unpause():
	pause = false
	for child in get_children():
		child.set_process(true)
	pass
