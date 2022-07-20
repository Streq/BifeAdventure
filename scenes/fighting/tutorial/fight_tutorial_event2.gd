extends Node2D
signal player_is_still()

onready var player : Fighter = get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries
onready var dummy := $dummy
onready var controller = player.get_node("controller")
onready var progress = $progress



var is_player_still = false
var played = false
var check_player = false

var during = ""

func _ready():
	set_physics_process(false)
	
func play(body):
	var tree = get_tree()
	if played:
		return
	played = true
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
		"PEPE: excepto ahora, que vas a tener que usar el ATAQUE que yo te diga"
	])
	yield(Textbox, "text_display_finished")
	
	controller.enabled = true
	set_boundaries_disabled(false)
	
	var spawn_position = dummy.get_node("spawn_position")
	spawn_position.value = $spawn0.global_position
	$guide/text.visible = true
	$guide/text.text = "apretar X estando QUIETO hace un JAB (APRETAR VARIAS VECES PARA HACER UN COMBO)"
	yield(wait_on_hit_times("cross", 3), "completed")
	$guide/text.text = "X CAMINANDO es un SIDE-JAB"
	
	spawn_position.value = $spawn1.global_position
	yield(wait_on_hit_times("f_tilt", 3), "completed")
	$guide/text.text = "X CORRIENDO es un TACKLE"
	spawn_position.value = $spawn2.global_position
	yield(wait_on_hit_times("dash", 3), "completed")
	$guide/text.text = "X QUIETO y APRETANDO ARRIBA es un UPPERCUT"
	scold_on("u_air", "SIN SALTAR", "u_tilt")
	yield(wait_on_hit_times("u_tilt", 3), "completed")
	spawn_position.value = $spawn3.global_position
	$guide/text.text = "X en el AIRE y apretando NINGUNA DIRECCION es una PATADA VOLADORA"
	scold_on("f_air", "DIJE NINGUNA DIRECCION", "n_air")
	
	yield(wait_on_hit_times("n_air", 3), "completed")
	$guide/text.text = "X en el AIRE y apretando ADELANTE es un GOLPE que hacen mucho en DRAGON BALL Z"
	yield(wait_on_hit_times("f_air", 3), "completed")
	$guide/text.text = "X en el AIRE y apretando ARRIBA es un UPPERCUT AEREO"
	spawn_position.value = $spawn4.global_position
	
	yield(wait_on_hit_times("u_air", 3), "completed")
	$guide/text.text = "X en el AIRE y apretando ABAJO es UNA PATADA ESCALONERA"
	spawn_position.value = $spawn5.global_position
	
	yield(wait_on_hit_times("d_air", 3), "completed")
	$guide/text.text = "BIEN BIFE LA CONCHA DE TU MADRE"
	spawn_position.value = $spawn6.global_position
	
	
	
	controller.enabled = false
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
	controller.enabled = true
	
	
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
		
func wait_on_hit_times(name, times):
	during = name
	for i in times:
		_progress_changed(i, times)
		yield(wait_on_hit(name), "completed")
	_progress_changed(times, times)

	yield(get_tree().create_timer(1.0),"timeout")

func _progress_changed(current, requirement):
	progress.text = "%d/%d" % [current, requirement]
	if current == requirement:
		progress.modulate = Color.green
	else:
		progress.modulate = Color.red
			

func wait_on_hit(name):
	while true:
		yield(dummy, "health_changed")
		if player.state.current.name == name:
			break
func scold_on(actual_attack, scold_text, expected_attack):
	var t = $guide/text.text
	#hack to ensure this happens AFTER the yield for the expected attack
	while during != expected_attack:
		yield(get_tree(),"idle_frame")
		
	while during == expected_attack:
		yield(wait_on_hit(actual_attack), "completed")
		if during == expected_attack:
			$guide/text.text = scold_text
		yield(get_tree().create_timer(1.0), "timeout")
		if during == expected_attack:
			$guide/text.text = t
		
		
	
