extends Node


export var impulse : Vector2

func trigger(knockback):
	owner.velocity += impulse
