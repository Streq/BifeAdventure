extends Node2D

func _ready():
	set_process_input(false)
	

func _input(event):
	if event.is_action_pressed("A0"):
		_start_fight()

func _start_fight():
	pass
