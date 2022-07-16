extends Node
var end_state = "cross"


func check(begin_state) -> bool:
	var input : InputState = begin_state.root.input_state
	var state_buffer : FighterStateBuffer = begin_state.root.state_buffer
	
	if !input.B.is_just_pressed():
		return false
	var expected = ["jab","jab_return","jab","jab_return"]
	for i in range(-1, -expected.size()-1, -1):
		var actual_state : BufferedState = state_buffer.buffer.at(i)
#		var expected_state : StateComboStep = expected[i]
#		if actual_state.name != expected_state.state_name:
		if actual_state.name != expected[i]:
			return false
	return true
