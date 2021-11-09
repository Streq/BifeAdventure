extends "res://util/state/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("air")
	

func update(delta):
	var p = owner
	p._move(delta)
	p.velocity.y -= p.jump
	
	emit_signal("finished", "air", null)
