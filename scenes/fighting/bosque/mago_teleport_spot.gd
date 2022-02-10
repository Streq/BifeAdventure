extends Node2D

signal mago_exited()


func _on_Area2D_body_exited(body):
	if body.is_in_group("mago"):
		emit_signal("mago_exited")
