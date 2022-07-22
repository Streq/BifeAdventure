extends Area2D

signal fell(text)



func _on_body_entered(body):
	emit_signal("fell", "JAJA HUEVÓN")
