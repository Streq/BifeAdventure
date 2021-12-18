extends Node2D

var body = null
var dir = 1.0
func _ready():
	scale.x = -1.0 if get_parent().dir < 0.0 else 1.0
	$hitbox.body = body
	pass
	

