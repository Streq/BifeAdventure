extends Node

export var flip_h : bool = false

func _physics_process(delta):
	var input = get_parent().input_state
	input.A.update(Input.is_action_pressed("A0"))
	input.B.update(Input.is_action_pressed("B0"))
	input.C.update(Input.is_action_pressed("C0"))
	input.dir.x = float(Input.is_action_pressed("right0")) - float(Input.is_action_pressed("left0"))
	if flip_h:
		input.dir.x *= -1.0
	input.dir.y = float(Input.is_action_pressed("down0")) - float(Input.is_action_pressed("up0"))
	
