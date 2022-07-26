extends Node

signal conditions_met
signal conditions_not_met

export (Globals.EVENT, FLAGS) var mustve_happened
export (Globals.EVENT, FLAGS) var mustve_not_happened

func _ready():
	get_tree().current_scene.connect("ready", self, "trigger")
	Globals.connect("events_changed", self, "trigger")
func trigger():
	if (
		Globals.event_flags & mustve_happened == mustve_happened and
		Globals.event_flags & mustve_not_happened == 0
	):
		emit_signal("conditions_met")
	else:
		emit_signal("conditions_not_met")
