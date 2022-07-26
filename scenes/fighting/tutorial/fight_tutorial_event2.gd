extends Node2D
signal player_is_still()

onready var player : Fighter = get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var player_camera : Camera2D = player.get_node("Camera2D")
onready var tween := $Tween
onready var boundaries = $boundaries
onready var dummy := $dummy
onready var controller = player.get_node("controller")
onready var progress = $progress



var is_player_still = false
onready var played = Globals.get_event(Globals.EVENT.tutorial_completed)
var check_player = false

var during = ""

func _ready():
	set_physics_process(false)
	
func play(body):
	yield(get_tree(),"idle_frame")
	get_parent().monitoring = false
	get_parent().monitorable = false
	var tree = get_tree()
	var spawn_position = dummy.get_node("spawn_position")
	
	if played:
		spawn_position.value = $orbit/finish.global_position
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
		"PEPE: ahora viene lo interesante, tambien puedes hacer ataques distintos",
		"PEPE: dependiendo la DIRECCION que estes APRETANDO al momento de ATACAR",
		"PEPE: y si estas CORRIENDO, en el AIRE, CAMINANDO, o QUIETO", 
		"PEPE: dejo a tu CRITERIO cuando usar que ATAQUE"
	])
	yield(Textbox, "text_display_finished")
	controller.enabled = true
	set_boundaries_disabled(false)
	
	yield(get_tree().create_timer(1.0),"timeout")
	
	Textbox.add_texts([
		"PEPE: excepto ahora, que vas a tener que usar el ATAQUE que yo te diga"
	])
	yield(Textbox, "text_display_finished")
	
	controller.enabled = true
	set_boundaries_disabled(false)
	
	
	
	$guide/text.visible = true
	
	$guide/text.text = "apretar X estando QUIETO hace un JAB (APRETAR VARIAS VECES PARA HACER UN COMBO)"
	spawn_position.value = $orbit/jab.global_position
	yield(wait_on_hit_times("cross", 3), "completed")
	
	$guide/text.text = "X CAMINANDO es un SIDE-JAB"
	spawn_position.value = $orbit/f_tilt.global_position
	yield(wait_on_hit_times("f_tilt", 3), "completed")
	
	$guide/text.text = "X CORRIENDO es un TACKLE"
	spawn_position.value = $orbit/dash.global_position
	yield(wait_on_hit_times("dash", 3), "completed")
	
	$guide/text.text = "X QUIETO y APRETANDO ARRIBA es un UPPERCUT"
	spawn_position.value = $orbit/u_tilt.global_position
	scold_on("u_air", "SIN SALTAR", "u_tilt")
	yield(wait_on_hit_times("u_tilt", 3), "completed")
	
	$guide/text.text = "X en el AIRE y apretando NINGUNA DIRECCION es una PATADA VOLADORA"
	spawn_position.value = $orbit/n_air.global_position
	scold_on("f_air", "DIJE NINGUNA DIRECCION", "n_air")
	yield(wait_on_hit_times("n_air", 3), "completed")
	
	$guide/text.text = "X en el AIRE y apretando ADELANTE es un GOLPE que hacen mucho en DRAGON BALL Z"
	spawn_position.value = $orbit/n_air.global_position
	yield(wait_on_hit_times("f_air", 3), "completed")
	
	$guide/text.text = "X en el AIRE y apretando ARRIBA es un UPPERCUT AEREO"
	spawn_position.value = $orbit/u_air.global_position
	yield(wait_on_hit_times("u_air", 3), "completed")
	
	$guide/text.text = "X en el AIRE y apretando ABAJO es UNA PATADA ESCALONERA"
	spawn_position.value = $orbit/d_air.global_position
	yield(wait_on_hit_times("d_air", 3), "completed")
	
	$guide/text.text = "SOS UN GENIO BIFE"
	spawn_position.value = $orbit/finish.global_position
	
	done = true
	
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
	
onready var clone = $guide/pepe_clone
var done = false
func _physics_process(delta):
	if player.velocity.length_squared() < 5.0:
		if check_player:
			emit_signal("player_is_still")
			is_player_still = true
			player.velocity = Vector2.ZERO
			check_player = false
	else:
		is_player_still = false
		
	if !is_instance_valid(clone) and !done:
		done = true
		player_camera.global_position = camera.global_position
		player_camera.current = true
		tween.interpolate_property(player_camera, "position", 
			player_camera.position, 
			Vector2.ZERO, 
			1.0,
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
			)
		controller.enabled = false
		tween.start()
		yield(tween,"tween_all_completed")
		controller.enabled = true
		queue_free()
	
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
	var previous_health = 0.0
		
	while true:
		var health = yield(dummy, "health_changed")
		var current_health = health[0]
		var lost_health = current_health < previous_health
		previous_health = current_health
		if lost_health and player.state.current.name == name:
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
		
		
	
