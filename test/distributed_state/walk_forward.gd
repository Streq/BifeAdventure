extends Node

func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	fighter.velocity.x = fighter.get_facing_dir()*fighter.walk_speed
