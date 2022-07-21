extends Node

export var flip_h : bool = false
export var enabled : bool = true setget set_enabled

func set_enabled(val):
	enabled = val
	set_physics_process(enabled)
	if enabled:
		#to prevent jumping at the end of a dialog
		update_inputs()
		get_parent().input_state.clear_updated()
	if !enabled:
		get_parent().input_state.clear()
	
func _physics_process(delta):
	update_inputs()
func update_inputs():
	var input = get_parent().input_state

	input.A.update(Input.is_action_pressed("A0"))
	input.B.update(Input.is_action_pressed("B0"))
	input.C.update(Input.is_action_pressed("C0"))

	input.dir.x = float(Input.is_action_pressed("right0")) - float(Input.is_action_pressed("left0"))
	if flip_h:
		input.dir.x *= -1.0
	input.dir.y = float(Input.is_action_pressed("down0")) - float(Input.is_action_pressed("up0"))
	
