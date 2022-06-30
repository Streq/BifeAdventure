extends Node

export var state_to := "air"
export (float, 0.0, 60.0) var friction := 0.0

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
	fighter.velocity.y = lerp(fighter.velocity.y, 0.0, delta * friction)
	#to prevent flickering between air and wall states
	if fighter.input_state.dir.x != fighter.get_facing_dir():
		fighter.velocity.x -= fighter.get_facing_dir()
	else:
		fighter.velocity.x += fighter.get_facing_dir()

