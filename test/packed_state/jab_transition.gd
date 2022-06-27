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
	UNPRESSED = -1,
	ANY = 0,
	PRESSED = 1,
	NEUTRAL = 2
}
export var end_state := ""
export (PRESS_STATE) var A := PRESS_STATE.ANY
export (PRESS_STATE) var B := PRESS_STATE.ANY
export (PRESS_STATE) var C := PRESS_STATE.ANY
export (H_DIR) var horizontal_dir := H_DIR.ANY
export (V_DIR) var vertical_dir := V_DIR.ANY

func check_input(i,state):
	return (
		i == 0 or 
		( i == 2 and !state ) or 
		i == state
	)

func bool_to_sign(b:bool):
	return 1 if b else -1


func check(begin_state) -> bool:
	var i = begin_state.root.input_state
	return (
		check_input(A, bool_to_sign(i.A)) &&
		check_input(B, bool_to_sign(i.B)) &&
		check_input(C, bool_to_sign(i.C)) &&
		check_input(horizontal_dir, i.dir.x) &&
		check_input(vertical_dir, i.dir.y)
	)
