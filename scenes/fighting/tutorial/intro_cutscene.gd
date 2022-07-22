extends Node

export var disabled := false
export (NodePath) onready var pepe = get_node(pepe) as Node2D

onready var tween = $Tween



func _ready():
	if disabled:
		queue_free()
	else:
		owner.connect("ready",self,"_on_ready")

func _on_ready():
	if Globals.get_event(Globals.EVENT.tutorial_completed):
		pepe.queue_free()
		queue_free()
	else:
		Textbox.add_texts([
			"PEPE: hola BIFE, yo soy PEPE, ya sabes igual, porque me conoces de TODA la VIDA!",
			"BIFE: es verdad",
			"PEPE: es la PRIMERA vez que VENIS a mi GYM! asi que te voy a enseñar TODO",
			"PEPE: sigueme!"
		])
		yield(Textbox,"text_display_finished")
		get_tree().paused = true
		tween.interpolate_property(pepe,"position", pepe.position, pepe.position+Vector2(140.0, 0.0), 3.0)
		tween.start()
		yield(tween, "tween_all_completed")
		pepe.visible = false
		get_tree().paused = false
	
