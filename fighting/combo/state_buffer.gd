extends Node

export var IDLE_STATES : PoolStringArray
export var FINISHER_STATES : PoolStringArray

const MAX_IDLE_TIME = 1.0
const BUFFER_SIZE = 10


var buffer := Array()
var null_state = BufferedState.new("")
var current_state : BufferedState = null_state

#connected to the state_machine's physics_process
func _physics_update(delta):
	current_state.time += delta
	if (current_state.time >= MAX_IDLE_TIME and
		current_state.name in IDLE_STATES
	):
		clear()

func _on_state_changed(new_state:String):
	if buffer.size()>BUFFER_SIZE:
		pass
	buffer.push_back(current_state)
	
	current_state = BufferedState.new(new_state)
	if new_state in FINISHER_STATES:
		clear()

class BufferedState:
	var name : String
	var time : float
	func _init(name):
		self.name = name
		self.time = 0.0

func clear():
	buffer = [null_state]
