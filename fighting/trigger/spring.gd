extends Node


export var impulse : Vector2

func trigger(knockback):
	owner.velocity += impulse*Vector2(sign(knockback.x),1.0)
