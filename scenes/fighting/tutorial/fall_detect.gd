extends Area2D

signal fell(text)

func _ready():
	connect("area_entered",self,"_on_body_entered")

func _on_body_entered(body):
	emit_signal("fell", "JAJA HUEVÓN")
