extends Node
class_name FighterState

signal finish(next_state, params)
signal enter(params)
signal entered()
signal exit
signal process(delta)
signal physics_process(delta)
signal animation_finished

export var animation := ""
var root : Fighter = owner
var active = false


func enter(params):
	active = true
	_enter(params)
	var anim = root.state_animation
	#setup
	anim.connect("animation_finished", self, "on_animation_finished")
	anim.play(animation)
	anim.advance(0)
	
	emit_signal("enter", params)
	emit_signal("entered")
	
	
func on_animation_finished(name):
	_on_animation_finished(name)
	if name == animation:
		emit_signal("animation_finished")
	

func exit():
	active = false
	var anim = root.state_animation
	anim.disconnect("animation_finished", self, "on_animation_finished")
	#cleanup
	anim.play("RESET")
	anim.advance(0)
	_exit()
	emit_signal("exit")
	
func process(delta: float):
	_idle_update(delta)
	emit_signal("process", delta)

func physics_process(delta: float):
	_physics_update(delta)
	emit_signal("physics_process", delta)

func goto(state: String):
	if active:
		emit_signal("finish", state, null)

func goto_args(state: String, args: Array):
	if active:
		emit_signal("finish", state, args)

#OVERRIDABLE FUNCTIONS

# Initialize the state. E.g. change the animation
func _enter(params):
	pass

# Clean up the state. Reinitialize values like a timer
func _exit():
	return

# Called during _process
func _idle_update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	return

# Called during _input
func _handle_input(event: InputEvent):
	return

func _on_animation_finished(name: String):
	return
