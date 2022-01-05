extends Node2D


func _input(event):
	if event.is_action_pressed("A0"):
		$AnimationPlayer.play()
		$Label.visible = false
