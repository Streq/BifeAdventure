extends Node2D

enum TRIGGER_TYPES{ DOOR }
export(TRIGGER_TYPES) var type = TRIGGER_TYPES.DOOR

var grid_position :Vector2

func trigger(pawn, grid, cell_start, cell_target):
	pass
