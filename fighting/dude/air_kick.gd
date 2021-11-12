extends "res://util/state/state.gd"

export var jab : PackedScene

var hitbox
var active_hitbox := false

func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play("air_kick")
#	owner.velocity.x += 50.0*owner.dir
	hitbox = jab.instance()

func update(delta):
	var p = owner
	p._move(delta)
	
	var controller = owner.get_node("controller")
	
	var input_direction = controller.get_direction()
	var jump = controller.get_jump()
	var attack = controller.get_attack()
	
	
	if p.is_on_floor():
		emit_signal("finished", "idle", null)

func _on_animation_finished(anim_name):
	emit_signal("finished", "air", null)
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
