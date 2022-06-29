extends Node

enum H_COLLISION_SIDE {
	ANY = 0,
	BACKWARDS = -1,
	FORWARD = 1
}

export var should_be_true := true
export var state_to := "air"
export (H_COLLISION_SIDE) var side := H_COLLISION_SIDE.ANY

func _ready():
	get_parent().connect("physics_process", self, "physics_process")

func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	if fighter.is_against_wall(side) == should_be_true:
		state.goto(state_to)
