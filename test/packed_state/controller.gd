extends Node


func _physics_process(delta):
	get_parent().input_state.A = Input.is_action_pressed("A0")
	get_parent().input_state.B = Input.is_action_pressed("B0")
