extends "controller.gd"
#block the player's path

#whether to move in horizontal axis
export var fix_horizontal := false

#whether to move in vertical axis
export var fix_vertical := false

#closest the player can be in horizontal tiles before we move, infinite if 0
export var sight_horizontal := 0

#closest the player can be in vertical tiles before we move, infinite if 0
export var sight_vertical := 0

var target = null


func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size()>0:
		target = players[0]

func get_direction(actor) -> Vector2:
	var dir = Vector2.ZERO
	if !fix_horizontal and (sight_vertical == 0 or sight_vertical > abs(target.position.y-actor.position.y)/Globals.TILE_SIZE):
		dir.x = sign(target.position.x-actor.position.x)
	if !fix_vertical and (sight_horizontal == 0 or sight_horizontal > abs(target.position.x-actor.position.x)/Globals.TILE_SIZE):
		dir.y = sign(target.position.y-actor.position.y)
		
	return dir
