extends Node


var x_vel = 0.0

func _ready():
	get_parent().connect("physics_process", self, "physics_process")
	get_parent().connect("entered", self, "entered")
func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	fighter.velocity.x = x_vel
func entered():
	x_vel = get_parent().root.velocity.x
