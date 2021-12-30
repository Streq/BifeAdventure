extends Label

func _ready():
	visible = OS.is_debug_build()


func _on_state_state_changed(current_state):
	text = current_state.name
