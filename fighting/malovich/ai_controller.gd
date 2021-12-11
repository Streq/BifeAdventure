extends "res://fighting/controller.gd"

onready var buttonA = InputButton.new()
onready var buttonB = InputButton.new()
onready var buttonC = InputButton.new()

var target = null

var attack:bool setget,get_attack
var special_attack:bool setget,get_special_attack
var jump:bool setget,get_jump
var direction:Vector2 = Vector2.ZERO



func _ready():
	if get_tree().has_group("player"):
		target = get_tree().get_nodes_in_group("player")[0]

func _init():
	process_priority = 10


func get_direction() -> Vector2:
	return direction

func get_jump() -> bool:
	return buttonA.just_pressed
	
func is_pressing_jump() -> bool:
	return buttonA.is_pressed

func get_attack() -> bool:
	return buttonB.just_pressed
	
func get_special_attack() -> bool:
	return buttonC.just_pressed

func _physics_process(delta):
	buttonA.clear_frame()
	buttonB.clear_frame()
	buttonC.clear_frame()
	if target:
		var dist : Vector2= _target_distance()
		direction.x = sign(dist.x)
		var length_squared : float = dist.length_squared()
		if(length_squared < 48*48):
			buttonB.pressed(true)
		if(length_squared > 128*128):
			buttonC.pressed(true)
	
	
	
	

func _target_distance():
	if target:
		return target.position - get("global_position")

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
