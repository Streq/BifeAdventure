extends Node2D


export var active := false setget set_active

func activate():
	set_active(true)

func deactivate():
	set_active(false)
	
func set_active(val):
	for hitbox in get_children():
		hitbox.call_deferred("set_active",val)

func get_body():
	return owner
