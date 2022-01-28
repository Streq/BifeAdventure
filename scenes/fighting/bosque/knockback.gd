extends Node

export var knockback : Vector2 = Vector2.ZERO


func apply_knockback(target, hitbox):
	var knock = knockback*Vector2(-target.dir,1.0)
	hitbox.emit_signal("applied_knockback",knock)
	target.velocity = knock
	if knock.x:
		target.dir = -sign(knock.x)
