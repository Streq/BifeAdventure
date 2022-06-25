extends Node2D
signal finish(next_state, params)
signal enter(params)
signal entered()
signal exit
signal process(delta)
signal physics_process(delta)
signal animation_finished

var root : Node = owner

func _ready():
	exit()

func enter(params):
	_enter(params)
	emit_signal("enter", params)
	emit_signal("entered")

func exit():
	_exit()
	emit_signal("exit")

func process(delta: float):
	_idle_update(delta)
	emit_signal("process", delta)

func physics_process(delta: float):
	_physics_update(delta)
	emit_signal("physics_process", delta)

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

func goto(state: String):
	emit_signal("finish", state, null)

func goto_args(state: String, args: Array):
	emit_signal("finish", state, args)


func _on_animation_finished(anim_name):
	match anim_name:
		"enter":
			emit_signal("animation_finished")
		"exit":
			pass
