extends Node

export (int) var pj

onready var U = "up"+str(pj)
onready var D = "down"+str(pj)
onready var L = "left"+str(pj)
onready var R = "right"+str(pj)
onready var A = "A"+str(pj)
onready var B = "B"+str(pj)

func get_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed(R)) - int(Input.is_action_pressed(L))
	input_direction.y = int(Input.is_action_pressed(D)) - int(Input.is_action_pressed(U))
	return input_direction

func get_jump():
	return Input.is_action_just_pressed(A)
	
func is_pressing_jump():
	return Input.is_action_pressed(A)

func get_attack():
	return Input.is_action_just_pressed(B)
