extends Area2D
class_name Hitbox
tool

export var active := true setget set_active

func set_active(val):
	active = val
	for i in get_shape_owners():
		shape_owner_set_disabled(i, !val)
	monitorable = val
	monitoring = val
	visible = val
