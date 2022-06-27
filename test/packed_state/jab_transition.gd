extends Node

export var end_state := ""
func check(begin_state) -> bool:
	return begin_state.root.input_state.B
