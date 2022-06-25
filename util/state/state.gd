extends Node

class_name State

signal finished(next_state_name)
signal unlocked()
signal exited()

export var stunned = false

var locked = false setget set_locked,is_locked


func is_locked():
	return locked
	
func set_locked(val):
	if !val and locked:
		emit_signal("unlocked")
	locked = val

# Initialize the state. E.g. change the animation
func enter():
	pass

# Clean up the state. Reinitialize values like a timer
func exit():
	return

func handle_input(event):
	return

func update(delta):
	return

func _on_animation_finished(anim_name):
	return

func _exit():
	emit_signal("exited")
	exit()



