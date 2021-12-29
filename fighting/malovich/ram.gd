extends "res://util/state/state.gd"

export var animation := "ram"
export var speed := 200.0
export var speed_lerp := 30.0

onready var hitbox = owner.get_node("pivot/hitbox/ram")
var active_hitbox := false
var can_move = false

func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play(animation)
	can_move = false
	locked = true
	activate_hitbox()
	

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
				p.velocity = Vector2(normal.x*100, -200)
	elif can_move:
		if jump:
			emit_signal("finished", "jump", null)
	
func _on_animation_finished(anim_name):
	emit_signal("finished", "idle", null)
	
func exit():
	deactivate_hitbox()
	
func activate_hitbox():
	if !active_hitbox:
		hitbox.monitoring = true
		hitbox.monitorable = true
		active_hitbox = true

func deactivate_hitbox():
	if active_hitbox:
		hitbox.monitoring = false
		hitbox.monitorable = false
		active_hitbox = false

func enable_movement():
	can_move = true
