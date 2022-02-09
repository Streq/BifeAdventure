extends Node2D



export var textbox_path: NodePath
onready var textbox : TextBox = get_node(textbox_path)
export var player_camera_path: NodePath
onready var player_camera : Camera2D = get_node(player_camera_path)

func trigger():
	yield(text_prompt(["???: ALTO AHI"]), "completed")
	yield(move_camera_to_focus(), "completed")
	yield(text_prompt([
		"???: Soy el brujo tutujo", 
		"TUTUJO: y te vua mata",
		"BIFE: xq???", 
		"TUTUJO: porque estoy cansado de los transeuntes, esta es mi casa, prohibido el paso", 
		"BIFE: que es un transeunte",
		"TUTUJO: alguien que pasa",
		"BIFE: pero tu casa es el unico paso que conecta mi pueblo con un almacen",
		"BIFE: yo no estoy aca de joda, yo me levanto todos los dias a laburar, 9 a 6, para mantener a mi familia",
		"BIFE: ahora justo estoy yendo a comprar una sopapa para mi hijo pelado",
		"BIFE: si no la consigo no se va a poder usar el baño",
		"BIFE: el unico baño en mi pueblo",
		"BIFE: (es posta todo esto)",
		"TUTUJO: me importa un carajo",
		"BIFE: bue"
		]), "completed")
	
	

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
	$Tween.interpolate_property(camera, "global_position", current_position, final_position, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
