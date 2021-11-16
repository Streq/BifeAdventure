extends Node2D

var direction := Vector2.ZERO
var speed := 200

func _physics_process(delta):
	position += speed * direction * delta
