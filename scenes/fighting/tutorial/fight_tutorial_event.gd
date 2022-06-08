extends Node2D
signal player_is_still()


onready var player : Fighter= get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries

var is_player_still = false
var played = false
func _ready():
	set_physics_process(false)

func play(body):
	if played:
		return
	played = true
	player.controller.enabled = false
	set_physics_process(true)
	
	yield(self, "player_is_still")
	
	#transition camera
	var target_camera_pos = camera.global_position
	var current_camera = player.get_node("Camera2D")
	camera.global_position = current_camera.global_position
	camera.current = true
	
	tween.interpolate_property(camera, "global_position", 
		camera.global_position, 
		target_camera_pos, 
		1.0,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		)
	tween.start()
	yield(tween, "tween_all_completed")
	
	Textbox.add_texts([
		"PEPE: bueno, ya veo que sos un REY del PARCUR, ahora falta aprender a cagarte a PIÑAS",
		"BIFE: 8===D",
		"PEPE: vamos primero a lo BASICO:", 
		"PEPE: con X pegas.\nNada, eso, dale una prueba."
	])
	yield(Textbox, "text_display_finished")
	
	$guide/text.visible = true
	player.controller.enabled = true
	for i in boundaries.get_shape_owners():
		var shape_owner = boundaries.shape_owner_get_owner(i)
		shape_owner.disabled = false
	
	yield($dummys0, "all_dead")
	Textbox.add_texts([
		"PEPE: muy BIEN BIFE",
		"BIFE: 8===D",
		"PEPE: ahora viene lo interesante, tambien puedes hacer ataques distintos",
		"PEPE: dependiendo la DIRECCION que estes APRETANDO al momento de ATACAR", 
		"PEPE: Dejo a tu CRITERIO cuando usar que ATAQUE"
	])
	yield(Textbox, "text_display_finished")
	
func _physics_process(delta):
	if !is_player_still and player.velocity.length_squared() < 25.0:
		emit_signal("player_is_still")
		is_player_still = true
		player.velocity = Vector2.ZERO
