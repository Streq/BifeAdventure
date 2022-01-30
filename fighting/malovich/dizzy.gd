extends "res://util/state/state.gd"

var timeout = false
func enter():
	owner.get_node("AnimationPlayer").play("dizzy")
	timeout = false
	$Timer.start()
	
func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	if p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	else:
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.air_idle_lerp)
	if timeout:
		emit_signal("finished", "idle", null)
	
	
func exit():
	var p = owner
	p.pivot.position.x = 0

func _on_Timer_timeout():
	timeout = true
