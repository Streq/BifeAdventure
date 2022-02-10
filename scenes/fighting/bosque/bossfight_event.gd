extends Node2D



export var textbox_path: NodePath
onready var textbox : TextBox = get_node(textbox_path)
export var player_path: NodePath
onready var player : Fighter = get_node(player_path)
export var player_camera_path: NodePath
onready var player_camera : Camera2D = get_node(player_camera_path)
export var walls_path: NodePath
onready var walls : TileMap = get_node(walls_path)

export var boss_node : PackedScene

func trigger():
	player.controller.enabled = false
	
	yield(text_prompt(["???: ALTO AHI"]), "completed")
	var boss = boss_node.instance()
	owner.add_child(boss)
	var mago = boss.get_node("mago")
	
	$boss_teleport_positions.mago = mago
	boss.connect("is_hurt_enough_to_teleport", $boss_teleport_positions, "teleport")
	
	yield(move_camera_to_focus(), "completed")
	yield(text_prompt([
		"???: Soy el brujo tutujo", 
		"TUTUJO: y te vua mata",
		"BIFE: porq???", 
		"TUTUJO: porque tengo los huevo al plato de la gente que pasa haciendo bochinche, esta es mi casa, prohibido el paso", 
#		"BIFE: que es un transeunte?",
#		"TUTUJO: alguien que pasa",
		"BIFE: pero tu casa es el unico lugar que conecta mi pueblo con un almacen",
		"BIFE: yo no estoy aca por joder, tengo una familia con necesidades",
		"BIFE: ahora justo estoy yendo a comprar una sopapa para mi hijo pelado",
		"BIFE: si no la consigo no se va a poder usar el baño",
		"BIFE: el unico baño en todo el pueblo",
		"BIFE: (es posta todo esto)",
		"TUTUJO: me importa un carajo te dije", 
		"BIFE: no me dijiste",
		"TUTUJO: si te dije",
		"TUTUJO: por ahi no prestaste atencion por que sos medio boludo",
		"BIFE: bue",
		"TUTUJO: decile a tu hijo pelado que cague en el pasto",
		"BIFE: me parece medio mala leche lo que propones",
#		"TUTUJO: aparte no te creo que ese grandote boludo que esta a la entrada sea tu hijo, parece tu tio",
#		"BIFE: no se d qien m ablas,,",
#		"TUTUJO: si sabes, ya vino una vez y lo saque cagando",
		"TUTUJO: date media vuelta porque empiezo a los cascotazos",
		"BIFE: che y si paso despacito, tipo sin apretar shift?",
		"TUTUJO: a donde?"
		]), "completed")
	
	yield(lower_walls(), "completed")
	
	yield(text_prompt([
		"BIFE: fua"
		]), "completed")
	
	boss.set_strategy("aim_attack")
	boss.start_spawner()
	player.controller.enabled = true
	
	yield(mago, "dead")
	$boss_teleport_positions.queue_free()
	$walls_sprite.queue_free()
	


func _on_boss_fight_event_zone_body_entered(body):
	$boss_fight_event_zone.queue_free()
	trigger()
	


func text_prompt(text):
	textbox.add_texts(text)
	yield(textbox,"text_display_finished")

func move_camera_to_focus():
	var camera = $Camera2D
	var current_position = player_camera.global_position
	var final_position = camera.global_position
	camera.current = true
	camera.global_position = current_position
	$Tween.interpolate_property(camera, "global_position", current_position, final_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")

func lower_walls():
	for i in range(0,15):
		walls.position.y += 16
		yield(get_tree().create_timer(0.05),"timeout")


