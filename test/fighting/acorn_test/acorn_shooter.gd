extends Node2D

export var ACORN : PackedScene
export var speed := 200.0
export var time := 1.0 setget set_time
export var lag := 0.0 setget set_lag
export var enabled := true setget set_enabled

onready var gunpoint = $gunpoint

var ready = false
func _ready():
	ready = true
	if !lag:
		call_deferred("_on_Lag_timeout")
	else:
		$Lag.wait_time = lag
		$Lag.start()
	

func set_enabled(val):
	if !ready:
		yield(self,"ready")
	if enabled!=val:
		enabled = val
		$Timer.paused = !enabled

func set_time(val):
	if !ready:
		yield(self,"ready")
	if time!=val:
		time = val
		$Timer.wait_time = time

func set_lag(val):
	lag = val
	

func _on_timeout():
	if enabled:
		var acorn = ACORN.instance()
		get_tree().current_scene.add_child(acorn)
		acorn.global_position = gunpoint.global_position
		acorn.global_rotation = gunpoint.global_rotation
		acorn.velocity = Vector2(1.0,0.0).rotated(global_rotation)*speed
	


func _on_Lag_timeout():
	_on_timeout()
	$Timer.start()
