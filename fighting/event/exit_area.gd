extends Area2D
tool

export (Globals.ROOM) var where : int
export var tile : Vector2 = Vector2()
export var active : bool setget set_active

func set_active(val):
	active = val
	$Sprite.visible = val
	$CollisionShape2D.disabled = !val
	
func _on_body_entered(body):
	Globals.spawn_tile = tile
	get_tree().change_scene_to(Overworld.get_room(where))
