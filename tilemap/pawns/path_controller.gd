extends "controller.gd"

enum Type{
	ONCE, LOOP, BACK_FORTH
}
export (Type) var type := Type.ONCE
export (PoolVector2Array) var commands := PoolVector2Array()

var current_index = 0
var current_command = Vector2.ZERO

func get_direction(_actor) -> Vector2:
	if current_command == Vector2.ZERO:
		current_command = commands[current_index]
		current_index = (current_index + 1) % commands.size()
	
	var ret = current_command
	
	if abs(ret.x) > abs(ret.y):
		ret.y = 0
	else: 
		ret.x = 0
	ret = Vector2(sign(ret.x), sign(ret.y))
	
	current_command -= ret
	return ret

func get_interact(_actor) -> bool:
	return false
