extends Node2D
signal player_is_still()


onready var player : Fighter= get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries
onready var dummy := $dummy


var is_player_still = false
var played = false
var check_player = false
func _ready():
	set_physics_process(false)

func play(body):
	if played:
		return
	played = true
	player.controller.enabled = false
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
		"PEPE: excepto ahora, que vas a tener que usar el ATAQUE que yo te diga"
	])
	yield(Textbox, "text_display_finished")
	
	player.controller.enabled = true
	set_boundaries_disabled(false)
	
	$guide/text.visible = true
	$guide/text.text = "X QUIETO es un JAB (APRETAR VARIAS VECES PARA HACER UN COMBO)"
	yield(wait_on_hit("jab"), "completed")
	yield(wait_on_hit("jab2"), "completed")
	yield(wait_on_hit("jab3"), "completed")
	$guide/text.text = "X CAMINANDO es un SIDE-JAB"
	yield(wait_on_hit("side_jab"), "completed")
	$guide/text.text = "X CORRIENDO es un TACKLE"
	yield(wait_on_hit("tackle"), "completed")
	$guide/text.text = "X QUIETO y APRETANDO ARRIBA es un UPPERCUT"
	yield(wait_on_hit("utilt"), "completed")
	
	dummy.spawn_point.y -= 32.0
	$guide/text.text = "X en el AIRE y apretando NADA es una PATADA VOLADORA"
	yield(wait_on_hit("air_kick"), "completed")
	$guide/text.text = "X en el AIRE y apretando ADELANTE es un GOLPE que hacen mucho en DRAGON BALL Z"
	yield(wait_on_hit("fair"), "completed")
	$guide/text.text = "X en el AIRE y apretando ARRIBA es un UPPERCUT AEREO"
	dummy.spawn_point.y -= 16.0
	yield(wait_on_hit("uair"), "completed")
	$guide/text.text = "X en el AIRE y apretando ABAJO es UNA PATADA ESCALONERA (sirve para GANAR ALTURA)"
	dummy.spawn_point.y += 16
	dummy.spawn_point.x += 64
	
	
	player.controller.enabled = false
	current_camera.global_position = camera.global_position
	current_camera.current = true
	tween.interpolate_property(current_camera, "position", 
		current_camera.position, 
		Vector2.ZERO, 
		1.0,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		)
	tween.start()
	set_boundaries_disabled(true)
	player.controller.enabled = true
	
	
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
	yield(get_tree(),"idle_frame")
	for i in boundaries.get_shape_owners():
		var shape_owner = boundaries.shape_owner_get_owner(i)
		shape_owner.disabled = val
		
func wait_on_hit(name):
	while yield(player.state, "state_changed") != name:
		pass
	yield(dummy, "hurt")
	
