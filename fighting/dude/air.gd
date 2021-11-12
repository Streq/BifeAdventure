extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("air")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	var attack = controller.get_attack()
	
	p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.speed_lerp * 0.5)
	if attack:
		emit_signal("finished", "air_kick", null)
	elif p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif p.is_on_wall():
		var count = p.get_slide_count()
		if count != 0:
			var normal = p.get_slide_collision(0).normal
			if -normal.x == p.dir:
				emit_signal("finished", "wall", null)
				# stick to the wall
				p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)
	
