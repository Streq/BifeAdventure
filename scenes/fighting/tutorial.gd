extends Node2D

var positions = {}

func _ready():
	$checkpoints.current_checkpoint = $bife.position

func load_position(key):
	if positions.has(key):
		$bife.position = positions[key]
		$bife.velocity = Vector2.ZERO

func save_position(key):
	positions[key] = $bife.position
	

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode > KEY_0 and event.scancode < KEY_9:
			if event.shift:
				save_position(event.scancode)
			else:
				load_position(event.scancode)


func _on_killzone_body_entered(body):
	if body.is_in_group("player"):
		$checkpoints.respawn($bife)
