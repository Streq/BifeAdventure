extends Node2D
signal player_is_still()


onready var player : Fighter= get_tree().get_nodes_in_group("player")[0]
onready var camera := $Camera2D
onready var tween := $Tween
onready var boundaries = $boundaries
onready var guide = $guide

export var CLONE : PackedScene

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
		"PEPE: bueno BIFE, ya sabes todo lo que deberias saber, queda solo una cosa",
		"PEPE: PONERLO A PRUEBA",
		"PEPE: cague un jean no jutsu"
	])
	
	yield(Textbox, "text_display_finished")
	
	
	controller.enabled = true
	set_boundaries_disabled(false)
	
	var clone = yield(create_clone(),"completed")
	yield(clone, "tree_exited")
	Textbox.add_texts([
		"PEPE: MUY BIEN BIFE",
		"PEPE: a ver AHORA"
	])
	
	yield(Textbox, "text_display_finished")
	
	clone_amount = 8
	for i in clone_amount:
		clone = yield(create_clone(),"completed")
		clone.connect("tree_exited", self, "clone_died")
	yield(self,"clones_dead")
	
	Textbox.add_texts([
		"PEPE: la verdad BIFE me quito el sombrero, los cagaste a palos",
		"PEPE: te diria de pelear contra mi pero la ultima vez que hice eso termine con la perimetral",
		"PEPE: no me queda nada mas que enseñarte BIFE",
		"PEPE: chau ANDATE"
	])
	
	yield(Textbox, "text_display_finished")
	
signal clones_dead
var clone_amount = 0
func clone_died():
	clone_amount -= 1
	if clone_amount == 0:
		emit_signal("clones_dead")

var clone_side = -1.0
func create_clone():
	var clone = CLONE.instance()
	get_tree().current_scene.add_child(clone)
	clone.set_physics_process(false)
	
	clone.global_position = guide.global_position
	tween.interpolate_property(guide,"global_position",guide.global_position, guide.global_position+Vector2(-8*clone_side,0),1.0)
	tween.interpolate_property(clone,"global_position",clone.global_position, clone.global_position+Vector2(8*clone_side,0),1.0)
	
	tween.start()
	
	
	yield(tween,"tween_all_completed")
	clone.set_physics_process(true)
	clone_side *= -1.0
	return clone
	
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
		
	
