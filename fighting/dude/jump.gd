extends "res://util/state/state.gd"

var frame_counter := 0
var charge_counter := 0
export var duration_frames := 3

var half_jump_factor = 0.6

func enter():
	frame_counter = 0
	charge_counter = 0
	owner.get_node("AnimationPlayer").play("jump")
	
func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	frame_counter += 1
	if controller.is_pressing_jump():
		charge_counter += 1
	
	if !p.is_on_floor() or frame_counter > duration_frames:
		emit_signal("finished", "air", null)
	elif frame_counter == duration_frames:
		if charge_counter == frame_counter:
			p.velocity.y -= p.jump
		else:
			p.velocity.y -= p.jump*half_jump_factor