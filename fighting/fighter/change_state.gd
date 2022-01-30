extends Node

export var state := "idle"

var used = false
func trigger(knockback):
	if !used:
		used = true
		owner.state._change_state(state,null)
		set_deferred("used", false)
