extends Node2D
signal player_is_still()


onready var player : Fighter= get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries
onready var clone = $pepe_clone

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
		"PEPE: bueno BIFE, ya sabes todo lo que deberias saber, queda solo una cosa: ponerlo a prueba",
		"PEPE: cague un jean noyu tsu"
	])
	yield(Textbox, "text_display_finished")
	
	
	
	
	controller.enabled = true
	set_boundaries_disabled(false)
	
	
	
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
		
	
