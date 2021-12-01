extends Node2D

var positions = {}

func _ready():
	$checkpoints.current_checkpoint = $dude.position

func load_position(key):
	if positions.has(key):
		$dude.position = positions[key]
		$dude.velocity = Vector2.ZERO

func save_position(key):
	positions[key] = $dude.position
	

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode > KEY_0 and event.scancode < KEY_9:
			if event.shift:
				save_position(event.scancode)
			else:
				load_position(event.scancode)


func _on_killzone_body_entered(body):
	if body.is_in_group("player"):
		$checkpoints.respawn($dude)
