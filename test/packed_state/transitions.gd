extends Node

onready var state = get_parent()

func _ready():
	state.connect("physics_process", self, "check")
	
func check(delta):
	for transition in get_children():
		if transition.check(state):
			state.goto(transition.end_state)
			break
