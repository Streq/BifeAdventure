extends Node2D

enum CELL_TYPES{ OBSTACLE, ACTOR, OBJECT }
export(CELL_TYPES) var type = CELL_TYPES.ACTOR

var grid_position :Vector2

func interact(pawn, direction):
	pass
