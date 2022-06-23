extends Label

func _ready():
	visible = Globals.DEBUG


func _on_state_state_changed(current_state):
	text = current_state
