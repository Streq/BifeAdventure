extends Node


func _ready():
	pass


func _on_dead():
	$Timer.start()


func _on_timeout():
	owner.queue_free()
