extends Reference
class_name ButtonState

var state := 0

enum STATE {
	UNPRESSED = 0,		#000
	PRESSED = 1,		#001
	JUST_UNPRESSED = 2,	#010
	JUST_PRESSED = 3,	#011
	ANY = 4 			#100
}

func check(expected) -> bool:
	return (
		(expected == STATE.ANY) or
		(expected & state == expected)
	)

func update(pressed : bool):
	var v = int(pressed)
	state = (((state ^ v) << 1) | v) & 3

func is_pressed() -> bool:
	return bool(state & 1)

func is_just_updated() -> bool:
	return bool(state & 2)

func is_just_pressed() -> bool:
	return state == STATE.JUST_PRESSED

func is_just_released() -> bool:
	return state == STATE.JUST_UNPRESSED

