extends Node
signal state_changed(state)

export (String) var start_state
export (NodePath) onready var root = (get_node(root) if is_instance_valid(root) else owner) as Node



var current = null
var states:= {}
export var autostart := false

func _ready():
	yield(root,"ready")
	if autostart:
		initialize()
	else:
		pause(true)
	

func initialize():
	for state in get_children():
		states[state.name] = state
		state.connect("finish", self, "_change_state")
		state.root = root
	current = states[start_state]
	current.enter(null)
	pause(false)
	
func _process(delta: float):
	process(delta)

func _physics_process(delta: float):
	physics_process(delta)

func process(delta: float):
	current.process(delta)
	
func physics_process(delta: float):
	current.physics_process(delta)

func _input(event: InputEvent):
	current._handle_input(event)

func _change_state(state_name: String, params):
	current.exit()
	current = states[state_name]
	current.enter(params)
	emit_signal("state_changed", state_name)

func pause(paused: bool):
	var val = !paused
	set_process(val)
	set_process_input(val)
	set_process_internal(val)
	set_process_unhandled_input(val)
	set_process_unhandled_key_input(val)
	set_physics_process(val)
	set_physics_process_internal(val)

