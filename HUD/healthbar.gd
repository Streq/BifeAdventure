extends Node

func _ready():
	owner.connect("health_changed", self, "_on_health_changed")

func _on_health_changed(val, max_val):
	var current = val/max_val*100.0
	set("value", current)
