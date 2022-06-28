extends Node

func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	fighter.velocity.x = lerp(fighter.velocity.x, 0.0, delta*8.0)
