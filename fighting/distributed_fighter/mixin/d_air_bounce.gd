extends Node

export var impulse := 0.0

func trigger_one_arg(knockback):
	trigger()
	
func trigger():
	owner.velocity.y = min(impulse, owner.velocity.y+impulse)
