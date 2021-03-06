extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("air")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	if(input_direction.x):
		p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.air_speed_lerp)
	else:
		p.velocity.x = lerp(p.velocity.x, 0, delta * p.air_idle_lerp)
	
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
