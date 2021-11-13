extends "controller.gd"


func get_direction(_actor) -> Vector2:
	var ret = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)
	if ret.x:
		ret.y = 0
	return ret
	
func get_interact(_actor) -> bool:
	return Input.is_action_just_pressed("A0")
