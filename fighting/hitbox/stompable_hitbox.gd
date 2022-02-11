extends "res://fighting/hitbox/hitbox.gd"

export var stomp_knock := -100.0
export var stomp_damage := 40.0


func _init():
	body = owner

func _activate_deferred():
	visible = true
	monitorable = true
	monitoring = true

func _deactivate_deferred():
	visible = false
	monitorable = false
	monitoring = false
func activate():
	call_deferred("_activate_deferred")

func is_stomped_by(target):
	return target.global_position.y < (global_position.y)


func deactivate():
	call_deferred("_deactivate_deferred")
	
func is_whitelisted(target):
	return target == body or target == caster or body.get("team") and body.team == target.team

func apply_damage(target):
	if is_stomped_by(target):
		owner.health -= stomp_damage
	else:
		emit_signal("applied_damage")
		target.health -= damage
	
func apply_knockback(target):
	if is_stomped_by(target):
		target.velocity.y = stomp_knock
		owner.status_animation.play("hurt")
		owner.state._change_state("hitstun", null)
		owner.velocity.x = 0
		owner.velocity.y += 100
		
	else:
		var knock = knockback*Vector2(body.dir,1.0)
		emit_signal("applied_knockback",knock)
		target.velocity = knock
		if knock.x:
			target.dir = -sign(knock.x)

func get_hitstun(target):
	return hitstun and !is_stomped_by(target)


func get_knockdown(target):
	return knockdown and !is_stomped_by(target)
