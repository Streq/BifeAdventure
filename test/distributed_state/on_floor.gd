extends Node

export var should_be_true := true
export var state_to := ""

func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	if fighter.is_on_floor() == should_be_true:
		state.goto(state_to)
