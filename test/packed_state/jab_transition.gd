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
enum PRESS_STATE {
	UNPRESSED = 0,		#000
	PRESSED = 1,		#001
	JUST_UNPRESSED = 2,	#010
	JUST_PRESSED = 3,	#011
	ANY = 4 			#100
}
export var end_state := ""
export (PRESS_STATE) var A := PRESS_STATE.ANY
export (PRESS_STATE) var B := PRESS_STATE.ANY
export (PRESS_STATE) var C := PRESS_STATE.ANY
export (H_DIR) var horizontal_dir := H_DIR.ANY
export (V_DIR) var vertical_dir := V_DIR.ANY

func check_input(expected_state, input_state):
	return ButtonState.check(expected_state, input_state)

func check_dir(expected_dir, input_dir):
	return (
		( expected_dir == H_DIR.ANY ) or
		( expected_dir == H_DIR.NEUTRAL and !input_dir ) or
		( expected_dir == input_dir )
	)



func bool_to_sign(b:bool):
	return 1 if b else -1


func check(begin_state) -> bool:
	var i = begin_state.root.input_state
	var d = i.get_facing_dir()
	if d.x:
#		breakpoint
		pass
	return (
		check_input(A, i.A) &&
		check_input(B, i.B) &&
		check_input(C, i.C) &&
		check_dir(horizontal_dir, d.x) &&
		check_dir(vertical_dir, d.y)
	)
