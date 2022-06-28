extends Node


func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var fighter = get_parent().root
	var input = fighter.input_state
	
	var target_speed = 0.0
	if input.dir.x:
		if input.C:
			target_speed = fighter.run_speed
		else:
			target_speed = fighter.walk_speed
	if input.dir.x:
		fighter.velocity.x = lerp(fighter.velocity.x, target_speed*input.dir.x, delta*2.0)
