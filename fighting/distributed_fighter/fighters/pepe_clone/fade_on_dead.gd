extends Node


func _ready():
	set_physics_process(false)


func _on_dead():
	$Timer.start()


func _on_timeout():
	set_physics_process(true)
	$ghosting_animation.play("ghost")
	yield($ghosting_animation,"animation_finished")
	
	owner.queue_free()


func _physics_process(delta):
	owner.set_pause(true)
