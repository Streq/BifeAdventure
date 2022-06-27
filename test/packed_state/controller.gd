extends Node


func _physics_process(delta):
	var input = get_parent().input_state
	input.A = Input.is_action_pressed("A0")
	input.B = Input.is_action_pressed("B0")
	input.C = Input.is_action_pressed("C0")
	input.dir.x = float(Input.is_action_pressed("right0")) - float(Input.is_action_pressed("left0"))
	input.dir.y = float(Input.is_action_pressed("down0")) - float(Input.is_action_pressed("up0"))
	
