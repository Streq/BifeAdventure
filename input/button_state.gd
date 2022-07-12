extends Reference
class_name ButtonState

var state := 0

enum STATE {
	UNPRESSED 		=0b000,
	PRESSED			=0b001,
	JUST_UNPRESSED	=0b010,
	JUST_PRESSED	=0b011,
	ANY				=0b100
}

func satisfies(expected) -> bool:
	return (
		(expected == STATE.ANY) or
		(expected & state == expected)
	)

func update(pressed : bool):
	var v = int(pressed)
	state = (((state ^ v) << 1) | v) & 0b11

func is_pressed() -> bool:
	return bool(state & 1)

func is_just_updated() -> bool:
	return bool(state & 0b10)

func is_just_pressed() -> bool:
	return state == STATE.JUST_PRESSED

func is_just_released() -> bool:
	return state == STATE.JUST_UNPRESSED

