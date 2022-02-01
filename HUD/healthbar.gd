extends Node

func _on_health_changed(val, max_val):
	var current = val/max_val*100.0
	set("value", current)
