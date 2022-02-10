extends Node2D

signal is_hurt_enough_to_teleport()

var is_hurt_enough_to_teleport = 0



signal start_timer()

func start_spawner():
#	emit_signal("start_timer")
	pass
	
func set_strategy(name):
	$mago/controller/strategy._change_state(name, null)


func _on_mago_health_changed(val, max_health):
	var missing_health = max_health - val
	if missing_health > (1+is_hurt_enough_to_teleport)*50.0:
		emit_signal("is_hurt_enough_to_teleport")
		is_hurt_enough_to_teleport = int(missing_health/50.0)
