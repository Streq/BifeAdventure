extends Node2D

func _ready():
	$AnimationPlayer.play("anim")
	$AnimationPlayer.advance(0)
