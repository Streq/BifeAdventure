extends "res://util/state/state.gd"


func enter():
	owner.get_node("AnimationPlayer").play("dizzy")
	$Timer.start()

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	if p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	else:
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.air_idle_lerp)
	
	
func exit():
	var p = owner
	p.get_node("Sprite").position.x = 0

func _on_Timer_timeout():
	emit_signal("finished", "idle", null)
