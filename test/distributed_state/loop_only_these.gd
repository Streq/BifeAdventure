extends Node
tool

export (PoolStringArray) var animations
export (bool) var update_animations setget _update_animations


var timeout = false
	
func _update_animations(val):
	var player =  get_parent()
	var player_animations = player.get_animation_list()
	for animation in player_animations:
		player.get_animation(animation).loop = false
	for animation in animations:
		if player.has_animation(animation):
			player.get_animation(animation).loop = true
