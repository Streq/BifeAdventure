extends Node
tool

export var direction := Vector2.RIGHT setget set_direction
export var isolated_direction_x := 1.0 setget set_direction_x
export var isolated_direction_y := 0.0 setget set_direction_y

export (float, -360.0, 360.0) var direction_degrees := 0.0 setget set_direction_degrees
var direction_rads := 0.0

export (bool) var _update setget _update

func _update(val):
	set_direction(Vector2(isolated_direction_x,isolated_direction_y))
	property_list_changed_notify()

func set_direction(val : Vector2):
	if val:
		direction = val.normalized()
		direction_rads = direction.angle()
		direction_degrees = rad2deg(direction_rads)
	else:
		direction = val
		direction_rads = NAN
		direction_degrees = NAN
	isolated_direction_x = direction.x
	isolated_direction_y = direction.y

func set_direction_degrees(val : float):
	if is_nan(val):
		self.direction = Vector2.ZERO
	else:
		self.direction = Vector2.RIGHT.rotated(deg2rad(val))
	

func set_direction_x(val):
	isolated_direction_x = val
func set_direction_y(val):
	isolated_direction_y = val
