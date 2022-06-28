extends Node

func _ready():
	get_parent().connect("animation_finished", self, "jump")

func jump():
	var fighter = get_parent().root
	fighter.velocity.y -= fighter.jump_speed
