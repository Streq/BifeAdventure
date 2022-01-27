extends Area2D

var body = null

func _init():
	body = owner

func _activate_deferred():
	visible = true
	monitorable = true
	monitoring = true

func _deactivate_deferred():
	visible = false
	monitorable = false
	monitoring = false
	
func activate():
	call_deferred("_activate_deferred")

func deactivate():
	call_deferred("_deactivate_deferred")
