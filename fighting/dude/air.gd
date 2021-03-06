extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("air")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	var speed = p.speed if controller.is_pressing_special() else p.walk_speed
	if(input_direction.x):
		p.velocity.x = lerp(p.velocity.x, speed*input_direction.x, delta * p.air_speed_lerp)
	else:
		p.velocity.x = lerp(p.velocity.x, 0, delta * p.air_idle_lerp)
	
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif p.is_on_wall():
		var count = p.get_slide_count()
		if count != 0:
			var normal = p.get_slide_collision(0).normal
			if -normal.x == p.dir:
				emit_signal("finished", "wall", null)
				# stick to the wall
				p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)
	
