extends Node2D

enum CELL_TYPES{ OBSTACLE, ACTOR, OBJECT }
export(CELL_TYPES) var type = CELL_TYPES.ACTOR

onready var grid_position :Vector2 = position

func interact(pawn, direction):
	pass
