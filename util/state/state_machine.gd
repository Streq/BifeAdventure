extends Node

class_name StateMachine

signal state_changed(current_state)


export(NodePath) var START_STATE
var states_map = {}

var states_stack = []
var current_state = null
var current := ""
var _active = false setget set_active

var animation_queue := []


func _ready():
	for child in get_children():
		states_map[child.name] = child
		child.connect("finished", self, "_change_state")
		child.connect("unlocked", self, "_next_state")
	initialize(START_STATE)

func initialize(start_state):
	set_active(true)
	states_stack.push_front(get_node(start_state))
	current_state = states_stack[0]
	_enter()
	emit_signal("state_changed", current_state.name)

func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null

func _input(event):
	current_state.handle_input(event)

func _physics_process(delta):
	current_state.update(delta)

func _on_animation_finished(anim_name):
	if not _active:
		return
	if !animation_queue.empty():
		_change_state(animation_queue.pop_front(), null)
	else:
		current_state._on_animation_finished(anim_name)

func _change_state(state_name, param):
	if not _active:
		return
	current_state._exit()
	animation_queue.clear()
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state.name)
	
	if state_name != "previous":
		_enter()

func _change_state_soft(state_name, param):
	if current_state.is_locked():
		animation_queue.push_back(state_name)
	else:
		_change_state(state_name, param)

func _next_state():
	if !animation_queue.empty():
		_change_state(animation_queue.pop_front(), null)

func _enter():
	current_state.enter()
	current = current_state.name
	
