extends Node2D



export var player_path: NodePath
onready var player : OldFighter = get_node(player_path)
export var player_camera_path: NodePath
onready var player_camera : Camera2D = get_node(player_camera_path)
export var walls_path: NodePath
onready var walls : TileMap = get_node(walls_path)
export var boss_healthbar_path: NodePath
onready var boss_healthbar : TextureProgress = get_node(boss_healthbar_path)

export var boss_node : PackedScene

onready var controller = player.get_node("controller")

func trigger():
	controller.enabled = false
	
	yield(text_prompt(["???: ALTO AHI"]), "completed")
	var boss = boss_node.instance()
	owner.add_child(boss)
	var mago = boss.get_node("mago")
	
	$boss_teleport_positions.mago = mago
	boss.connect("is_hurt_enough_to_teleport", $boss_teleport_positions, "teleport")
	
	yield(move_camera_to_focus(), "completed")
	yield(text_prompt([
		"???: Soy el brujo tutujo",
		"BIFE: ah",
		"TUTUJO: y te voy a matar",
		"BIFE: xq?????",
		"TUTUJO: porque tengo los huevo al plato de la gente que va y viene haciendo bochinche y rompiendo todo",
		"TUTUJO: esta es mi casa y a partir de ahora esta prohibido el paso",
		"BIFE: el bosque entero es tu casa?",
		"TUTUJO: si",
		"BIFE: y cuchame tutuje",
		"TUTUJO: tutujo",
		"BIFE: tutujo, a vos te parece bien adueñarte del unico camino entre mi pueblo y un almacen?",
		"BIFE: yo tengo una familia con necesidades",
		"BIFE: te parece bien que mi hijo pelado no tenga sopapa para destapar el baño?",
		"TUTUJO: a vos te parece bien que te recague a cascotazos?",
		"BIFE: sos re malo :(",
		"TUTUJO: ustedes son re malos, pisando mi pasto, pateando mis animalitos, meando en MIS arboles",
		"TUTUJO: decile al imbecil de tu hijo pelado que cague en el piso",
		"TUTUJO: te tendria que matar",
		"BIFE: es un poco mucho esto que decis",
		"TUTUJO: y no es un poco mucho fajar a cuatro de mis mascotas?",#TODO hacer un counter
		"BIFE: esos cositos son tus mascotas?",
		"TUTUJO: si ",
		"TUTUJO: hijo de la mierda",
		"BIFE: mira, si te hace sentir mejor, mis trompadas los hicieron felices, tengo poderes",
		"TUTUJO: vos me estas pelotudeando?",
		"BIFE: te juro que no",
		"TUTUJO: y yo te juro que hoy ",
		]), "completed")
	
	yield(lower_walls(), "completed")
	yield(fill_boss_healthbar(), "completed")
	mago.connect("health_changed", boss_healthbar, "_on_health_changed")

	yield(text_prompt([
		"TUTUJO: te mato",
		"BIFE: fua"
		]), "completed")
	
	boss.set_strategy("aim_attack")
	boss.start_spawner()
	controller.enabled = true
	
	yield(mago, "dead")
	$boss_teleport_positions.queue_free()
	$walls_sprite.queue_free()
	
	yield(get_tree().create_timer(1.0), "timeout")
	yield(text_prompt([
		"TUTUJO: ahhh la cadera"
		]), "completed")
	
	boss_healthbar.visible = false
	
	yield(move_focus_to_camera(), "completed")


func _on_boss_fight_event_zone_body_entered(body):
	$boss_fight_event_zone.queue_free()
	trigger()
	


func text_prompt(text):
	Textbox.add_texts(text)
	yield(Textbox,"text_display_finished")

func move_camera_to_focus():
	var camera = $Camera2D
	var current_position = player_camera.global_position
	var final_position = camera.global_position
	camera.current = true
	camera.global_position = current_position
	$Tween.interpolate_property(camera, "global_position", current_position, final_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")

func move_focus_to_camera():
	var camera = $Camera2D
	var current_position = camera.global_position
	var final_position = player_camera.global_position
	$Tween.interpolate_property(camera, "global_position", current_position, final_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	player_camera.current = true
	

func lower_walls():
	for i in range(0,15):
		walls.position.y += 16
		yield(get_tree().create_timer(0.05),"timeout")

func fill_boss_healthbar():
	boss_healthbar.value = 0
	boss_healthbar.visible = true
	boss_healthbar.step = 5
	$Tween.interpolate_property(boss_healthbar, "value", 0, 100, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	boss_healthbar.step = 1
