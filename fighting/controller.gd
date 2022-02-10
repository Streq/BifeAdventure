extends Node
class_name Controller
func get_direction() -> Vector2:
	return Vector2.ZERO

func get_jump() -> bool:
	return false
	
func is_pressing_jump() -> bool:
	return false

func get_attack() -> bool:
	return false

func is_pressing_attack():
	return false
	
func get_special():
	return false

func is_pressing_special():
	return false
