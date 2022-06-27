extends Node
export var end_state := ""

func _ready():
	get_parent().connect("animation_finished", self, "trigger")
	
func trigger():
	get_parent().goto(end_state)
