extends "res://util/state/state.gd"

export var jab : PackedScene
export var animation := "jab"

var hitbox
var active_hitbox := false
var can_move = false

func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play(animation)
	hitbox = jab.instance()
	hitbox.body = owner
	can_move = false
	locked = true
	

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	var attack = controller.get_attack()
	
	p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	
	if !p.is_on_floor():
		emit_signal("finished", "air", null)
	elif can_move:
		if jump:
			emit_signal("finished", "jump", null)
		elif input_direction.x:
			emit_signal("finished", "run", null)

func _on_animation_finished(anim_name):
	emit_signal("finished", "idle", null)
	
func exit():
	deactivate_hitbox()
	
func activate_hitbox():
	if !active_hitbox:
		owner.call_deferred("add_child",hitbox)
		active_hitbox = true
		
func deactivate_hitbox():
	if active_hitbox:
		owner.call_deferred("remove_child",hitbox)
		active_hitbox = false

func enable_movement():
	can_move = true

func step_forward(amount):
	owner.velocity.x += amount*owner.dir
