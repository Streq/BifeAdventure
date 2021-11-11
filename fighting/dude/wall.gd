extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("wall")

func update(delta):
	var p = owner
	p._move(delta)	
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.speed_lerp * 0.5)
	p.velocity.y = lerp(p.velocity.y, 0, delta*5)
	# stick to the wall
	p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)

	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif !p.is_on_wall():
		emit_signal("finished", "air", null)
	elif jump:
		emit_signal("finished", "wall_jump", null)
	
