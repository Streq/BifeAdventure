extends "res://util/state/state.gd"

export var fireball : PackedScene


func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play("fireball")
	
func update(delta):
	var p = owner
	p._move(delta)
	
	
	if p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x, 0,  delta * p.idle_lerp)
	


func _on_animation_finished(anim_name):
	if owner.is_on_floor():
		emit_signal("finished", "idle", null)
	else:
		emit_signal("finished", "air", null)

func cast_fireball():
	var controller = owner.get_node("controller")
	var input_direction = controller.get_direction()
	
	var ball = fireball.instance()
	var caster = owner
	var world = caster.owner
	ball.direction = input_direction.normalized()
	ball.caster = caster
	ball.dir = sign(caster.dir)
	world.add_child(ball)
	ball.global_position = caster.global_position
