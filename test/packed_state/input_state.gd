extends Node


var A : ButtonState = ButtonState.new()
var B : ButtonState = ButtonState.new()
var C : ButtonState = ButtonState.new()
var dir = Vector2()

func get_facing_dir():
	return Vector2(dir.x * Bool.to_signf(get_parent().facing_right), dir.y)

func _ready():
	pass


