extends Node2D
signal player_is_still()


onready var player : Fighter= get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries

var is_player_still = false
var played = false
var check_player = false
func _ready():
	set_physics_process(false)

func play(body):
	if played:
		return
	played = true
	var controller = player.get_node("controller")
	controller.enabled = false
	set_physics_process(true)
	check_player = true
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
		"PEPE: con X pegas.",
		"Nada, eso, dale una prueba."
	])
	yield(Textbox, "text_display_finished")
	
	$guide/text.visible = true
	controller.enabled = true
	set_boundaries_disabled(false)
	
	yield($dummys0, "all_dead")
	controller.enabled = false
	check_player = true
	yield(self, "player_is_still")
	Textbox.add_texts([
		"PEPE: muy BIEN BIFE",
		"BIFE: 8===D",
		"PEPE: ahora viene lo interesante, tambien puedes hacer ataques distintos",
		"PEPE: dependiendo la DIRECCION que estes APRETANDO al momento de ATACAR, y si estas CORRIENDO, en el AIRE, CAMINANDO, o QUIETO", 
		"PEPE: Dejo a tu CRITERIO cuando usar que ATAQUE"
	])
	yield(Textbox, "text_display_finished")
	
	tween.interpolate_property(camera, "global_position", 
		camera.global_position, 
		current_camera.global_position, 
		1.0,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		)
	tween.start()
	yield(tween, "tween_all_completed")
	set_boundaries_disabled(true)
	controller.enabled = true
	
	current_camera.current = true
	
func _physics_process(delta):
	if player.velocity.length_squared() < 5.0:
		if check_player:
			emit_signal("player_is_still")
			is_player_still = true
			player.velocity = Vector2.ZERO
			check_player = false
	else:
		is_player_still = false
func set_boundaries_disabled(val):
	for i in boundaries.get_shape_owners():
		var shape_owner = boundaries.shape_owner_get_owner(i)
		shape_owner.disabled = val
