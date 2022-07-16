extends Node
class_name FighterStateBuffer

const BUFFER_SIZE = 10

var buffer := CircularBuffer.new(BUFFER_SIZE)
var null_state = BufferedState.new("",0.0)
var current_state : BufferedState = null_state
var cleared = true

#connected to the state_machine's physics_process
func _physics_update(delta):
	current_state.time += delta

func _on_state_changed(new_state:String):
	current_state = BufferedState.new(new_state, 0.0)
	buffer.push_back(current_state)
	cleared = false

func clear():
	cleared = true
	buffer.clear()
	buffer.set_at(0,null_state)
	
	
