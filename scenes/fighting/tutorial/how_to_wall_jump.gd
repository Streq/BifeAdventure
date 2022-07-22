extends Area2D

var active = false

func _on_body_entered(body):
	if !active:
		active = true
		Textbox.add_texts(["PEPE: para hacer SALTO PARED hay que chocar con una PARED en el AIRE y apretar Z"])
