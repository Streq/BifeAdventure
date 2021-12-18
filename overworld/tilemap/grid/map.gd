extends Node2D

export var hide_tiles := false

onready var grid = $grid
onready var triggers = $triggers

func _ready():
	grid.triggers = triggers
	if hide_tiles:
		$grid.self_modulate.a=0
		$triggers.self_modulate.a=0
		__tilemap_self_modulate_bug_dirty_fix($grid)
		__tilemap_self_modulate_bug_dirty_fix($triggers)

func __tilemap_self_modulate_bug_dirty_fix(map:TileMap):
	var _temp_tiles = {}
	for pos in map.get_used_cells():
		_temp_tiles[pos] = map.get_cellv(pos)
	map.clear()
	for pos in _temp_tiles.keys():
		map.set_cellv(pos, _temp_tiles[pos])
