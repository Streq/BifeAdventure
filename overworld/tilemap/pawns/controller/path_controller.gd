extends "controller.gd"

enum Type{
	ONCE, LOOP, BACK_FORTH
}
export (Type) var type := Type.ONCE
export (PoolVector2Array) var path := PoolVector2Array()

var current_index = -1
var current_distance := Vector2.ZERO
var current_target := Vector2.ZERO

func get_direction(actor) -> Vector2:
	current_distance = current_target - actor.grid_position
	
	if current_distance == Vector2.ZERO or current_index < 0:
		current_index = (current_index + 1) % path.size()
		current_distance = path[current_index]
		current_target = actor.grid_position + current_distance
	
	if abs(current_distance.x) > abs(current_distance.y):
		return Vector2(sign(current_distance.x),0)
	else: 
		return Vector2(0,sign(current_distance.y))


func get_interact(_actor) -> bool:
	return false
