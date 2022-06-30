extends Node
tool

export var direction := Vector2.RIGHT setget set_direction
export (float, -360.0, 360.0) var direction_degrees := 0.0 setget set_direction_degrees
var direction_rads := 0.0



func set_direction(val : Vector2):
	if val:
		direction = val.normalized()
		direction_rads = direction.angle()
		direction_degrees = rad2deg(direction_rads)
	else:
		direction = val
		direction_rads = NAN
		direction_degrees = NAN
	property_list_changed_notify()

var timeout_counter = 0
func set_direction_degrees(val : float):
	
	if is_nan(val):
		direction = Vector2.ZERO
	else:
		direction = Vector2.RIGHT.rotated(deg2rad(val))
	direction_degrees = val
	direction_rads = deg2rad(val)
	property_list_changed_notify()
#	if Engine.editor_hint:
#		#shitty hack to prevent update during sliding
#		timeout_counter += 1
#		yield(get_tree().create_timer(0.5),"timeout")
#		timeout_counter -= 1
#		if !timeout_counter:
#			property_list_changed_notify()
	
	
