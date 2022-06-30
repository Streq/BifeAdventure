extends Node


func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var fighter = get_parent().root
	var input = fighter.input_state
	
	var target_speed = 0.0
	if input.C:
		if input.dir.x:
			target_speed = fighter.run_speed
	#		else:
	#			target_speed = fighter.walk_speed
			if (sign(input.dir.x) != sign(fighter.velocity.x) 
			or abs(fighter.velocity.x) < target_speed):
				fighter.velocity.x = lerp(fighter.velocity.x, input.dir.x*target_speed, delta*2.0)
		if input.dir.y > 0.0:
			fighter.velocity.y += fighter.gravity * delta
		elif input.dir.y < 0.0:
			fighter.velocity.y -= fighter.gravity*0.5 * delta
