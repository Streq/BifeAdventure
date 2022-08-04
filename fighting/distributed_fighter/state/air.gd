extends FighterState

## Initialize the state. E.g. change the animation
#func _enter(params):
#	pass

## Clean up the state. Reinitialize values like a timer
#func _exit():
#	return

## Called during _process
#func _idle_update(delta: float):
#	return

# Called during _physics_process
func _physics_update(delta: float):
	var input = root.input_state
	var dir = input.dir	
	if(dir.x):
		var speed : float
		var speed_lerp : float
		if input.C.is_pressed():
			speed = root.air_run_speed  
			speed_lerp = root.air_run_lerp
		else:
			speed = root.air_walk_speed  
			speed_lerp = root.air_walk_lerp
		if sign(dir.x) == sign(root.velocity.x):
			speed = max(speed, root.velocity.x)
		root.velocity.x = lerp(root.velocity.x, speed*dir.x, delta*speed_lerp)
	else:
		root.velocity.x = lerp(root.velocity.x, 0, delta*root.air_idle_lerp)
	

## Called during _input
#func _handle_input(event: InputEvent):
#	return

