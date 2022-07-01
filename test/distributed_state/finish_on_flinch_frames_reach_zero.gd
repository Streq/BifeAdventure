extends Node

func _ready():
	get_parent().connect("physics_process", self, "physics_process")
	
func physics_process(delta):
	var state = get_parent()
	var fighter = state.root
	if fighter.flinch_frames == 0:
		state.emit_signal("animation_finished")
