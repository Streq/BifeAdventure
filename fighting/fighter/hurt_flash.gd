extends Node

onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "timeout")

func trigger():
	var parent = get_parent()
	parent.modulate.r = 1
	parent.modulate.g = 0
	parent.modulate.b = 0
	timer.start()
	
func timeout():
	var parent = get_parent()
	parent.modulate.r = 1
	parent.modulate.b = 1
	parent.modulate.g = 1
