extends Node

export (int) var pj

onready var U = "up"+str(pj)
onready var D = "down"+str(pj)
onready var L = "left"+str(pj)
onready var R = "right"+str(pj)
onready var A = "A"+str(pj)
onready var B = "B"+str(pj)
onready var C = "C"+str(pj)

onready var buttonA = InputButton.new()
onready var buttonB = InputButton.new()
onready var buttonC = InputButton.new()

var attack:bool setget,get_attack
var special_attack:bool setget,get_special
var jump:bool setget,get_jump
var direction:Vector2 setget,get_direction

func _init():
	process_priority = 10

func get_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed(R)) - int(Input.is_action_pressed(L))
	input_direction.y = int(Input.is_action_pressed(D)) - int(Input.is_action_pressed(U))
	return input_direction

func get_jump():
	return buttonA.just_pressed
	
func is_pressing_jump():
	return buttonA.is_pressed

func get_attack():
	return buttonB.just_pressed

func is_pressing_attack():
	return buttonB.is_pressed
	
func get_special():
	return buttonC.just_pressed

func is_pressing_special():
	return buttonC.is_pressed


func _input(event):
	if !event.is_echo():
		if event.is_action(A):
			buttonA.pressed(event.is_pressed())
		if event.is_action(B):
			buttonB.pressed(event.is_pressed())
		if event.is_action(C):
			buttonC.pressed(event.is_pressed())

func _physics_process(delta):
	buttonA.clear_frame()
	buttonB.clear_frame()
	buttonC.clear_frame()

class InputButton extends Node:
	var is_pressed := false
	var just_updated := false
	var just_pressed := false
	var just_released := false
	
	
	func clear_frame():
		just_updated = false
		just_pressed = false
		just_released = false
	
	func pressed(val):
		is_pressed = val
		just_updated = true
		if(val):
			just_pressed = true
		else:
			just_released = true
