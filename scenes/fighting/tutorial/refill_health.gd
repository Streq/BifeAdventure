extends Node

export var speed = 10.0
func _physics_process(delta):
	var parent = get_parent()
	parent.health += delta*speed
