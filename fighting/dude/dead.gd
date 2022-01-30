extends "res://util/state/state.gd"

var was_on_air = false

func enter():
	owner.get_node("AnimationPlayer").play("hurt")
	owner.emit_signal("dead")
	was_on_air = false
	
func update(delta):
	var p = owner
	p._move(delta)
	
	if p.is_on_floor():
		if p.health > 0.0:
			emit_signal("finished", "idle", null)
		elif was_on_air:
			p.get_node("AnimationPlayer").play("dead")
			p.get_node("status_animation").play("flicker_and_die")
			p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
		else:
			p.velocity+=Vector2(100.0*-p.dir,-150.0)
	else:
		was_on_air = true
		owner.get_node("AnimationPlayer").play("hurt")
		if p.health > 0.0:
			emit_signal("finished", "air", null)
