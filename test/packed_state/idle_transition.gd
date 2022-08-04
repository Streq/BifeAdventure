extends Node
export var end_state := ""
export var enabled := true
func _ready():
	get_parent().connect("animation_finished", self, "trigger")
	
func trigger():
	if enabled:
		get_parent().goto(end_state)
