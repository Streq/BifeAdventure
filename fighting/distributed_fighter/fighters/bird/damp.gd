extends Node


export var damp := 0.0


func _physics_update(delta):
	owner.velocity *= (1.0-damp*delta)
