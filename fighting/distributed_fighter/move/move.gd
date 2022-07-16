extends Node

export (PoolStringArray) var states_from
export (String) var state_to

#{jab(), idle(0.0, 0.2), jab(), idle(0.0, 0.2)}
var requirement := []

func check(state_buffer: CircularBuffer):
	for i in requirement.size():
		var backwards_index = -i-1
		var requirement = requirement[backwards_index]
		var buffered = state_buffer[backwards_index]
		if (
			(buffered.state != requirement.state) or
			(
				(requirement.min_time >= 0.0) and 
				(buffered.time < requirement.min_time)
			) or (
				(requirement.max_time >= 0.0) and 
				(buffered.time > requirement.max_time)
			)
		):
			return false
	return true
