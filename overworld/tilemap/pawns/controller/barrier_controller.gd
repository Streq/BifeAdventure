extends "controller.gd"

export var fix_horizontal := false
export var fix_vertical := false


var target = null


func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size()>0:
		target = players[0]

func get_direction(_actor) -> Vector2:
	var dir = Vector2.ZERO
	if !fix_horizontal:
		dir.x = sign(target.position.x-_actor.position.x)
	if !fix_vertical:
		dir.y = sign(target.position.y-_actor.position.y)
		
	return dir
