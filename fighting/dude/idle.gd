extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("idle")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	
	if p.is_on_floor():
		if jump:
			emit_signal("finished", "jump", null)
		elif input_direction.x:
			emit_signal("finished", "run", null)
	else:
		emit_signal("finished", "air", null)
	
