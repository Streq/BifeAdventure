extends Node

var step_counter : int = 0 setget set_step_counter

var spawn_tile = null

func set_step_counter(val):
	step_counter = val
	print_debug("steps:", val)
