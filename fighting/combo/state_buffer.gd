extends Node

export var IDLE_STATES : PoolStringArray
export var FINISHER_STATES : PoolStringArray

const MAX_IDLE_TIME = 1.0
const BUFFER_SIZE = 10


var buffer := CircularBuffer.new(BUFFER_SIZE)
var null_state = BufferedState.new("",0.0)
var current_state : BufferedState = null_state
var cleared = true
#connected to the state_machine's physics_process
func _physics_update(delta):
	current_state.time += delta
	if (!cleared and
		current_state.time >= MAX_IDLE_TIME and
		current_state.name in IDLE_STATES
	):
		clear()

func _on_state_changed(new_state:String):
	current_state = BufferedState.new(new_state, 0.0)
	buffer.push_back(current_state)
	cleared = false
	if new_state in FINISHER_STATES:
		clear()

class BufferedState:
	var name : String
	var time : float
	func _init(name, time):
		self.name = name
		self.time = time

func clear():
	cleared = true
	buffer.clear()
	buffer.set_at(0,null_state)
	
	
