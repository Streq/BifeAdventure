extends Node

export var impulse := 0.0

func trigger(knockback: Vector2):
	owner.velocity.y = min(impulse, owner.velocity.y+impulse)
