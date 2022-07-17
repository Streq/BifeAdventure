extends Node


func trigger(speed:float):
	owner.velocity.x += owner.get_facing_dir()*speed
