extends Node

func get_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input_direction

func get_jump():
	return Input.is_action_just_pressed("A")

func get_attack():
	return Input.is_action_just_pressed("B")
