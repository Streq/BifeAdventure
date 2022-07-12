extends Node


var A : ButtonState = null
var B = false
var C = false
var shift = false
var dir = Vector2()

func get_facing_dir():
	return Vector2(dir.x * Bool.to_signf(get_parent().facing_right), dir.y)

func _ready():
	pass


