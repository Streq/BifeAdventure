extends "res://fighting/controller.gd"

onready var buttonA = InputButton.new()
onready var buttonB = InputButton.new()
onready var buttonC = InputButton.new()

var target = null

var attack:bool setget,get_attack
var special_attack:bool setget,get_special
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
	
func is_pressing_attack():
	return buttonB.is_pressed
	
func get_special():
	return buttonC.just_pressed

func is_pressing_special():
	return buttonC.is_pressed

func _physics_process(delta):
	buttonA.clear_frame()
	buttonB.clear_frame()
	buttonC.clear_frame()
	if $strategy.current_state:
		$strategy.current_state.handle(owner, self)

func _target_distance():
	if is_instance_valid(target):
		return target.position - owner.global_position
	return Vector2.ZERO

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
