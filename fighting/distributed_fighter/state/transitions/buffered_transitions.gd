extends Node

onready var state = get_parent()

var current_transition = -1

func _ready():
#	state.connect("physics_process", self, "physics_process")
	state.connect("entered", self, "entered")
	state.connect("exit", self, "exit")
	state.connect("animation_finished", self, "trigger")
	set_physics_process(false)

func entered():
	current_transition = get_children().size()
	set_physics_process(true)

func exit():
	set_physics_process(false)

# needs to process even when the fighter is paused 
# so that inputs aren't ignored
func _physics_process(delta):
	physics_process(delta)

func physics_process(delta):
	check()

func check():
	var transitions = get_children()
	for i in current_transition:
		if transitions[i].check(state):
			current_transition = i
			break
		i+=1
	

func trigger():
	if current_transition != get_children().size():
		state.goto(get_children()[current_transition].end_state)
