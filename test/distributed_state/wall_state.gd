extends Node

export var should_be_true := true
export var state_to := "air"

func _ready():
	get_parent().connect("physics_process", self, "physics_process")
	get_parent().connect("entered", self, "entered")

func entered():
	var state = get_parent()
	var fighter = state.root
	if fighter.is_against_wall(1):
		fighter.facing_right = !fighter.facing_right
	
func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	fighter.velocity.y = 0
	
#	fighter.velocity.x = lerp(fighter.velocity.x, fighter.get_facing_dir(), delta * 4.0)
