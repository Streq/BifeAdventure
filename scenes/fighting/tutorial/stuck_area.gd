extends Area2D

onready var timer = $Timer
var keep_checking = true
onready var guide = get_parent().get_node("pepe_clone")

func _on_area_entered(area):
	if keep_checking:
		timer.start()

func _on_area_exited(area):
	if keep_checking:
		timer.stop()


func _on_timeout():
	keep_checking = false
	yield(get_tree().create_timer(2.0),"timeout")
	if is_instance_valid(guide) and !guide.dead:
		Textbox.add_texts(["PEPE: PERDÓN me colgué un poquito",
		"PEPE: para hacer un buen SALTOPARED tienes que chocar con una pared en el aire",
		"PEPE: y SIN APRETAR NINGUNA DIRECCIÓN mantener PRESIONADO Z",
		"PEPE: hasta que tu personaje SE DESPEGUE de la PARED",
		"PEPE: una vez que agarres ritmo va a ser una BOLUDEZ"])
	yield(Textbox,"text_display_finished")
	get_parent().get_node("text").visible = true
	get_parent().get_node("how_to_wall_jump").queue_free()
