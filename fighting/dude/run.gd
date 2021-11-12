extends "res://util/state/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("run")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	var attack = controller.get_attack()
	
	p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.speed_lerp)
	
	if p.is_on_floor():
		if attack:
			emit_signal("finished", "jab", null)
		elif jump:
			emit_signal("finished", "jump", null)
		elif !input_direction.x:
			emit_signal("finished", "idle", null)
		else:
			p.dir = input_direction.x
		
	else:
		emit_signal("finished", "air", null)
	
