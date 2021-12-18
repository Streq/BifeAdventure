extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _input(event):
	if event.is_action_pressed("A1"):
		$ViewportContainer/Viewport.get_texture().get_data().save_png("res://lmao.png")
