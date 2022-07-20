extends Node2D

var x : float setget set_x, get_x
var y : float setget set_y, get_y
var value : Vector2

func set_x(val):
	value.x = val
func get_x():
	return value.x
func set_y(val):
	value.y = val
func get_y():
	return value.y


func _ready():
	value = global_position

