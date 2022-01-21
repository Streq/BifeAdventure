extends "res://util/state/state.gd"

export var sprite_name := "hands"
export var animation := "jab"

onready var display = owner.get_node("pivot/display/"+sprite_name)


var active_hitbox := false
var can_move = false

func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play(animation)
	can_move = false
	locked = true
	

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	var attack = controller.get_attack()
	
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)
	elif p.is_on_wall():
		var count = p.get_slide_count()
		if count != 0:
			var normal = p.get_slide_collision(0).normal
			if -normal.x == p.dir:
				emit_signal("finished", "wall", null)
				# stick to the wall
				p.velocity.x = lerp(p.velocity.x, p.dir, delta * p.speed_lerp * 0.5)

func _on_animation_finished(anim_name):
	emit_signal("finished", "idle", null)
	
func exit():
	owner.emit_signal("state_exit")
	display.visible = false
	
	
func enable_movement():
	can_move = true
