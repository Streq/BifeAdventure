extends Node2D

var positions = {}

func _ready():
	$checkpoints.current_checkpoint = $bife.position
	$bife.connect("dead",self,"player_lose")

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

var lost = false
func player_lose():
	if !lost:
		lost = true
		yield(get_tree().create_timer(2.0),"timeout")
		Textbox.add_text("TROPEZON NO ES CAIDA BIFE")
		Textbox.add_text("NI SIQUIERA EN EL TUTORIAL")
		Textbox.add_text("DONDE SOLO MUEREN LOS PeTeS")
		Textbox.add_text("FUERZA")
		yield(Textbox,"text_display_finished")
		Globals.respawn()
