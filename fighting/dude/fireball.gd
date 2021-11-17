extends "res://util/state/state.gd"

export var fireball : PackedScene


func enter():
	owner.get_node("AnimationPlayer").stop()
	owner.get_node("AnimationPlayer").play("fireball")
	
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

func _on_animation_finished(anim_name):
	emit_signal("finished", "idle", null)

func cast_fireball():
	var ball = fireball.instance()
	var caster = owner
	var world = caster.owner
	ball.direction = Vector2(caster.dir, 0)
	ball.caster = caster
	ball.dir = caster.dir
	world.add_child(ball)
	ball.global_position = caster.global_position
