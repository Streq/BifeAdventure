extends "res://util/state/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("hurt")
	
func update(delta):
	var p = owner
	p._move(delta)
	
	if p.is_on_floor():
		if p.health > 0.0:
			emit_signal("finished", "idle", null)
		else:
			p.get_node("AnimationPlayer").play("dead")
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	else:
		owner.get_node("AnimationPlayer").play("hurt")
		if p.health > 0.0:
			emit_signal("finished", "air", null)
