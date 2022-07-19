extends Node
var end_state = "cross"


func check(begin_state) -> bool:
	var input : InputState = begin_state.root.input_state
	var state_buffer : FighterStateBuffer = begin_state.root.state_buffer
	
	if !input.B.is_just_pressed():
		return false
#	var expected = ["jab","jab_return","jab","jab_return"]
	var expected = [{
			name="jab",
			optional=false,
		},{
			name="jab_return",
			optional=true,
		},{
			name="jab",
			optional=false,
		},{
			name="jab_return",
			optional=true,
		}]
	
	var i = -1
	var j = -1
	var finish_i = -expected.size()-1
	var finish_j = -state_buffer.buffer.size-1
	while i != finish_i:
		var actual_state : BufferedState = state_buffer.buffer.at(j)
		var expected_state = expected[i]
		i-=1
		if actual_state.name == expected_state.name:
			j-=1
			if j == finish_j:
				return false
		elif !expected_state.optional:
			return false
	return true
