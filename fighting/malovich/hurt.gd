extends "res://util/state/state.gd"

func enter():
	owner.get_node("AnimationPlayer").play("hurt")
	
func update(delta):
	var p = owner
	p._move(delta, true)
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
