extends Node


func trigger(speed:float):
	owner.velocity.x += owner.get_facing_dir()*speed

func trigger_add_vertical(speed: Vector2):
	owner.velocity += Vector2(owner.get_facing_dir()*speed.x, speed.y)
