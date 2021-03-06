extends "res://util/state/state.gd"

export var animation := "ram"
export var speed := 200.0
export var speed_lerp := 30.0
export var self_knockback := Vector2(100, -200)

var can_move = false

func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play(animation)
	can_move = false
	locked = true
	owner.activate_hitbox("ram")

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var jump = controller.get_jump()
	
	p.velocity.x = lerp(p.velocity.x, p.dir * speed,  delta * speed_lerp)
	
	if !p.is_on_floor():
		emit_signal("finished", "air", null)
	elif p.is_on_wall():
		var count = p.get_slide_count()
		if count != 0:
			var normal = p.get_slide_collision(0).normal
			if -normal.x == p.dir:
				emit_signal("finished", "dizzy", null)
				# bump
				p.velocity = Vector2(normal.x,1)*self_knockback
	elif can_move:
		if jump:
			emit_signal("finished", "jump", null)
	
func _on_animation_finished(anim_name):
	emit_signal("finished", "idle", null)
	
func exit():
	owner.deactivate_hitbox("ram")

func enable_movement():
	can_move = true
