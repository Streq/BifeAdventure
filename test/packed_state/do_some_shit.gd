extends Node



func physics_process(delta):
	if Input.is_action_just_pressed("B0"):
		get_parent().goto("jab")
