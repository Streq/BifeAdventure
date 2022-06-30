extends Hitbox
tool

export var knockback := 0.0
export var damage := 0.0

#if several hitboxes of this attack land on the same frame, only the one with lowest priority will land
export var hit_priority := 0

export var clang := true

export var direction := Vector2.RIGHT setget set_direction
export var direction_degrees := 0.0 setget set_direction_degrees
var direction_rads := 0.0

func affect(hurtbox: Area2D):
	var fighter = get_body()
	
	hurtbox.receive_flinch()
	hurtbox.receive_damage(damage)
	hurtbox.receive_knockback(direction * Vector2(fighter.get_facing_dir(), 1.0) * knockback)
	
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

	
func set_direction_degrees(val : float):
	if is_nan(val):
		direction = Vector2.ZERO
	else:
		direction = Vector2.RIGHT.rotated(deg2rad(val))
	direction_degrees = val
	direction_rads = deg2rad(val)
	property_list_changed_notify()
