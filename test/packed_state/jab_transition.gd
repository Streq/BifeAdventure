extends Node

enum H_DIR {
	BACKWARD = -1,
	ANY = 0,
	FORWARD = 1,
	NEUTRAL = 2
}

enum V_DIR {
	UP = -1,
	ANY = 0,
	DOWN = 1,
	NEUTRAL = 2
}

export var end_state := ""
export (ButtonState.STATE) var A := ButtonState.STATE.ANY
export (ButtonState.STATE) var B := ButtonState.STATE.ANY
export (ButtonState.STATE) var C := ButtonState.STATE.ANY
export (H_DIR) var horizontal_dir := H_DIR.ANY
export (V_DIR) var vertical_dir := V_DIR.ANY

func check_dir(expected_dir, input_dir):
	return (
		( expected_dir == H_DIR.ANY ) or
		( expected_dir == H_DIR.NEUTRAL and !input_dir ) or
		( expected_dir == input_dir )
	)



func bool_to_sign(b:bool):
	return 1 if b else -1


func check(begin_state) -> bool:
	var input = begin_state.root.input_state
	var d = input.get_facing_dir()
	if d.x:
#		breakpoint
		pass
	if C == ButtonState.STATE.UNPRESSED:
		input.C.satisfies(C)
	return (
		input.A.satisfies(A) &&
		input.B.satisfies(B) &&
		input.C.satisfies(C) &&
		check_dir(horizontal_dir, d.x) &&
		check_dir(vertical_dir, d.y)
	)
