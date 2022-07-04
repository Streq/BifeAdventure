extends Area2D
class_name Hitbox
tool

signal activate()
signal deactivate()

export var active := true setget set_active

var touched_hitboxes = []
var touched_hurtboxes = []

func _physics_process(delta):
	#ensure hitboxes are processed first
	for hitbox in touched_hitboxes:
		on_hitbox(hitbox)
	touched_hitboxes = []
	
	for hurtbox in touched_hurtboxes:
		on_hurtbox(hurtbox)
	touched_hurtboxes = []

func set_active(val):
	active = val
	for i in get_shape_owners():
		shape_owner_set_disabled(i, !val)
	monitorable = val
	monitoring = val
	visible = val
	if val:
		emit_signal("activate")
	else:
		emit_signal("deactivate")

func get_body():
	return get_parent().get_body()

func on_hitbox(hitbox):
	pass
func on_hurtbox(hitbox):
	pass
func _on_hitbox(hitbox):
	touched_hitboxes.append(hitbox)
func _on_hurtbox(hitbox):
	touched_hurtboxes.append(hitbox)
