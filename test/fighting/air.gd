extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("air")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	
	p.velocity.x = lerp(p.velocity.x, p.speed*input_direction.x, delta * p.speed_lerp * 0.5)
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	
	
