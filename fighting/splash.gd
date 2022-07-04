extends Node2D


func _ready():
	pass


func _on_animation_finished(anim_name):
	queue_free()
