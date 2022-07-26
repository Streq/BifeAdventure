extends Area2D

export var pepe_path : NodePath
onready var pepe = get_node(pepe_path)

export var bife_path : NodePath
onready var bife = get_node(bife_path)

var text = [
	"PEPE: me entere de la paliza que le diste al PIBE",
	"PEPE: muy bien BIFE, estoy orgulloso",
	"PEPE: te pido perdon por no dejarte salir del barrio, lo que hice fue un CRIMEN de PRIVACION de LIBERTAD",
	"PEPE: punible con penas de 6 meses a 3 años",
	"PEPE: entiendo si lo queres DENUNCIAR",
	"BIFE: dale, igual aca no hay comisaria",
	"PEPE: JAJA sos un CAPO",
	"PEPE: me entere que en el pueblo mas al suroeste de aca esta lleno de infelices", 
	"PEPE: creo que esta la hinchada de BOCA",
	"PEPE: por ahi puedas darles una mano",
	"BIFE: dale gracias PEPE",
	"PEPE: de nada MASTER",
	"BIFE: chau PEPE",
	"PEPE: CHAU MASTER"]

func _on_area_entered(area):
	trigger_by_passing()

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pepe.interact_action.connect("interacted", self, "trigger_by_talking")

func trigger_by_passing():
	bife.controller.active = false
	
	if bife.moving:
		yield(bife,"finish_step")

	#pepe turns to bife
	pepe.turn(Vector2(-1.0, 0.0))
	yield(get_tree(),"idle_frame")
	
	#pepe talks
	Textbox.add_text("PEPE: BIFE!")
	yield(Textbox,"text_display_finished")
	
	#pepe walks to bife
	pepe.controller.dir = Vector2(-1.0, 0.0)
	#white til pepe is next to bife
	while pepe.grid_position != bife.grid_position+Vector2(1.0,0.0):
		yield(pepe, "finish_step")
	
	
	#bife turns to pepe
#	yield(get_tree().create_timer(0.05), "timeout")
	bife.turn(Vector2(1.0, 0.0))
	yield(get_tree(),"idle_frame")
#	yield(get_tree().create_timer(0.2), "timeout")
	
	Textbox.add_texts(text)
	yield(Textbox, "text_display_finished")
	
	pepe.controller.dir = Vector2()
	bife.controller.active = true
	
	Globals.set_event(Globals.EVENT.pepe_talks_about_boca, true)
	
	
func trigger_by_talking(interacted, interactor, direction, grid):
	interacted.turn(-direction)
	interacted.bump()
	Textbox.add_texts(text)
	yield(Textbox, "text_display_finished")
	Globals.set_event(Globals.EVENT.pepe_talks_about_boca, true)

func _on_pepe_finished_talking():
	text = ["PEPE: SUERTE BIFE!"]
	
