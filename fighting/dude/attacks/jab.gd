extends Node2D

var damage = 2.0
var knockback = Vector2(100.0, 100.0)

func _ready():
	scale.x = -1.0 if get_parent().dir < 0.0 else 1.0

func _on_Area2D_body_entered(body):
	if body != get_parent() and body.is_in_group("fighter"):
		body.velocity += Vector2(get_parent().dir, -1.0)*knockback
		body.health -= damage
		body.dir = -get_parent().dir
		body.get_node("state")._change_state("hurt", null)
