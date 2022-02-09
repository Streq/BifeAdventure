extends Node2D

export var amount := 100.0


func _on_body_entered(body):
	if body.is_in_group("player"):
		heal(body)
		queue_free()

func heal(body):
	body.health += amount
