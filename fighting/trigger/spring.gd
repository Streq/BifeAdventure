extends Node


export var impulse : Vector2

var used := false

func trigger(knockback):
	if !used:
		used = true
		owner.velocity += impulse*Vector2(sign(knockback.x),1.0)
		set_deferred("used", false)
